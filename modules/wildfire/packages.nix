{pkgs, ...}: {
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    age
    bat
    bat-extras.batman
    btop
    cachix
    candy-icons
    curl
    deadnix
    devenv
    dmenu
    eza
    fd
    ffmpeg
    file
    fzf
    gh
    gimp
    haruna
    home-manager
    jellyfin-tui
    just
    keepassxc
    kitty
    kitty.terminfo
    lazygit
    libnotify
    librewolf
    marktext
    mpv
    nix-prefetch
    nix-prefetch-git
    nix-update
    nixfmt
    nodejs
    oh-my-posh
    papirus-icon-theme
    picom
    pkgit
    quickshell
    ripgrep
    ripgrep
    rofi
    sameboy
    sops
    ssh-to-age
    tree
    tuxedo
    unzip
    vim
    vvvvvv
    wget
    wl-clipboard
    yt-dlp
    # x11
    feh
    xwallpaper
    xmobar
    kdePackages.dolphin
    # fenix rust
    fenix.complete.toolchain
    nur.repos.ibuysausage.crdl
    nur.repos.ibuysausage.waifufetch
    nur.repos.ibuysausage.nix-reaper
    # Language servers
    # C/C++
    gcc
    gnumake
    clang
    clang-tools
    cppcheck
    gdb
    # Lua for embedding in C/C++
    lua
    luarocks
    # Nix
    nixd
    alejandra
    statix
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
