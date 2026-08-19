# your system. Help is available in the configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/packages.nix
    ./modules/boot.nix
    ./modules/system.nix
    ./modules/programs.nix
    ./modules/user.nix
    ./modules/network.nix
    ./modules/sway.nix
  ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment? Its not there
}
