{config, ...}: {
  networking = {
    # Set static ipv4
    useDHCP = false;

    networkmanager = {
      enable = true;
      dns = "none";
      ensureProfiles.environmentFiles = [
        config.sops.secrets.wifi_env.path
      ];

      ensureProfiles.profiles = {
        hotspot = {
          connection = {
            id = "hotspot";
            type = "wifi";
            interface-name = "wlp1s0";
            autoconnect-priority = 10;
          };
          wifi = {
            mode = "infrastructure";
            ssid = "$HOTSPOT_SSID";
          };
          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$HOTSPOT_PSK";
          };
          ipv4 = {
            method = "auto";
            ignore-auto-dns = "true";
          };
          ipv6.method = "disabled";
        };

        home = {
          connection = {
            id = "home";
            type = "wifi";
            interface-name = "wlp1s0";
            autoconnect-priority = 5;
          };
          wifi = {
            mode = "infrastructure";
            ssid = "$HOME_SSID";
          };
          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$HOME_PSK";
          };
          ipv4 = {
            method = "manual";
            address1 = "192.168.1.30/22,192.168.4.1";
            ignore-auto-dns = "true";
          };
          ipv6.method = "disabled";
        };
      };
    };

    # Don't let NixOS generate resolv.conf
    resolvconf.enable = false;

    # Extra ports for SearXNG and AdGuardHome
    firewall.allowedTCPPorts = [8080 3000 8888 53];
    firewall.allowedUDPPorts = [53];
  };

  # Set nameservers in resolv.conf
  environment.etc."resolv.conf".text = ''
    nameserver 127.0.0.1
  '';

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

  sops.secrets.wifi_env = {};
}
