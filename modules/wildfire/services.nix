{pkgs, ...}: {
  # numworks calculator
  services = {
    udev.packages = [
      pkgs.numworks-udev-rules
    ];

    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
