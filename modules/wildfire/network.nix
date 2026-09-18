{...}: {
  # Jellyfin docker ports
  networking = {
    firewall.allowedTCPPorts = [
      26099
      26101
      8096
    ];

    # AdGuardHome server ip
    nameservers = ["192.168.4.30"];

    # DHCP overrides in resolv.conf
    networkmanager.dns = "none";
  };

  virtualisation.docker = {
    enable = true;

    # jellyfin
    daemon.settings = {
      dns = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      ipv6 = false;
    };

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  services.openssh.enable = true;
}
