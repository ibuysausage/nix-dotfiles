{pkgs, ...}: {
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      grim
      slurp
      swayimg
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
