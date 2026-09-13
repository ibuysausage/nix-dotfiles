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

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/root/.config/sops/age/keys.txt";

  networking.firewall.allowedTCPPorts = [8080];
}
