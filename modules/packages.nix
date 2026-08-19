{
  pkgs,
  inputs,
  ...
}: {
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
    gcc
    libnotify
    fd
    unzip
    adwaita-icon-theme
    jellyfin-tui
    ffmpeg
    haruna
    vvvvvv
    tree
    just
    lazygit
    noctalia
    alejandra
    # nvim junk
    # lua have to be 5.1
    # lua51Packages.jsregexp
    # lua snip
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
    inputs.byte-nur.packages.${pkgs.system}.crdl
    inputs.byte-nur.packages.${pkgs.system}.waifufetch
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  nixpkgs.config.allowUnfree = true;
}
