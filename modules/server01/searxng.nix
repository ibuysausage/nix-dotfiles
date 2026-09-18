{config, ...}: {
  sops.secrets.searxng-env = {
    owner = "root";
    group = "root";
    mode = "0400";
  };
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    openFirewall = true;
    environmentFile = config.sops.secrets.searxng-env.path;

    faviconsSettings = {
      favicons = {
        cfg_schema = 1;
        cache = {
          db_url = "/var/cache/searx/faviconcache.db";
          HOLD_TIME = 5184000;
          LIMIT_TOTAL_BYTES = 2147483648;
          BLOB_MAX_BYTES = 40960;
          MAINTENANCE_MODE = "auto";
          MAINTENANCE_PERIOD = 600;
        };
      };
    };

    settings = {
      server = {
        bind_address = "0.0.0.0";
        port = 8080;
      };

      search = {
        safe_search = 0;
        autocomplete = "duckduckgo";
        favicon_resolver = "duckduckgo";
        default_lang = "en-US";
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
}
