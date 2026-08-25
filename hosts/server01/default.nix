# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
{...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/server01/boot.nix
    ../../modules/server01/packages.nix
    ../../modules/server01/system.nix
    ../../modules/server01/stylix.nix
  ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
