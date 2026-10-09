{...}: {
  imports = [
    # ../../home/librewolf.nix
    # ../../home/nixvim
    # ../../home/sops.nix
    ../../home/chromium.nix
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
    ../../home/swaylock.nix
    ../../home/zinc/sway.nix
    ../../home/zsh.nix
  ];

  home = {
    username = "zinc";
    homeDirectory = "/home/zinc";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
