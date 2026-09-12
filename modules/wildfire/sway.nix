{pkgs, ...}: {
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      grim
      slurp
      swayidle
      swaylock-effects
      swaynotificationcenter
      pulseaudio
      swaybg
      playerctl
      autotiling
    ];
  };
}
