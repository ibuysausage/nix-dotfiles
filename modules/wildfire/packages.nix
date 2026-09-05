{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    wl-clipboard
    fastfetch
    tuxedo
    keepassxc
    rofi
    kitty
    home-manager
    librewolf
    fzf
    oh-my-posh
    eza
    ripgrep
    feh
    yt-dlp
    btop
    libnotify
    fd
    unzip
    file
    bat
    bat-extras.batman
    adwaita-icon-theme
    papirus-icon-theme
    candy-icons
    jellyfin-tui
    ffmpeg
    haruna
    vvvvvv
    cachix
    tree
    just
    lazygit
    git
    gh
    noctalia
    quickshell
    alejandra
    nixfmt
    devenv
    marktext
    sops
    age
    # needed for rustlings
    gcc
    # numworks usb
    chromium
    # fenix rust
    fenix.complete.toolchain
    # kde i think for dolphin only
    kdePackages.dolphin
    kdePackages.kio-extras
    kdePackages.xdg-desktop-portal-kde
    kdePackages.kconfig
    kdePackages.kservice
    # no overlay yet
    inputs.byte-nur.packages.${system}.crdl
    inputs.byte-nur.packages.${system}.waifufetch
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    material-symbols
  ];

  nixpkgs.config.allowUnfree = true;
}
