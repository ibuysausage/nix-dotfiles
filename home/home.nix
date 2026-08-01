{ config, pkgs, ... }:

{

  imports = [
    ./sway.nix
    ./git.nix
  ];  

  home.packages = with pkgs; [
    # hello
  ];


  home.file."Pictures/Wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  home.file.".config/sway/status.sh" = {
    source = ./scripts/status.sh;
  };

  home.file.".config/rofi" = {
    source = ./themes/rofi;
  };

  home.username = "byte";
  home.homeDirectory = "/home/byte";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

}
