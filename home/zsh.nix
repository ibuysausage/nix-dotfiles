{ config, ... }:

{

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ff="clear; fastfetch";
      c="clear";
      ls = "eza --icons";
      tree = "eza -T --icons";
    };
    
    history = {
      path = "${config.home.homeDirectory}/.histfile";
      size = 100;
      save = 100;
    };

    initContent = ''
      fastfetch
      bindkey -v
    '';
  };

}
