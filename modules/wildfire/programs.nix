{pkgs, ...}: {
  programs.git.enable = true;
  programs.zsh.enable = true;

  # x11
  services.xserver.enable = true;
  services.xserver.windowManager.oxwm.enable = true;
  services.displayManager.gdm.enable = false;
  # ???
  services.xserver.videoDrivers = ["modesetting"];
  # tpad
  services.libinput.enable = true;
  services.libinput.touchpad.tapping = true;
  # make qt look like gtk
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";

  services.xserver.displayManager.startx = {
    enable = true;
    generateScript = true;
  };

  # numworks calculator
  services.udev.packages = [
    pkgs.numworks-udev-rules
  ];

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  services.pipewire.wireplumber = {
    enable = true;

    extraConfig."51-default-sink" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              "node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
            }
          ];

          actions = {
            update-props = {
              "priority.session" = 2000;
            };
          };
        }
      ];
    };
  };
}
