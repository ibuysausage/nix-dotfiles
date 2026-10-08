{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    # image = ../../home/wallpapers/catppuccin/nixos.jpg;
    image = ../../home/wallpapers/catppuccin/welcome-girl.png;
    base16Scheme = ../../home/themes/catppuccin-mocha.yaml;

    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
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
