{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    highlight-colors.enable = true;
    lazygit.enable = true;
    lualine.enable = true;
    oil.enable = true;
    web-devicons.enable = true;

    toggleterm = {
      enable = true;
      settings = {
        direction = "float";
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
          lua = ["stylua"];
        };
        formatters = {
          alejandra = {
            command = lib.getExe pkgs.alejandra;
          };
          stylua = {
            command = lib.getExe pkgs.stylua;
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
        filetypes_denylist = [
          "TelescopePrompt"
        ];
      };
    };
    trouble = {
      enable = true;
      settings = {
        auto_close = true;
        auto_preview = true;
        auto_refresh = true;
        focus = true;
        follow = true;
        multiline = true;
      };
    };
    lspkind = {
      enable = true;
      settings = {
        symbol_map = {
          Text = "󰊄";
          Method = " ";
          Function = "󰡱 ";
          Constructor = " ";
          Field = " ";
          Variable = "󱀍 ";
          Class = " ";
          Interface = " ";
          Module = "󰕳 ";
          Property = " ";
          Unit = " ";
          Value = " ";
          Enum = " ";
          Keyword = " ";
          Snippet = " ";
          Color = " ";
          File = "";
          Reference = " ";
          Folder = " ";
          EnumMember = " ";
          Constant = " ";
          Struct = " ";
          Event = " ";
          Operator = " ";
          TypeParameter = " ";
        };
      };
      cmp.enable = true;
    };
    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
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
