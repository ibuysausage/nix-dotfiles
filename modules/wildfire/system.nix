{
  pkgs,
  inputs,
  config,
  ...
}: {
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Needed for cachix
      trusted-users = ["byte"];
      accept-flake-config = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = ["12:00"];
    };

    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  sops.defaultSopsFile = ../../secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/byte/.config/sops/age/keys.txt";

  sops.secrets.github-pat = {};

  sops.templates."nix-access-tokens.conf".content = ''
    access-tokens = github.com=${config.sops.placeholder.github-pat}
  '';

  nix.extraOptions = ''
    !include ${config.sops.templates."nix-access-tokens.conf".path}
  '';

  # numworks calculator shi
  services.udev.packages = [
    pkgs.numworks-udev-rules
  ];

  networking.hostName = "wildfire";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # IDK just keep. Think it is needed
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Hardware acceleration Jellyfin
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors (iHD driver)
      intel-vaapi-driver # Fallback / older processors (i965 driver)
      intel-compute-runtime # OpenCL support for advanced filters/tonemapping
      vpl-gpu-rt # QuickSync on 11th Gen or newer
    ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      niri = {
        default = ["gnome"];
        "org.freedesktop.impl.portal.FileChooser" = ["kde"];
      };
    };
  };
}
