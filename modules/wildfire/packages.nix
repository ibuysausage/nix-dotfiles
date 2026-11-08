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
    eza
    fd
    ffmpeg
    file
    fzf
    gh
    gimp
    haruna
    home-manager
    iw
    jellyfin-tui
    just
    keepassxc
    lazygit
    libnotify
    librewolf
    marktext
    metronome
    mpv
    nix-prefetch
    nix-prefetch-git
    nix-update
    nixfmt
    nodejs
    obs-studio
    oh-my-posh
    papirus-icon-theme
    pkgit
    quickshell
    ripgrep
    sameboy
    sops
    ssh-to-age
    st.terminfo
    tmux
    tree
    tuxedo
    unzip
    vim
    vvvvvv
    wget
    wl-clipboard
    yt-dlp
    kdePackages.dolphin
    # fenix rust
    fenix.complete.toolchain
    # Nur pkgs
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
    # Emacs vterm
    cmake
    libtool
    libvterm
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
