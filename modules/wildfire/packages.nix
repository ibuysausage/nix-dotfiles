{pkgs, ...}: {
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    wl-clipboard
    tuxedo
    gimp
    keepassxc
    rofi
    kitty
    home-manager
    librewolf
    fzf
    ripgrep
    oh-my-posh
    eza
    ripgrep
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
    quickshell
    alejandra
    nixfmt
    statix
    deadnix
    nix-update
    devenv
    marktext
    sops
    age
    ssh-to-age
    pkgit
    # x11
    feh
    xwallpaper
    xmobar
    # needed for rustlings
    gcc
    # numworks usb
    chromium
    kdePackages.dolphin
    # fenix rust
    fenix.complete.toolchain
    nur.repos.ibuysausage.crdl
    nur.repos.ibuysausage.waifufetch
    nur.repos.ibuysausage.nix-reaper
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    material-symbols
  ];

  nixpkgs.config.allowUnfree = true;
}
