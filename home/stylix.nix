{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = ./themes/catppuccin-mocha.yaml;
    image = ./wallpapers/giant-cat-catppuccin.jpg;
    opacity.terminal = 0.85;

    icons = {
      enable = true;
      package = pkgs.candy-icons;
      dark = "candy-icons";
      light = "candy-icons";
    };

    cursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };

    targets = {
      nixos-icons.enable = true;
      niri.enable = true;
      gtk.enable = true;
      qt.enable = true;
      nixvim.enable = false;

      firefox = {
        enable = true;
        profileNames = ["byte"];
        colorTheme.enable = true;
        fonts.enable = true;
        colors.enable = true;
      };

      librewolf = {
        enable = true;
        profileNames = ["byte"];
        colorTheme.enable = true;
        fonts.enable = true;
        colors.enable = true;
      };

      rofi = {
        enable = true;
        opacity = {
          enable = true;
        };
      };
    };

    fonts = {
      sansSerif = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };

      sizes.terminal = 11;
    };
  };
}
