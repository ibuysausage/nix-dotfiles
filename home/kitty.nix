{ config, ... }:

{

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    font = {
      name = "CaskaydiaCove Nerd Font Mono";
      size = 11;
    };

    autoThemeFiles = {
      dark = "purpurite";
      light = "purpurite";
      noPreference = "purpurite";
    };

    extraConfig = ''
      background_opacity 0.95
    '';
  };

}
