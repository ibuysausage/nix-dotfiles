{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    waylandSupport = true;
    withPython3 = true;

    extraConfig = ''
      vim.opt.clipboard = "unnamedplus"
      vim.opt.termguicolors = true
    '';
  };
}
