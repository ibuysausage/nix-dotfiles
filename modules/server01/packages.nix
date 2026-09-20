{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    just
    openssl
    age
    sops
    nur.repos.ibuysausage.nix-reaper
  ];
}
