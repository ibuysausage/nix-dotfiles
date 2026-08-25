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
  printf "%s\n" "${RESET}${CYAN}${BOLD}       nix-dotfiles installer${RESET}"
  hr
}

step()    { printf "\n%s\n" "${BLUE}${BOLD}➜ $*${RESET}"; }
info()    { printf "%s\n" "${DIM}  $*${RESET}"; }
success() { printf "%s\n" "${GREEN}${BOLD}✔ $*${RESET}"; }
warn()    { printf "%s\n" "${YELLOW}${BOLD}⚠ $*${RESET}"; }
error()   { printf "%s\n" "${RED}${BOLD}✘ $*${RESET}" >&2; }

banner

# ---------- discover available hosts from the flake ----------
step "Looking up available host configurations from ${FLAKE_REF}"
info "(this may take a while)"

HOSTS_JSON="$(nix eval --json "${FLAKE_REF}#nixosConfigurations" --apply builtins.attrNames 2>/dev/null || true)"

if [[ -z "${HOSTS_JSON}" || "${HOSTS_JSON}" == "[]" ]]; then
  error "Couldn't find any nixosConfigurations in ${FLAKE_REF}."
  error "Check your network connection and that the flake evaluates."
  exit 1
fi

readarray -t HOSTS < <(printf '%s' "${HOSTS_JSON}" | tr -d '[]"' | tr ',' '\n' | sed '/^$/d')

success "Found ${#HOSTS[@]} host configuration(s)"

# ---------- ask the user which one ----------
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
nixos-generate-config --root /mnt --no-filesystems --dir /mnt/etc/nixos/hosts/${host}
success "Hardware check written to /mnt/etc/nixos/${host}/hardware-configuration.nix"
info "Compare it against /mnt/etc/nixos/${host}/hardware-configuration.nix if that file exists"

# ---------- install ----------
step "Running nixos-install for ${host}"
nixos-install --root /mnt --flake "/mnt/etc/nixos#${host}"

hr
success "Installation complete for ${BOLD}${host}${RESET}${GREEN}${BOLD}!"
info "You can reboot into your new system now."
hr
