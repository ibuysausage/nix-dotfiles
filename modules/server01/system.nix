{...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Needed for cachix
      trusted-users = ["root" "byte"];
      accept-flake-config = true;
    };
  };

  networking.hostName = "server01";

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  networking.interfaces.wlp1s0.ipv4.addresses = [
    {
      address = "192.168.4.30";
      prefixLength = 24;
    }
  ];

  networking.defaultGateway = "192.168.4.1";
  networking.nameservers = ["127.0.0.1"];
  networking.firewall.allowedTCPPorts = [8080 3000 8888 53];
  networking.firewall.allowedUDPPorts = [53];
}
