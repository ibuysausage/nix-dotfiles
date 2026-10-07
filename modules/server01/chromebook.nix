{pkgs, ...}: {
  hardware.chromebook-keyboard = {
    enable = true;
    physmap = ["EA" "E9" "E7" "91" "92" "94" "95" "A0" "AE" "B0"];
    # invert = true;     # F-keys by default, media keys with Search held
    # model = "pixel";   # Nocturne/Atlas/Eve; "sarien" for Sarien/Arcada
  };

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
}
