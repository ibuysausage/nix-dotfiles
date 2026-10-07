{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    python312
    ninja
    android-studio
  ];

  nixpkgs.config.android_sdk.accept_license = true;
  documentation.doc.enable = false;
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    nss
    nspr
    alsa-lib
    dbus
    expat
    libGL
    libglvnd
    libpulseaudio
    libX11
    libxcb
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXtst
    libxkbcommon
    zlib
    freetype
    fontconfig
    libpng
    libuuid
    systemd
    vulkan-loader
    mesa
    cairo
    pango
    gtk3
    glib
    libdrm
    libxkbfile
    libbsd
    xcb-util-cursor
    libxcb-util
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxcb-wm
    libxcb
    libxrandr
    libxrender
    libsm
    libice
    libxshmfence
    libxkbcommon
  ];

  systemd.services.splatnet3-token-util = {
    description = "SplatNet3 token util";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    wants = ["network-online.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = "/root/splatoon/splatoon/bin/python /root/splatoon/splatnet3-token-util/run_s3s.py -r -M";
      WorkingDirectory = "/root/splatoon/splatnet3-token-util";
      Environment = "LD_LIBRARY_PATH=/run/current-system/sw/share/nix-ld/lib";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
