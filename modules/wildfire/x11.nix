_: {
  services = {
    picom.enable = true;
    xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      displayManager.startx = {
        enable = true;
        generateScript = true;
        extraCommands = ''
          xwallpaper --zoom ~/Pictures/Wallpapers/catppuccin/giant-cat.jpg
        '';
      };

      # needed for Intel ???
      videoDrivers = ["modesetting"];
      # caps to esc for neovim
      xkb.options = "caps:escape";
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
}
