# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
{...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/server01/adguardhome.nix
    ../../modules/server01/boot.nix
    ../../modules/server01/chrome-user.nix
    ../../modules/server01/chromebook.nix
    ../../modules/server01/network.nix
    ../../modules/server01/packages.nix
    ../../modules/server01/searxng.nix
    ../../modules/server01/sops.nix
    ../../modules/server01/splatoon.nix
    ../../modules/server01/stylix.nix
    ../../modules/server01/sway.nix
    ../../modules/server01/system.nix
    ../../modules/wildfire/spicetify.nix
  ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
