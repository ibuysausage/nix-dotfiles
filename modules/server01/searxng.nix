{config, ...}: {
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings.server = {
      bind_address = "0.0.0.0";
      port = 8080;
      # WARNING: setting secret_key here might expose it to the nix cache
      # see below for the sops or environment file instructions to prevent this
      # secret_key = "Your secret key.";
      secret_key = config.sops.secrets.searxng-key.path;
    };
  };

  networking.firewall.allowedTCPPorts = [8080];
}
