{...}: {
  services.xserver.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };
  # display managers are bloat for weirdos
  services.displayManager.gdm.enable = false;
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.startx = {
    enable = true;
    generateScript = true;
    extraCommands = ''
      xwallpaper --zoom ~/Pictures/Wallpapers/catppuccin/giant-cat.jpg
    '';
  };
  # needed for Intel ???
  services.xserver.videoDrivers = ["modesetting"];
  # tpad
  services.libinput = {
    enable = true;

    touchpad = {
      tapping = true;
      accelProfile = "flat";
      accelSpeed = "0.9";
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };
  # caps to esc for neovim
  services.xserver.xkb.options = "caps:escape";
}
