{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    just
    openssl
    age
    sops
    brightnessctl
    libnotify
    oh-my-posh
    eza
    devenv
    nur.repos.ibuysausage.nix-reaper
    # Nix
    statix
    deadnix
    nixd
    alejandra
    # C/C++
    gcc
    gnumake
    clang
    clang-tools
    cppcheck
    gdb
  ];
}
