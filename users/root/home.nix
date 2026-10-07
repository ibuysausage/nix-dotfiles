{...}: {
  imports = [
    ../../home/emacs.nix
    ../../home/fastfetch.nix
    ../../home/firefox.nix
    ../../home/git.nix
    ../../home/homefile.nix
    ../../home/kitty.nix
    ../../home/omp.nix
    ../../home/rofi.nix
    ../../home/single.nix
    ../../home/stylix.nix
    ../../home/sway-01.nix
    ../../home/swaylock.nix
    ../../home/zsh.nix
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
