# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
{...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/boot.nix
    ../../modules/packages.nix
    ../../modules/stylix.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "server01";

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
