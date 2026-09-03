{ ... }: {
  programs.nixvim.plugins = {
    lspkind.enable = true;
    highlight-colors.enable = true;
    lazygit.enable = true;
    lualine.enable = true;
  };

}
