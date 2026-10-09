{...}: {
  imports = [
    ../../home/chromium.nix
    ../../home/emacs.nix
    ../../home/fastfetch.nix
    ../../home/firefox.nix
    ../../home/git.nix
    ../../home/homefile.nix
    ../../home/kitty.nix
    ../../home/librewolf.nix
    ../../home/nixvim
    ../../home/omp.nix
    ../../home/rofi.nix
    ../../home/single.nix
    ../../home/sops.nix
    ../../home/stylix.nix
    ../../home/sway.nix
    ../../home/swaylock.nix
    ../../home/zsh.nix
  ];

  home = {
    username = "byte";
    homeDirectory = "/home/byte";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
