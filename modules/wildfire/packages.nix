{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
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
    # fenix rust
    fenix.complete.toolchain
    # be safe :)
    clamav
    kdePackages.dolphin
    kdePackages.kio-extras
    kdePackages.xdg-desktop-portal-kde
    kdePackages.kconfig
    kdePackages.kservice
    # nvim junk
    # lua have to be 5.1
    gcc
    tree-sitter
    gnumake
    luaPackages.tree-sitter-cli
    lua5_1
    luarocks
    # nvim language servers
    nixd
    lua-language-server
    clang-tools
    cmake-language-server
    marksman
    rust-analyzer
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
