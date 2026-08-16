{ pkgs, inputs, ... }:

{

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
    nixfmt
    # nvim plugin
    gnumake
    luaPackages.tree-sitter-cli
    gcc
    libnotify
    fd
    unzip
    adwaita-icon-theme
    jellyfin-tui
    ffmpeg
    nix-init
    haruna
    wl-clicker
    vvvvvv
    tree
    inputs.byte-nur.packages.${pkgs.system}.crdl
    inputs.byte-nur.packages.${pkgs.system}.waifufetch
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  nixpkgs.config.allowUnfree = true;

}
