{ config, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    waylandSupport = true;

    extraConfig = ''
      vim.opt.clipboard = "unnamedplus"
    '';
  };

}
