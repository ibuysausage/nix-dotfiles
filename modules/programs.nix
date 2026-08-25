{...}: {
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;

  services.pipewire.wireplumber.configs."51-default-sink" = {
    "wireplumber.settings" = {
      "device.routes.default-sink" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
    };
  };
}
