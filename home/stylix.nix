{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = ./themes/catppuccin-mocha.yaml;
    image = ./wallpapers/catppuccin/giant-cat.jpg;
    opacity.terminal = 0.85;

    icons = {
      enable = true;
      package = pkgs.candy-icons;
      dark = "candy-icons";
      light = "candy-icons";
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    targets = {
      nixos-icons.enable = true;
      gtk.enable = true;
      qt.enable = true;
      emacs.enable = false;

      anki.enable = false;
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
      serif = {
        package = pkgs.literata;
        name = "Literata";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes.terminal = 11;
    };
  };
  fonts.fontconfig.enable = true;
}
