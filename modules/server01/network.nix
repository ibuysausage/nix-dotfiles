{config, ...}: {
  networking = {
    wireless = {
      enable = true;
      secretsFile = config.sops.templates."networking/wifi_psk_wpa".path;

      # pskRaw is faster and has more security
      networks = {
        "TMOBILE-EERO" = {
          pskRaw = "ext:WIFI_PSK";
        };
      };
    };

    defaultGateway = "192.168.4.1";
    nameservers = ["127.0.0.1"];

    interfaces.wlp1s0.ipv4.addresses = [
      {
        address = "192.168.4.30";
        prefixLength = 24;
      }
    ];

    # Extra ports for SearXNG and AdGuardHome
    firewall.allowedTCPPorts = [8080 3000 8888 53];
    firewall.allowedUDPPorts = [53];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  programs.ssh.startAgent = true;

  users.users."root".openssh.authorizedKeys.keys = [
    (builtins.readFile ../../keys/id_byte.pub)
  ];

  users.users."zinc".openssh.authorizedKeys.keys = [
    (builtins.readFile ../../keys/id_byte.pub)
  ];

  sops = {
    secrets."networking/wifi_psk" = {
      owner = "wpa_supplicant";
      mode = "0400";
    };

    templates."networking/wifi_psk_wpa" = {
      content = ''WIFI_PSK=${config.sops.placeholder."networking/wifi_psk"}'';
      owner = "wpa_supplicant";
      mode = "0400";
    };
  };
}
