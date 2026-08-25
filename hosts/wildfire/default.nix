{...}: {
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/wildfire/packages.nix
    ../../modules/wildfire/boot.nix
    ../../modules/wildfire/system.nix
    ../../modules/wildfire/programs.nix
    ../../modules/wildfire/user.nix
    ../../modules/wildfire/network.nix
    ../../modules/wildfire/sway.nix
  ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment? Its not there
  stylix.targets.nixos-icons.enable = true;
}
