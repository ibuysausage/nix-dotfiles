{config, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 11;
    };

    autoThemeFiles = {
      dark = "tokyo_night_night";
      light = "tokyo_night_night";
      noPreference = "tokyo_night_night";
    };

    extraConfig = ''
      cursor_shape beam
      cursor_beam_thickness 1.8
      cursor_trail 200
      cursor_trail_decay 0.2 0.8
      cursor_trail_start_threshold 2
      mouse_hide_wait 4.0
      confirm_os_window_close 0
      tab_bar_style powerline
      tab_powerline_style round
      background_opacity 0.70
      shell_integration enabled
      kitty_mod ctrl+shift
      font_size 11
    '';
  };
}
