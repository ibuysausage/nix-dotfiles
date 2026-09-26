_: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Needed for cachix
      trusted-users = ["root" "byte"];
      accept-flake-config = true;
    };
  };

  networking.hostName = "server01";

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  systemd.services.splatnet3-token-util = {
    description = "SplatNet3 token util";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    wants = ["network-online.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = "/root/splatoon/splatoon/bin/python /root/splatoon/splatnet3-token-util/run_s3s.py -r -M";
      WorkingDirectory = "/root/splatnet3-token-util";
      Restart = "always";
      RestartSec = 5;

      # Run as your normal user instead of root, since this presumably
      # touches your own config/cookies
      User = "root";
    };
  };
}
