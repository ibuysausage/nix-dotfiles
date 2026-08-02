{ config, pkgs, ... }:

{

  home.file."Pictures/Wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  home.file.".config/sway/status.sh" = {
    source = ./scripts/status.sh;
  };

  home.file.".config/rofi" = {
    source = ./themes/rofi;
  };

  home.file.".config/ohmyposh/omp.toml" = {
    source = ./omp/omp.toml;
  };

  home.file.".config/librewolf/librewolf/profiles.ini" = {
    source = ./librewolf/profiles.ini;
  };

  home.file.".config/librewolf/librewolf/default/chrome/userChrome.css" = {
    source = ./librewolf/userChrome.css;
  };

  home.file.".config/librewolf/librewolf/default/chrome/userContent.css" = {
    source = ./librewolf/userContent.css;
  };

  home.file.".config/librewolf/librewolf/default/chrome/assets" = {
    source = ./librewolf/assets;
    recursive = true;
  }; 

  home.file.".vimrc" = {
    source = ./vimfiles/vimrc;
  };

  home.file.".vim" = {
    source = ./vimfiles/vim;
    recursive = true;
  };

  home.file.".vim/autoload/plug.vim".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
      sha256 = "sha256-fisgzZCdqcRWSYaEyY8DxjgpFw8B40WV3Y4YGKIX03w=";
  };

}
