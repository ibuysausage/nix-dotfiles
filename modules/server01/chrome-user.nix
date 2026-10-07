{
  pkgs,
  lib,
  ...
}: let
  browserUser = "chromium";
  home = "/var/lib/${browserUser}";

  # dark preference only, with no palette. Colors come from Stylix's policies.
  gtkSettings = pkgs.writeText "gtk-settings.ini" ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';

  chromiumAsUser = pkgs.writeShellScriptBin "chromium" ''
    rt="/run/user/$(${pkgs.coreutils}/bin/id -u)"

    # let the chromium user traverse your runtime dir and use the sockets
    ${pkgs.acl}/bin/setfacl -m u:${browserUser}:x "$rt"
    ${pkgs.acl}/bin/setfacl -m u:${browserUser}:rw "$rt/$WAYLAND_DISPLAY"

    # audio (PulseAudio/pipewire-pulse socket)
    if [ -S "$rt/pulse/native" ]; then
      ${pkgs.acl}/bin/setfacl -m u:${browserUser}:x "$rt/pulse"
      ${pkgs.acl}/bin/setfacl -m u:${browserUser}:rw "$rt/pulse/native"
    fi

    exec ${pkgs.sudo}/bin/sudo -u ${browserUser} -H \
      ${pkgs.coreutils}/bin/env -u DISPLAY -u DBUS_SESSION_BUS_ADDRESS \
        PATH=/run/current-system/sw/bin \
        XDG_DATA_DIRS=/run/current-system/sw/share \
        WAYLAND_DISPLAY="$rt/$WAYLAND_DISPLAY" \
        XDG_RUNTIME_DIR=/run/${browserUser} \
        PULSE_SERVER="unix:$rt/pulse/native" \
        GTK_THEME=Adwaita:dark \
      ${pkgs.dbus}/bin/dbus-run-session -- \
      ${pkgs.ungoogled-chromium}/bin/chromium \
        --ozone-platform=wayland \
        --enable-features=UseOzonePlatform \
        --force-dark-mode \
        --password-store=basic \
        "$@"
  '';
  chromiumDesktop = pkgs.makeDesktopItem {
    name = "chromium-browser";
    desktopName = "Chromium";
    genericName = "Web Browser";
    exec = "${chromiumAsUser}/bin/chromium %U";
    icon = "chromium";
    categories = ["Network" "WebBrowser"];
    mimeTypes = [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
    startupWMClass = "chromium-browser";
  };

  ublockExt = pkgs.writeText "ublock.json" ''
    {"external_update_url": "https://clients2.google.com/service/update2/crx"}
  '';
in {
  users.groups.${browserUser} = {};

  users.users.${browserUser} = {
    isSystemUser = true;
    group = browserUser;
    inherit home;
    createHome = true;
    extraGroups = ["video" "render" "audio"];
  };

  # Stylix writes its colors into programs.chromium.extraOpts, which needs this enabled
  programs.chromium.enable = true;
  stylix.targets.chromium.enable = true;

  # always dark, whatever stylix.polarity is set to
  programs.chromium.extraOpts.BrowserColorScheme = lib.mkForce "dark";

  systemd.tmpfiles.rules = [
    "d /run/${browserUser} 0700 ${browserUser} ${browserUser} -"
    "d ${home}/.config 0700 ${browserUser} ${browserUser} -"
    "d ${home}/.config/gtk-3.0 0700 ${browserUser} ${browserUser} -"
    "d ${home}/.config/gtk-4.0 0700 ${browserUser} ${browserUser} -"
    "L+ ${home}/.config/gtk-3.0/settings.ini - - - - ${gtkSettings}"
    "L+ ${home}/.config/gtk-4.0/settings.ini - - - - ${gtkSettings}"
    "d ${home}/.config/chromium 0700 ${browserUser} ${browserUser} -"
    "d '${home}/.config/chromium/External Extensions' 0700 ${browserUser} ${browserUser} -"
    "L+ '${home}/.config/chromium/External Extensions/cjpalhdlnbpafiamejdnhcphjbkeiagm.json' - - - - ${ublockExt}"
  ];

  environment.systemPackages = [
    (lib.hiPrio chromiumAsUser)
    chromiumDesktop
  ];
}
