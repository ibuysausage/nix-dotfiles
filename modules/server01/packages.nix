{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    nixd
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
    nur.repos.ibuysausage.nix-reaper
    # C/C++
    gcc
    gnumake
    clang
    clang-tools
    cppcheck
    gdb
  ];
}
