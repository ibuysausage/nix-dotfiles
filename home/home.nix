{...}: {
  imports = [
    ./homefile.nix
    ./sway.nix
    ./swaylock.nix
    ./git.nix
    ./zsh.nix
    ./kitty.nix
    ./librewolf.nix
    ./nvim.nix
    ./omp.nix
    ./niri.nix
  ];

  home.username = "byte";
  home.homeDirectory = "/home/byte";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
