{config, ...}: {
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    # environmentFile = config.sops.secrets.searxng-env.path;

    settings.server = {
      bind_address = "0.0.0.0";
      port = 8080;
    };
  };

  networking.firewall.allowedTCPPorts = [8080];
}
