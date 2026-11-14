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
  };
}
