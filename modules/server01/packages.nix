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
    wl-clipboard
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
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    iosevka
    material-symbols
  ];
}
