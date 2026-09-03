{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  # test
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    enableMan = true;

    globals.mapleader = " ";

    opts = {
      clipboard = "unnamedplus";
      termguicolors = true;

      # tab settings
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      shiftround = true;
      smartindent = true;

      # linenumbers
      number = true;
      relativenumber = true;
      wrap = false;
      cursorline = true;
      scrolloff = 10;

      # search
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = true;
    };

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
                  command = [ "alejandra" ];
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
      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };
          formaters_by_ft = {
            nix = [ "alejandra" ];
          };
          formatters = {
            alejandra = {
              command = lib.getExe pkgs.alejandra;
            };
          };
        };
      };
      lspkind.enable = true;
      highlight-colors.enable = true;
      lazygit.enable = true;
      lualine.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<CR>";
        action = "o<ESC>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>t";
        action = "<cmd>ToggleTerm<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options.silent = true;
      }
    ];

    extraPackages = [
      inputs.fenix.packages.${system}.complete.toolchain
    ];
  };
}
