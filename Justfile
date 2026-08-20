# Justfile

default: fmt update rebuild hm clean


rebuild:
    git add --all
    niri validate -c ./home/niri/config.kdl
    sudo nixos-rebuild switch --flake

hm user="byte":
    systemctl restart home-manager-{{user}}

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

fmt:
    alejandra *

flake-lock:
    git add --all
    git commit -m 'Update flake.lock'
    git push
