{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
          formatting = {
            fields = [
              "kind"
              "abbr"
              "icon"
              "menu"
            ];
          };
          window = {
            completion = {
              border = "solid";
            };
            documentation = {
              border = "solid";
            };
          };
          mapping = {
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };
      cmp-nvim-lsp = {
        enable = true;
      };
    };
    extraConfigLua = ''
      kind_icons = {
        Text = "󰊄",
        Method = " ",
        Function = "󰡱 ",
        Constructor = " ",
        Field = " ",
        Variable = "󱀍 ",
        Class = " ",
        Interface = " ",
        Module = "󰕳 ",
        Property = " ",
        Unit = " ",
        Value = " ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = "",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      }
    '';
  };
}
