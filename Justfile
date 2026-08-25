# ════════════════════════════════════════════════════════════════════════
#  Justfile — NixOS flake config (host: wildfire, user: byte)
# ════════════════════════════════════════════════════════════════════════
#  Requires: just, git, nix (with flakes + nix-command enabled)
#  Run `just` with no args to see this list.
# ════════════════════════════════════════════════════════════════════════

set shell := ["bash", "-euo", "pipefail", "-c"]
set positional-arguments

flake  := justfile_directory()
host   := `hostname`
user   := "byte"

# Show all available recipes
default:
    @just --list --unsorted

# ── internal helper ───────────────────────────────────────────────────
# Flakes only see files known to git. `-N` (intent-to-add) makes new
# files visible to `nix build` etc. without staging their *contents*,
# so it never pollutes your next real commit.
[private]
_stage:
    @cd {{flake}} && git add -A -N . >/dev/null 2>&1 || true

# ═══ build & activate ═══════════════════════════════════════════════════

# Build the system closure without activating it (result -> ./result)
[group('build')]
build host=host: _stage
    nix build {{flake}}#nixosConfigurations.{{host}}.config.system.build.toplevel --print-build-logs

# Show exactly what a switch would change, without building/activating
[group('build')]
dry host=host: _stage
    sudo nixos-rebuild dry-activate --flake {{flake}}#{{host}}

# Build + activate right now (reverts on next reboot if not also `boot`)
[group('deploy')]
switch host=host: _stage
    sudo nixos-rebuild switch --flake {{flake}}#{{host}} --print-build-logs --show-trace

# Build + activate, but only keep it until the next reboot (safe to try risky changes)
[group('deploy')]
test host=host: _stage
    sudo nixos-rebuild test --flake {{flake}}#{{host}} --print-build-logs

# Build + set as the default boot entry, activate on next reboot
[group('deploy')]
boot host=host: _stage
    sudo nixos-rebuild boot --flake {{flake}}#{{host}} --print-build-logs

# Deploy to a remote machine over SSH, e.g. `just deploy root@10.0.0.5 wildfire`
[group('deploy')]
deploy target host=host: _stage
    nixos-rebuild switch --flake {{flake}}#{{host}} \
        --target-host {{target}} --use-remote-sudo --build-host localhost

# ═══ home-manager ════════════════════════════════════════════════════════

# Rebuild only the home-manager profile (useful if you ever split it from the system switch)
[group('home')]
home host=host: _stage
    home-manager switch --flake {{flake}}#{{user}}@{{host}} -b backup

# ═══ fresh install / disko ═══════════════════════════════════════════════

# DESTRUCTIVE: partition + format disks exactly as declared in disko.nix
[group('disko')]
[confirm("This will WIPE the disk(s) defined in disko.nix. Continue?")]
disko-format:
    sudo nix run github:nix-community/disko -- --mode disko {{flake}}/disko.nix

# Mount (without formatting) — for repairing/chrooting into an existing disko layout
[group('disko')]
disko-mount:
    sudo nix run github:nix-community/disko -- --mode mount {{flake}}/disko.nix

# Full fresh install onto a booted installer medium: disko + nixos-install
[group('disko')]
[confirm("This wipes the target disk(s) and installs NixOS. Continue?")]
install host=host:
    sudo nix run github:nix-community/disko -- --mode destroy,format,mount {{flake}}/disko.nix
    sudo nixos-install --flake {{flake}}#{{host}} --no-root-passwd

# ═══ maintenance ══════════════════════════════════════════════════════════

# Update every flake input
[group('maintenance')]
update:
    nix flake update --flake {{flake}}

# Update a single input, e.g. `just update-input nixpkgs`
[group('maintenance')]
update-input input:
    nix flake lock --update-input {{input}} --flake {{flake}}

# Garbage-collect old generations (default: anything older than 7 days)
[group('maintenance')]
gc days="7d":
    sudo nix-collect-garbage --delete-older-than {{days}}
    nix store gc
    nix store optimise

# List system generations
[group('maintenance')]
generations:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Roll back and immediately activate the previous generation
[group('maintenance')]
rollback:
    sudo nixos-rebuild switch --rollback

[group('maintenance')]
permissions:
    sudo find {{flake}}  -type d -exec chmod 0755 {} +
    sudo find {{flake}}  -type f -name '*.sh' -exec chmod 0755 {} +
    sudo find {{flake}} -type f ! -name '*.sh' -exec chmod 0644 {} +
    sudo chown -R 1000:100 {{flake}}

[group('maintenance')]
flake-lock:
    gh workflow run "Update flake.lock"

# ═══ checks & quality ═════════════════════════════════════════════════════

# Evaluate + check the flake (all systems) for obvious breakage
[group('check')]
check:
    nix flake check {{flake}} --all-systems

# Format every .nix file with alejandra
[group('check')]
fmt:
    nix run nixpkgs#alejandra -- {{flake}}

# Static analysis: statix (antipatterns) + deadnix (dead code)
[group('check')]
lint:
    nix run nixpkgs#statix -- check {{flake}}
    nix run nixpkgs#deadnix -- {{flake}}

# Diff the closure that would be built against what's currently running
[group('check')]
diff host=host:
    nix build {{flake}}#nixosConfigurations.{{host}}.config.system.build.toplevel --out-link /tmp/just-diff-result
    nix run nixpkgs#nvd -- diff /run/current-system /tmp/just-diff-result

# ═══ exploration / dev ═══════════════════════════════════════════════════

# Drop into a repl with `pkgs`, `inputs`, and `self` in scope
[group('dev')]
repl:
    nix repl -f {{flake}}

# Build & boot a throwaway VM of a host to test changes before touching bare metal
[group('dev')]
vm host=host: _stage
    nix build {{flake}}#nixosConfigurations.{{host}}.config.system.build.vm --out-link /tmp/just-vm-result
    /tmp/just-vm-result/bin/run-*-vm

# List every host defined in this flake
[group('info')]
hosts:
    nix eval {{flake}}#nixosConfigurations --apply builtins.attrNames --json | nix run nixpkgs#jq -- -r '.[]'

# Show the full flake output tree
[group('info')]
show:
    nix flake show {{flake}}

# Show locked input revisions and last-modified dates
[group('info')]
metadata:
    nix flake metadata {{flake}}

# Search nixpkgs, e.g. `just search ripgrep`
[group('info')]
search pkg:
    nix search nixpkgs {{pkg}}

# ═══ git ══════════════════════════════════════════════════════════════════

# Stage, commit, and push the whole config in one go
[group('git')]
save msg="update config":
    cd {{flake}} && git add -A && git commit -m "{{msg}}" && git push
