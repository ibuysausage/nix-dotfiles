{...}: {
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/wildfire/boot.nix
    ../../modules/wildfire/network.nix
    ../../modules/wildfire/packages.nix
    ../../modules/wildfire/services.nix
    ../../modules/wildfire/sops.nix
    ../../modules/wildfire/spicetify.nix
    ../../modules/wildfire/splatoon.nix
    ../../modules/wildfire/stylix.nix
    ../../modules/wildfire/sway.nix
    ../../modules/wildfire/system.nix
    ../../modules/wildfire/user.nix
    ../../modules/wildfire/x11.nix
  ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment? Its not there
  stylix.targets.nixos-icons.enable = true;
}
