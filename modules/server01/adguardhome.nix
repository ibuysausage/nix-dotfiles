{...}: {
  services.adguardhome = {
    enable = true;
    host = "0.0.0.0";
    port = 8888;
    openFirewall = true;
  };

  # AdGuardHome web interface port
  networking.firewall.allowedTCPPorts = [8888];
}
