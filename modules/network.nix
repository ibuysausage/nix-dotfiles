{ config, ... }: {
  # Jellyfin docker ports
  networking.firewall.allowedTCPPorts = [
    26099
    26101
    8096
  ];

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
}
