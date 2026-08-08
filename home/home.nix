{ config, pkgs, ... }:

{

  imports = [
    ./homefile.nix
    ./sway.nix
    ./swaylock.nix
    ./git.nix
    ./zsh.nix
    ./kitty.nix
    ./librewolf.nix
    ./nvim.nix
  ];

  # Add pkgs to top
  home.packages = with pkgs; [
    # inputs.nur.legacyPackages.x86_64-linux.repos.rycee.firefox-addons.ublock-origin
    # hello
  ];

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  home.username = "byte";
  home.homeDirectory = "/home/byte";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

}
