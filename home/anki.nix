{pkgs, ...}: {
  anki = {
    enable = true;
    theme = "dark";
    addons = [
      (pkgs.ankiAddons.recolor.withConfig {
        config = builtins.fromJSON (builtins.readFile ./anki/catppuccin-mocha.json);
      })
    ];
  };
}
