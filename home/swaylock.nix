{
  config,
  pkgs,
  ...
}:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      image = "${config.home.homeDirectory}/Pictures/Wallpapers/fractal.png";
      font = "CaskaydiaCove Nerd Font Mono";
      clock = true;
      indicator = true;
      inside-color = "#9400D3";
      text-color = "#00FA9A";
      ring-color = "#00FA9A";
      key-hl-color = "#FA0060";
      indicator-radius = 100;
      indicator-thickness = 15;
    };
  };
}
