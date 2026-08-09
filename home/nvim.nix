{ config, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = "";
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

}
