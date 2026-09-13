{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    # image = ../../home/wallpapers/catppuccin/nixos.jpg;
    image = ../../home/wallpapers/catppuccin/welcome-girl.png;
    base16Scheme = ../../home/themes/catppuccin-mocha.yaml;

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
      };
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };
      emoji = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };
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
