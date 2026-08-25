{config, ...}: let
  c = config.lib.stylix.colors.withHashtag;
  mono = config.stylix.fonts.monospace.name;
in {
  boot = {
    initrd.systemd.tpm2.enable = false;

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        font = "${config.stylix.fonts.monospace.package}/share/fonts/truetype/NerdFonts/CaskaydiaCove/CaskaydiaCoveNerdFontMono-Regular.ttf";
        fontSize = 20;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  boot.loader.grub2-theme = {
    enable = true;
    theme = "vimix";
    customResolution = "1920x1080";

    splashImage = config.stylix.image;

    bootMenuConfig = ''
      left = 30%
      top = 30%
      width = 40%
      height = 40%
      item_font = "${mono} 16"
      item_color = "${c.base05}"
      selected_item_color = "${c.base0D}"
      icon_width = 32
      icon_height = 32
      item_icon_space = 20
      item_height = 36
      item_padding = 5
      item_spacing = 10
      selected_item_pixmap_style = "select_*.png"
    '';

    terminalConfig = ''
      terminal-font: "${mono} 14"
      terminal-box: "terminal_box_*.png"
      terminal-width: "100%"
      terminal-height: "100%"
      terminal-border: "0"
    '';
  };

  systemd.tpm2.enable = false;
}
