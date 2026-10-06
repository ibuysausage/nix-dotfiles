{pkgs, ...}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      # Needed for cachix
      trusted-users = ["root" "byte"];
      accept-flake-config = true;
    };
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; # lets pavucontrol, Spotify, etc. work
    wireplumber.enable = true;
  };

  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [pkgs.sof-firmware];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # alsa-utils provides amixer/alsamixer/speaker-test
  environment.systemPackages = with pkgs; [pavucontrol wireplumber alsa-utils];

  # DA7219 headphone codec: the playback path is left switched off, so
  # headphones are silent until these three controls are turned on.
  systemd.services.da7219-headphones = {
    description = "Enable DA7219 headphone playback path";
    wantedBy = ["multi-user.target"];
    after = ["sound.target"];
    path = [pkgs.alsa-utils];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      # wait for the sound card (SOF firmware loads asynchronously)
      for i in $(seq 1 30); do
        amixer -c 0 scontents >/dev/null 2>&1 && break
        sleep 1
      done

      amixer -c 0 sset 'Playback Digital' on
      amixer -c 0 sset 'Mixer Out FilterL DACL' on
      amixer -c 0 sset 'Mixer Out FilterR DACR' on
    '';
  };

  networking.hostName = "server01";

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
  hardware.graphics.enable = true;
  systemd.services.splatnet3-token-util = {
    description = "SplatNet3 token util";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    wants = ["network-online.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = "/root/splatoon/splatoon/bin/python /root/splatoon/splatnet3-token-util/run_s3s.py -r -M";
      WorkingDirectory = "/root/splatoon/splatnet3-token-util";
      Environment = "LD_LIBRARY_PATH=/run/current-system/sw/share/nix-ld/lib";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
