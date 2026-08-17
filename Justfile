# Justfile

default: update rebuild clean

rebuild:
    git add .
    sudo nixos-rebuild switch --flake

update:
    nix flake update

clean:
    nix store gc && nix store optimise

git string:
    git add .
    git commit -m '{{string}}'
    git push
