{config, ...}: {
  sops.secrets.searxng-env = {
    owner = "root";
    group = "root";
    mode = "0400";
  };
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    environmentFile = config.sops.secrets.searxng-env.path;

    settings = {
      server = {
        bind_address = "0.0.0.0";
        port = 8080;
      };

      search = {
        safe_search = 0;
        autocomplete = "duckduckgo";
        favicon_resolver = "duckduckgo";
      };

      ui = {
        theme_args.simple_style = "black";
        hotkeys = "vim";
      };
    };
  };

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/root/.config/sops/age/keys.txt";

  networking.firewall.allowedTCPPorts = [8080];
}
