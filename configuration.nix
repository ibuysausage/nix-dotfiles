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
    ./packages.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "12:00" ];
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 80;
  };

  # Hardware acceleration Jellyfin
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors (iHD driver)
      intel-vaapi-driver # Fallback / older processors (i965 driver)
      intel-compute-runtime # OpenCL support for advanced filters/tonemapping
      vpl-gpu-rt # QuickSync on 11th Gen or newer
    ];
  };

  # IDK just keep. Think it is needed
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      grim
      swayidle
      swaylock-effects
      swaynotificationcenter
      pulseaudio
      swaybg
      swaylock
      playerctl
      autotiling
    ];
  };

  environment.variables.EDITOR = "nvim";

  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  virtualisation.docker = {
    enable = true;

    # jellyfin
    daemon.settings = {
      dns = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      ipv6 = false;
    };

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.byte = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmgr"
      "docker"
      "input"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  # Jellyfin docker ports
  networking.firewall.allowedTCPPorts = [ 26099 26101 8096 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment? Its not there

}
