{ config, ... }:

{

  programs.kitty = {
    enable = true;

    autoThemeFiles = {
      dark = "purpurite";
      light = "purpurite";
      noPreference = "purpurite";
    };
  };

}
