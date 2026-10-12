{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    bat
    bat-extras.batman
    brightnessctl
    devenv
    eza
    git
    just
    libnotify
    keepassxc
    oh-my-posh
    openssl
    sops
    vim
    wget
    rofi-network-manager
    wl-clipboard
    cliphist
    nur.repos.ibuysausage.nix-reaper
    # Audio
    pavucontrol
    wireplumber
    alsa-utils
    # Nix
    alejandra
    deadnix
    nixd
    statix
    # C/C++
    clang
    clang-tools
    cppcheck
    gcc
    gdb
    gnumake
    # Emacs vterm
    cmake
    libtool
    libvterm
    # X11
    feh
    xwallpaper
    dmenu
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    iosevka
    material-symbols
  ];

  nixpkgs.config.allowUnfree = true;
}
