{
  config,
  lib,
  ...
}: {
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

  xdg.configFile."noctalia" = {
    source = ./noctalia;
    recursive = true;
  };

  xdg.configFile."quickshell" = {
    source = ./quickshell;
    recursive = true;
  };

  xdg.configFile."quickshell/cheapbar/theme/Theme.qml".text = ''
    pragma Singleton
    import QtQuick

    QtObject {
        readonly property color base00: "#${config.lib.stylix.colors.base00}"
        readonly property color base01: "#${config.lib.stylix.colors.base01}"
        readonly property color base02: "#${config.lib.stylix.colors.base02}"
        readonly property color base03: "#${config.lib.stylix.colors.base03}"
        readonly property color base04: "#${config.lib.stylix.colors.base04}"
        readonly property color base05: "#${config.lib.stylix.colors.base05}"
        readonly property color base06: "#${config.lib.stylix.colors.base06}"
        readonly property color base07: "#${config.lib.stylix.colors.base07}"
        readonly property color base08: "#${config.lib.stylix.colors.base08}"
        readonly property color base09: "#${config.lib.stylix.colors.base09}"
        readonly property color base0A: "#${config.lib.stylix.colors.base0A}"
        readonly property color base0B: "#${config.lib.stylix.colors.base0B}"
        readonly property color base0C: "#${config.lib.stylix.colors.base0C}"
        readonly property color base0D: "#${config.lib.stylix.colors.base0D}"
        readonly property color base0E: "#${config.lib.stylix.colors.base0E}"
        readonly property color base0F: "#${config.lib.stylix.colors.base0F}"
    }
  '';

  xdg.configFile."quickshell/cheapbar/theme/qmldir".text = ''
    singleton Theme 1.0 Theme.qml
  '';

  xdg.configFile."kdeglobals".text = lib.mkForce ''
    [Icons]
    Theme=candy-icons
  '';
}
