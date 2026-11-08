_: {
  programs.tmux = {
    enable = true;
    prefix = "C-x";
    baseIndex = 1;
    historyLimit = 10000;

    extraConfig = ''
      set -g status-position top
    '';
  };
}
