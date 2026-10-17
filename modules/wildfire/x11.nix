{pkgs, ...}: {
  services = {
    picom.enable = true;
    xserver = {
      enable = true;
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs (old: {
          src = ../../dwm-config;

          buildInputs =
            (old.buildInputs or [])
            ++ (with pkgs; [
              libxcb
              libxcb-util
              libxcb-wm
              libxres
            ]);
        });
      };

      displayManager.startx = {
        enable = true;
        generateScript = true;
      };

      # needed for Intel ???
      videoDrivers = ["modesetting"];
      # caps to esc for neovim
      xkb.options = "caps:escape";

      desktopManager = {
        xterm.enable = false;
      };
    };

    # display managers are bloat for weirdos
    displayManager = {
      gdm.enable = false;
      sddm.enable = false;
    };

    # tpad + mouse
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0.6";
        naturalScrolling = true;
      };

      touchpad = {
        tapping = true;
        accelProfile = "flat";
        accelSpeed = "0.9";
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    feh
    xwallpaper
    tiramisu
    xclip
    (pkgs.dmenu.overrideAttrs (old: {
      src = ../../dmenu-config;
    }))
    (pkgs.slstatus.overrideAttrs (old: {
      src = ../../slstatus-config;
    }))
  ];
}
