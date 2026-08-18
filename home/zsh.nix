{ config, ... }:

{

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      ff = "clear; fastfetch";
      c = "clear";
      ls = "eza --icons always";
      tree = "eza -T --icons always";
      dockerclean = "docker system prune -a --volumes";
    };

    history = {
      path = "${config.home.homeDirectory}/.histfile";
      size = 100;
      save = 100;
    };

    # I have no clue about the unsetopt
    # Without it !! would be ls

    initContent = ''
      fastfetch
      unsetopt BANG_HIST
    '';
  };

}
