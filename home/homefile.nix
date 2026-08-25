{lib, ...}: {
  home.file."Pictures/Wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  home.file.".config/sway/status.sh" = {
    executable = true;
    source = ./scripts/status.sh;
  };

  home.file.".config/sway/volume.sh" = {
    executable = true;
    source = ./scripts/volume.sh;
  };

  home.file.".config/sway/brightness.sh" = {
    executable = true;
    source = ./scripts/brightness.sh;
  };

  home.file.".config/ohmyposh/omp.toml" = {
    source = ./omp/omp.toml;
  };

  xdg.configFile."nvim/lua" = {
    source = ./nvim/lua;
    recursive = true;
  };

  xdg.configFile."noctalia" = {
    source = ./noctalia;
    recursive = true;
  };

  xdg.configFile."quickshell" = {
    source = ./quickshell;
    recursive = true;
  };

  xdg.configFile."kdeglobals".text = lib.mkForce ''
    [Icons]
    Theme=candy-icons
  '';
}
