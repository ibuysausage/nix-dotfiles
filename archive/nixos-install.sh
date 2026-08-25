#!/usr/bin/env bash
# ------------------------------------------------------------------
#  nix-dotfiles installer — pick a host, wipe the disk, go.
# ------------------------------------------------------------------
set -euo pipefail

export NIX_CONFIG="experimental-features = nix-command flakes"

REPO_URL="https://github.com/ibuysausage/nix-dotfiles.git"
FLAKE_REF="github:ibuysausage/nix-dotfiles"

# ---------- colors ----------
RESET=$'\e[0m'
BOLD=$'\e[1m'
DIM=$'\e[2m'
RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
BLUE=$'\e[34m'
MAGENTA=$'\e[35m'
CYAN=$'\e[36m'

hr() { printf "%s\n" "${DIM}────────────────────────────────────────────────────────${RESET}"; }

banner() {
  clear
  printf "%s\n" "${MAGENTA}${BOLD}"
  cat <<'EOF'
   _   _ _       ____   ____ 
  | \ | (_)_  __/ __ \ / ___|
  |  \| | \ \/ / |  | |\___ \
  | |\  | |>  <| |__| | ___) |
  |_| \_|_/_/\_\\____/ |____/
EOF
  printf "%s\n" "${RESET}${CYAN}${BOLD}       nixox + dotfiles installer${RESET}"
  hr
}

step()    { printf "\n%s\n" "${BLUE}${BOLD}➜ $*${RESET}"; }
info()    { printf "%s\n" "${DIM}  $*${RESET}"; }
success() { printf "%s\n" "${GREEN}${BOLD}✔ $*${RESET}"; }
warn()    { printf "%s\n" "${YELLOW}${BOLD}⚠ $*${RESET}"; }
error()   { printf "%s\n" "${RED}${BOLD}✘ $*${RESET}" >&2; }

banner

# ---------- give the live installer more breathing room ----------
# On low-RAM machines the installer's root is tmpfs-backed, and evaluating
# a flake (fetching nixpkgs, etc.) can fill it before the disk is even
# touched. A zram swap device buys headroom without writing to disk.
step "Setting up temporary zram swap (compressed RAM) for headroom"
if modprobe zram 2>/dev/null && [[ -e /sys/class/zram-control/hot_add ]]; then
  ZRAM_DEV="/dev/zram$(cat /sys/class/zram-control/hot_add)"
  echo zstd > "/sys/block/$(basename "${ZRAM_DEV}")/comp_algorithm" 2>/dev/null || true
  echo 4G > "/sys/block/$(basename "${ZRAM_DEV}")/disksize"
  mkswap "${ZRAM_DEV}" >/dev/null
  swapon "${ZRAM_DEV}"
  success "zram swap active on ${ZRAM_DEV} (4G)"
else
  warn "Couldn't set up zram swap (module unavailable) — continuing without it"
fi

# ---------- discover available hosts from the flake ----------
step "Looking up available host configurations from ${FLAKE_REF}"
info "This evaluates the flake over the network — this may take a while on first run"
info "while it fetches nixpkgs and other inputs. Progress is shown below."

HOSTS_JSON=""
if HOSTS_JSON="$(timeout 180 nix eval --json "${FLAKE_REF}#nixosConfigurations" --apply builtins.attrNames)"; then
  :
else
  warn "Couldn't fetch the host list (network issue, or it timed out after 3 min)."
fi

if [[ -z "${HOSTS_JSON}" || "${HOSTS_JSON}" == "[]" ]]; then
  warn "Falling back to manual entry."
  info "Check your network (e.g. 'ping github.com') if this keeps happening."
  printf "%s" "${CYAN}${BOLD}Enter the host name to install: ${RESET}"
  read -r host
  if [[ -z "${host}" ]]; then
    error "No host name given, aborting."
    exit 1
  fi
  HOSTS=("${host}")
else
  readarray -t HOSTS < <(printf '%s' "${HOSTS_JSON}" | tr -d '[]"' | tr ',' '\n' | sed '/^$/d')
  success "Found ${#HOSTS[@]} host configuration(s)"
fi

# ---------- ask the user which one (skip if we already got it via manual entry) ----------
if [[ -z "${host:-}" ]]; then
  printf "\n%s\n" "${CYAN}${BOLD}Which host are you installing?${RESET}"
  hr
  PS3="${MAGENTA}${BOLD}Select a host (number): ${RESET}"
  select host in "${HOSTS[@]}"; do
    if [[ -n "${host:-}" ]]; then
      break
    else
      warn "Not a valid choice, try again."
    fi
  done
  hr
fi
success "Selected host: ${BOLD}${host}${RESET}"

# ---------- final confirmation, because this destroys the disk ----------
printf "\n%s\n" "${RED}${BOLD}⚠  THIS WILL DESTROY ALL DATA on the target disk for '${host}'.${RESET}"
warn "This step formats and partitions using disko — it cannot be undone."
printf "%s" "${YELLOW}Type the host name (${BOLD}${host}${RESET}${YELLOW}) to confirm: ${RESET}"
read -r confirm
if [[ "${confirm}" != "${host}" ]]; then
  error "Confirmation did not match. Aborting, nothing was touched."
  exit 1
fi

# ---------- disko: partition, format, mount ----------
step "Partitioning and formatting disk via disko (${host})"
nix run github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  --flake "${FLAKE_REF}#${host}"
success "Disk partitioned, formatted, and mounted"

# ---------- clone config ----------
step "Cloning nix-dotfiles into /mnt/etc/nixos"
git clone "${REPO_URL}" /mnt/etc/nixos
success "Config cloned"

# ---------- hardware config check ----------
step "Generating hardware configuration for review"
info "Probing the actual mounted system at /mnt (filesystems skipped — disko owns those)"
nixos-generate-config --root /mnt --no-filesystems --dir /etc/nixos/hosts/${host}
success "Hardware check written to /tmp/hwcheck/hardware-configuration.nix"
info "Compare it against /mnt/etc/nixos/hosts/${host}/hardware-configuration.nix if that file exists"

# ---------- install ----------
step "Running nixos-install for ${host}"
nixos-install --root /mnt --flake "/mnt/etc/nixos#${host}"

hr
success "Installation complete for ${BOLD}${host}${RESET}${GREEN}${BOLD}!"
info "You can reboot into your new system now."
hr
