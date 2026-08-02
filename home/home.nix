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
    ./firefox.nix
  ];  

  # Add pkgs to top
  home.packages = with pkgs; [
    # inputs.nur.legacyPackages.x86_64-linux.repos.rycee.firefox-addons.ublock-origin
    # hello
  ];

  home.username = "byte";
  home.homeDirectory = "/home/byte";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

}
