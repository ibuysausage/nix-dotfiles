{ config, pkgs, ... }:

{

  home.file."Pictures/Wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  home.file.".config/sway/status.sh" = {
    executable = true;
    source = ./scripts/status.sh;
  };

  home.file.".config/sway/volume.sh" = {
    executable = true;
    source = ./scripts/volume.sh;
  };

  home.file.".config/sway/brightness.sh" = {
    executable = true;
    source = ./scripts/brightness.sh;
  };

  xdg.configFile."rofi" = {
    source = ./rofi;
    recursive = true;
  };

  home.file.".config/ohmyposh/omp.toml" = {
    source = ./omp/omp.toml;
  };

  # home.file.".librewolf/profiles.ini" = {
  #   source = ./librewolf/profiles.ini;
  # };

  home.file.".librewolf/default/chrome/walls.css" = {
    source = ./librewolf/walls.css;
  };

  home.file.".librewolf/default/chrome/userChrome.css" = {
    source = ./librewolf/userChrome.css;
  };

  home.file.".librewolf/default/chrome/userContent.css" = {
    source = ./librewolf/userContent.css;
  };

  home.file.".librewolf/default/chrome/assets" = {
    source = ./librewolf/assets;
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

}
