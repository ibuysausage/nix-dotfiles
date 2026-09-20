{...}: {
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
}
