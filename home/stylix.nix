{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = ./themes/uwunicorn.yaml;
    image = ./wallpapers/purple-anime-girl.png;

    targets = {
      neovim.enable = true;
      nixos-icons.enable = true;
      niri.enable = true;
      gtk.enable = true;
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
