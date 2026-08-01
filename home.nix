{ config, pkgs, ... }:

{
  home.username = "byte";
  home.homeDirectory = "/home/byte";

  home.stateVersion = "26.05";

  home.packages = [
    # pkgs.hello
  ];

  home.file = {
    "Pictures/Wallpapers" = {
      source = ./wallpapers;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
  
  programs.git = {
    enable = true;
    settings = {
      user.name = "ibuysausage";
      user.email = "bannansmooth68@proton.me";
    };
  };
}
