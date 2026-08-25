{...}: {
  programs.btop.enable = true;
  programs.fzf.enable = true;
  programs.lazygit.enable = true;
  dconf.enable = true;
  gtk.enable = true;
  qt.enable = true;

  services.pipewire.wireplumber.extraConfig."51-default-sink" = {
    "wireplumber.settings" = {
      "device.routes.default-sink" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
    };
  };
}
