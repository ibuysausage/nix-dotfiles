{...}: {
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };

  # AdGuardHome web interface port
  networking.firewall.allowedTCPPorts = [8888];
}
