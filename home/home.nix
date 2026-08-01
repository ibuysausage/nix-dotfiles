{ config, pkgs, ... }:

{

  imports = [
    ./sway.nix
    ./swaylock.nix
    ./git.nix
    ./zsh.nix
    ./kitty.nix
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

  home.file.".config/ohmyposh/omp.toml" = {
    source = ./omp/omp.toml;
  };

  home.username = "byte";
  home.homeDirectory = "/home/byte";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

}
