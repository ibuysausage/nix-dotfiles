_: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    historyLimit = 10000;

    extraConfig = ''
      set -g status-position top
    '';
  };
}
