{
  pkgs,
  inputs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      adblock
    ];
    # MY BOY STYLIX GOT U DAWG
    #
    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = "mocha";
  };

  # numworks calculator
  services.udev.packages = [
    pkgs.numworks-udev-rules
  ];

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # Makes wireplumber work for default-sink
  # mainly used for quickshell
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
