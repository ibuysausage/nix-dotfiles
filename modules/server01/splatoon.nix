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
}
