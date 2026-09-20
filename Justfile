set shell := ["bash", "-euo", "pipefail", "-c"]
set positional-arguments

flake  := justfile_directory()
host   := `hostname`
user   := "byte"

default:
  @just --list --unsorted

[private]
_stage:
    @cd {{flake}} && git add -A -N . >/dev/null 2>&1 || true


[group('deploy')]
switch host=host: _stage
    sudo nixos-rebuild switch --flake {{flake}}#{{host}} --print-build-logs

[group('deploy')]
test host=host: _stage
    sudo nixos-rebuild test --flake {{flake}}#{{host}} --print-build-logs

[group('deploy')]
deploy target host=host: _stage
    nixos-rebuild switch --flake {{flake}}#{{host}} \
        --target-host {{target}}

# Garbage-collect old generations (default: anything older than 7 days)
[group('maintenance')]
gc days="7d":
    sudo nix-collect-garbage --delete-older-than {{days}}
    nix store optimise

# List system generations
[group('maintenance')]
generations:
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Roll back and immediately activate the previous generation
[group('maintenance')]
rollback:
    sudo nixos-rebuild switch --rollback

# Fix permissions if cloned as root during install
[group('maintenance')]
permissions:
    sudo find {{flake}} -type d -exec chmod 0755 {} +
    sudo find {{flake}} -type f -name '*.sh' -exec chmod 0755 {} +
    sudo find {{flake}} -type f ! -name '*.sh' -exec chmod 0644 {} +
    sudo chown -R 1000:100 {{flake}}

# Runs the update flake.lock github action
[group('maintenance')]
flake-lock:
    gh workflow run "Update flake.lock"

# Automatically allows all devenv projects and garbage collects
[group('maintenance')]
devenv:
    find ~ -name devenv.nix -type f -execdir sh -c 'cd "$(dirname "$1")" && devenv allow' _ {} \;
    find ~ -name devenv.nix -type f -execdir sh -c 'cd "$(dirname "$1")" && devenv update' _ {} \;
    devenv gc
    @rm -rf /etc/nixos/.devenv
    @rm -rf /etc/nixos/devenv*
[group('maintenance')]
backup:
    tar -cvzf /tmp/{{user}}.tar.gz ~
    tar -cvf /tmp/ssh.tar ~/.ssh
    @# add age
    tar -cvf /tmp/vvvvvv.tar ~/.local/share/VVVVVV
    tar -cvf /tmp/nvim-spell.tar ~/.local/share/nvim/site/spell

# Format every .nix file with alejandra
[group('check')]
fmt:
    nix run nixpkgs#alejandra -- {{flake}}

# Static analysis: statix (antipatterns) + deadnix (dead code)
[group('check')]
lint:
    nix run nixpkgs#statix -- check {{flake}}
    nix run nixpkgs#deadnix -- {{flake}}

