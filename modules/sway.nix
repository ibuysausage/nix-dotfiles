{
  config,
  pkgs,
  ...
}:
{
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
}
