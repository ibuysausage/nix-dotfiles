{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    historyLimit = 10000;

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
        '';
      }
    ];

    extraConfig = ''
      set -g status-position top
    '';
  };
}
