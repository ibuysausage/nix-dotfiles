_: {
  services = {
    picom.enable = true;
    xserver = {
      enable = true;
      windowManager.awesome = {
        enable = true;
      };

      displayManager.startx = {
        enable = true;
        generateScript = true;
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
