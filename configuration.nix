# Edit this configuration file to define what should be installed on
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
    ./sleep.nix
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

  boot.kernel.sysctl = {
    "net.ipv4.ip_unprivileged_port_start" = 80;
  };

  # Needed for Jellyfin
  networking.firewall.allowedTCPPorts = [
    26099
    26101
    8096
  ];

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
      swaynotificationcenter
      swaylock-effects
      pulseaudio
      swaybg
      swaylock
      playerctl
      fd
    ];
  };

  environment.variables.EDITOR = "nvim";

  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.neovim.enable = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  virtualisation.docker = {
    enable = true;

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
    ];
    packages = with pkgs; [
      tree
    ];
  };

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
    nixd
    gnumake
    luaPackages.tree-sitter-cli
    gcc
    libnotify
    unzip
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
