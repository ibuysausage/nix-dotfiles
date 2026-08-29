{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = ./themes/uwunicorn.yaml;
    image = ./wallpapers/purple-anime-girl.png;

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
      neovim.enable = true;
      nixos-icons.enable = true;
      niri.enable = true;
      gtk.enable = true;
      qt.enable = true;

      librewolf = {
        enable = true;
        profileNames = ["byte"];
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
