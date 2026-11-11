{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    historyLimit = 10000;
    disableConfirmationPrompt = false;

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'

          set -g status-left ""
          set -g status-right-length 100
          set -g status-right "#{E:@catppuccin_status_uptime}"
          set -ag status-right '#[fg=#{@thm_crust},bg=#{@thm_lavender}] session: #S '

          set -g @catppuccin_window_text " #W"
          set -g @catppuccin_window_current_text " #W"
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
      }
    ];

    extraConfig = ''
      set -g status-position top
    '';
  };
}
