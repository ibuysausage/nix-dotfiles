{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    lspkind.enable = true;
    highlight-colors.enable = true;
    lazygit.enable = true;
    lualine.enable = true;
    web-devicons.enable = true;

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
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
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
        formatters_by_ft = {
          nix = ["alejandra"];
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
        ];
      };
    };
    telescope = {
      enable = true;
      extensions = {
        fzf-native = {
          settings.case_mode = "ignore_case";
        };
      };
      settings = {
        defaults = {
          layout_config = {
            prompt_position = "top";
          };
        };
      };
      keymaps = {
        "<leader><space>" = {
          action = "find_files";
          options = {
            desc = "find project files";
          };
        };
        "<leader>/" = {
          action = "live_grep";
          options = {
            desc = "grep (root dir)";
          };
        };
        "<leader>b" = {
          action = "buffers";
          options = {
            desc = "+buffer";
          };
        };
        "<leader>:" = {
          action = "command_history";
          options = {
            desc = "command history";
          };
        };
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
        surround = {};
      };
    };
  };
}
