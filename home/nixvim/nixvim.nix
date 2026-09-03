{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.nixvim = {
    plugins = {
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
      nvim-autopairs.enable = true;
      indent-blankline = {
        enable = true;
      };
      illuminate = {
        enable = true;
        settings = {
          under_cursor = false;
          filetypes_denylist = [
            "Outline"
            "TelescopePrompt"
            "alpha"
            "harpoon"
            "reason"
            "snacks_dashboard"
          ];
        };
      };
      mini = {
        enable = true;

        modules = {
          indentscope = {
            symbol = "│";
            options = {
              try_as_border = true;
            };
          };
          surround = { };
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
      inputs.fenix.packages.${pkgs.system}.complete.toolchain
    ];
  };
}
