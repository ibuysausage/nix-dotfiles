{...}: {
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;

  services.pipewire.wireplumber = {
    enable = true;

    extraConfig."51-default-sink" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              "node.name" = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink";
            }
          ];

          actions = {
            update-props = {
              "priority.session" = 2000;
            };
          };
        }
      ];
    };
  };
}
