{ config, pkgs, ... }:

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

  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;
  

}
