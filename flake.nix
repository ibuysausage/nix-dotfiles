{
  description = "My NixOS flake";

  nixConfig = {
    extra-substituters = [
      "https://niri-epireyn.cachix.org"
      "https://grub2-themes.cachix.org"
      "https://ibuysausage-nur.cachix.org"
      "https://ibuysausage-neovim-nightly"
      "https://nix-community.cachix.org"
      "https://fenix.cachix.org"
    ];

    extra-trusted-public-keys = [
      "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
      "grub2-themes.cachix.org-1:lmVtdlFNnVzVqgikQDgstzV0tdzA64pDxwEbyykfW14="
      "ibuysausage-nur.cachix.org-1:tqoAgFo/8AL/GhbOg9Cp9Fc46hHBnOCOw5V46knhH9I="
      "ibuysausage-neovim-nightly.cachix.org-1:J1fjIzyCnF+1ghND1VsiguOAKW1kVN6ISAoas7/g8Rk="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fenix.cachix.org-1:ecJhr+RdYEdcVgUkjruiYhjbBloIEGov7bos90cZi0Q="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    byte-nur = {
      url = "github:ibuysausage/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    disko,
    stylix,
    niri-flake,
    grub2-themes,
    fenix,
    sops-nix,
    nixvim,
    neovim-nightly-overlay,
    ...
  } @ inputs: {
    nixosConfigurations = {
      wildfire = let
        username = "byte";
        specialArgs = {inherit username inputs;};
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            ./hosts/wildfire/default.nix
            home-manager.nixosModules.home-manager
            nur.modules.nixos.default
            disko.nixosModules.disko
            stylix.nixosModules.stylix
            grub2-themes.nixosModules.default
            sops-nix.nixosModules.sops
            nixvim.nixosModules.nixvim
            {
              nixpkgs.overlays = [
                niri-flake.overlays.niri
                fenix.overlays.default
                neovim-nightly-overlay.overlays.default
              ];
            }
            {
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {inherit inputs;};
                sharedModules = [
                  niri-flake.homeModules.niri
                  niri-flake.homeModules.stylix
                  nixvim.homeModules.nixvim
                  nur.modules.homeManager.default
                ];
                users.${username} = import ./users/${username}/home.nix;
              };
            }
          ];
        };

      server01 = let
        username = "root";
        specialArgs = {inherit username inputs;};
      in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            stylix.nixosModules.stylix
            grub2-themes.nixosModules.default
            ./hosts/server01/default.nix
          ];
        };
    };
  };
}
