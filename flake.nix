{
  description = "My NixOS flake";

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
            {
              nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
            }
            {
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = {inherit inputs;};
                sharedModules = [
                  # stylix home module is auto imported
                  niri-flake.homeModules.niri
                  niri-flake.homeModules.stylix
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
