{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            rootMarkers = [
              "flake.nix"
              ".git"
            ];
            settings = {
              nixpkgs = {
                expr = "import <nixpkgs> {}";
                formatting = {
                  command = ["alejandra"];
                };
                options = {
                  nixos = {
                    expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.wildfire.options";
                  };
                  home_manager = {
                    expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.wildfire.options.home-manager.users.type.getSubOptions []";
                  };
                };
              };
            };
          };
          rust_analyzer = {
            enable = true;
            package = inputs.fenix.packages.${system}.complete.toolchain;
            rootMarkers = [
              "Cargo.toml"
              "Cargo.lock"
            ];

            # using nixvim extraPackages for cargo and rustc
            installCargo = false;
            installRustc = false;
          };
        };
      };

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
      };
    };

    extraPackages = [
      inputs.fenix.packages.${system}.complete.toolchain
    ];
  };
}
