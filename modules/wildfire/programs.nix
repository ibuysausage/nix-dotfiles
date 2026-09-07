{pkgs, ...}: {
  programs.git.enable = true;
  programs.zsh.enable = true;

  # x11
  services.xserver.enable = true;
  services.xserver.windowManager.oxwm.enable = true;
  # display managers are bloat for weirdos
  services.displayManager.gdm.enable = false;
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.startx = {
    enable = true;
    generateScript = false;
  };
  # needed for Intel ???
  services.xserver.videoDrivers = ["modesetting"];
  # tpad
  services.libinput.enable = true;
  services.libinput.touchpad.tapping = true;
  # caps to esc for neovim
  services.xserver.xkb.options = "caps:escape";

  # numworks calculator
  services.udev.packages = [
    pkgs.numworks-udev-rules
  ];

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # Makes wireplumber work for default-sink
  # mainly used for quickshell
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
