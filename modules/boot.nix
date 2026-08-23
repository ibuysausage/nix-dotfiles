{pkgs, ...}: {
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 80;
  };

  stylix = {
    enable = true;
    image = ../home/wallpapers/purple-anime-girl.png;
    base16Scheme = ../home/themes/uwunicorn.yaml;

    targets.grub = {
      enable = true;
      useWallpaper = true;
    };

    icons = {
      enable = true;
      package = pkgs.candy-icons;
      dark = "candy-icons";
      light = "candy-icons";
    };
  };
}
