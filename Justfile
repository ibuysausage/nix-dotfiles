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
    git add --all
    git commit -m '{{string}}'
    git push

permissions:
    sudo find ./ -type d -exec chmod 0755 {} +
    sudo find ./ -type f -name '*.sh' -exec chmod 0755 {} +
    sudo find ./ -type f ! -name '*.sh' -exec chmod 0644 {} +
    sudo chown -R 1000:100 ./
