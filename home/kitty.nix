{...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    extraConfig = ''
      enable_audio_bell no
      cursor_shape beam
      cursor_beam_thickness 1.8
      cursor_trail 200
      cursor_trail_decay 0.2 0.8
      cursor_trail_start_threshold 2
      mouse_hide_wait 4.0
      confirm_os_window_close 0
      tab_bar_style powerline
      tab_powerline_style round
      shell_integration enabled
      allow_remote_control yes
      listen_on unix:/tmp/kitty
      kitty_mod ctrl+shift
    '';
  };
}
