{pkgs, ...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Needed for cachix
      trusted-users = ["root" "byte"];
      accept-flake-config = true;
    };
  };

  systemd.coredump.settings.Coredump = {
    Storage = "none";
    ProcessSizeMax = "0";
  };

  security = {
    rtkit.enable = true;
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };

  networking.hostName = "server01";

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  hardware.graphics = {
    enable = true;

    # OpenGL / EGL compatibility libraries
    enable32Bit = true;

    # Intel VA-API video acceleration
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
}
