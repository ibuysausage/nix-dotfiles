{pkgs, ...}: {
  imports = [
    ../../home/homefile.nix
    ../../home/single.nix
    ../../home/sway.nix
    ../../home/swaylock.nix
    ../../home/git.nix
    ../../home/zsh.nix
    ../../home/kitty.nix
    ../../home/librewolf.nix
    ../../home/omp.nix
    ../../home/rofi.nix
    ../../home/firefox.nix
    ../../home/stylix.nix
    ../../home/nixvim
    ../../home/emacs.nix
    ../../home/fastfetch.nix
  ];

  home.packages = [pkgs.nur.repos.mich-adams.afterglow-cursors];

  home.username = "byte";
  home.homeDirectory = "/home/byte";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
