{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../../home/wallpapers/catppuccin/nixos.jpg;
    base16Scheme = ../../home/themes/catppuccin-mocha.yaml;

    fonts.monospace = {
      package = pkgs.nerd-fonts.caskaydia-cove;
      name = "CaskaydiaCove Nerd Font Mono";
    };

    targets.grub = {
      enable = false;
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
