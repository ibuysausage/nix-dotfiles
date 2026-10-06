{...}: {
  imports = [
    ../../home/homefile.nix
    ../../home/single.nix
    ../../home/sway.nix
    ../../home/swaylock.nix
    ../../home/git.nix
    ../../home/zsh.nix
    ../../home/kitty.nix
    ../../home/rofi.nix
    ../../home/firefox.nix
    ../../home/stylix.nix
    ../../home/emacs.nix
    ../../home/fastfetch.nix
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
