{...}: {
  imports = [
    ../../home/emacs.nix
    ../../home/git.nix
    ../../home/homefile.nix
    ../../home/kitty.nix
    ../../home/omp.nix
    ../../home/stylix.nix
    ../../home/zinc/single.nix
    ../../home/zinc/sops.nix
    ../../home/zinc/zsh.nix
  ];

  home = {
    username = "zinc";
    homeDirectory = "/home/zinc";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
