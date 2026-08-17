rebuild:
    sudo nixos-rebuild switch --flake

update:
    nix flake update

clean:
    nix store gc && nix store optimise
