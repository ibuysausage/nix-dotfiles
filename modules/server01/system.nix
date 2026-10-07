{pkgs, ...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Needed for cachix
      trusted-users = ["root" "byte"];
      accept-flake-config = true;
    };
  };

  security.rtkit.enable = true;
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true; # lets pavucontrol, Spotify, etc. work
      wireplumber.enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # Intel (newer)
        intel-vaapi-driver # Intel (older)
        libvdpau-va-gl # fallback
      ];
    };
    enableRedistributableFirmware = true;
    firmware = [pkgs.sof-firmware];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # alsa-utils provides amixer/alsamixer/speaker-test
  environment.systemPackages = with pkgs; [pavucontrol wireplumber alsa-utils];

  networking.hostName = "server01";

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
}
