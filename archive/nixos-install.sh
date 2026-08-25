#!/usr/bin/env bash
# ------------------------------------------------------------------
#  nix-dotfiles installer — pick a host, wipe the disk, go.
# ------------------------------------------------------------------
set -euo pipefail

export NIX_CONFIG="experimental-features = nix-command flakes
accept-flake-config = true"

DEFAULT_REPO="ibuysausage/nix-dotfiles"

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
  printf "%s\n" "${RESET}${CYAN}${BOLD}       nixox flake installer${RESET}"
  hr
}

step()    { printf "\n%s\n" "${BLUE}${BOLD}➜ $*${RESET}"; }
info()    { printf "%s\n" "${DIM}  $*${RESET}"; }
success() { printf "%s\n" "${GREEN}${BOLD}✔ $*${RESET}"; }
warn()    { printf "%s\n" "${YELLOW}${BOLD}⚠ $*${RESET}"; }
error()   { printf "%s\n" "${RED}${BOLD}✘ $*${RESET}" >&2; }

# Figures out REPO_URL (for git clone) and FLAKE_REF (for nix) from
# whatever format the user typed in: owner/repo, github:owner/repo,
# gitlab:owner/repo, sourcehut:~owner/repo, or a full git URL.
normalize_repo() {
  local input="$1"
  case "${input}" in
    github:*|gitlab:*|sourcehut:*)
      FLAKE_REF="${input}"
      local rest="${input#*:}"
      case "${input}" in
        github:*) REPO_URL="https://github.com/${rest}.git" ;;
        gitlab:*) REPO_URL="https://gitlab.com/${rest}.git" ;;
        sourcehut:*) REPO_URL="https://git.sr.ht/${rest}" ;;
      esac
      ;;
    git+*)
      FLAKE_REF="${input}"
      REPO_URL="${input#git+}"
      ;;
    http://*|https://*|git@*)
      REPO_URL="${input}"
      if [[ "${input}" == *github.com* ]]; then
        local owner_repo
        owner_repo="$(printf '%s' "${input}" | sed -E 's#.*github\.com[:/]+([^/]+/[^/.]+)(\.git)?/?$#\1#')"
        FLAKE_REF="github:${owner_repo}"
      else
        FLAKE_REF="git+${input}"
      fi
      ;;
    */*)
      FLAKE_REF="github:${input}"
      REPO_URL="https://github.com/${input}.git"
      ;;
    *)
      error "Couldn't understand '${input}' as a repo reference."
      return 1
      ;;
  esac
}

banner

step "Which configuration repository do you want to install?"
info "Accepts: owner/repo, github:owner/repo, gitlab:owner/repo, or a full git URL"
printf "%s" "${CYAN}${BOLD}Repository [${DEFAULT_REPO}]: ${RESET}"
read -r repo_input
repo_input="${repo_input:-${DEFAULT_REPO}}"

if ! normalize_repo "${repo_input}"; then
  exit 1
fi
success "Using ${FLAKE_REF}"
info "(clone source: ${REPO_URL})"

IS_OWN_REPO=false
[[ "${FLAKE_REF}" == "github:${DEFAULT_REPO}" ]] && IS_OWN_REPO=true

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

# ---------- clear out any leftovers from a previous attempt ----------
step "Garbage-collecting any store paths from earlier attempts"
nix-collect-garbage -d >/dev/null 2>&1 || true
success "Store cleaned up"

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
step "Cloning configuration into /mnt/etc/nixos"
git clone "${REPO_URL}" /mnt/etc/nixos
success "Config cloned"

# ---------- hardware config check ----------
step "Generating hardware configuration for review"
info "Probing the actual mounted system at /mnt (filesystems skipped — disko owns those)"
if [[ "${IS_OWN_REPO}" == true ]]; then
  HW_DIR="/etc/nixos/hosts/${host}"
else
  HW_DIR="/tmp/hwcheck"
  info "Using a neutral output dir since this isn't your own repo layout"
fi
nixos-generate-config --root /mnt --no-filesystems --dir "${HW_DIR}"
success "Hardware check written to ${HW_DIR}/hardware-configuration.nix"
info "Compare it against /mnt/etc/nixos/hosts/${host}/hardware-configuration.nix if that file exists"

# ---------- install ----------
step "Running nixos-install for ${host}"
nixos-install --root /mnt --flake "/mnt/etc/nixos#${host}"

hr
success "Installation complete for ${BOLD}${host}${RESET}${GREEN}${BOLD}!"
info "You can reboot into your new system now."
hr
