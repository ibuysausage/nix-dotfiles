{...}: {
  programs.git.enable = true;
  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;

  stylix.enable = true;
  stylix.image = ../home/wallpapers/purple-anime-girl.png;
  stylix.base16Scheme = ../home/themes/uwunicorn.yaml;

  boot.loader.grub.enable = true;
  boot.plymouth.enable = true;

  stylix.targets.grub.enable = true;
  stylix.targets.plymouth.enable = true;
}
