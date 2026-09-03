{ ... }: {
  programs.nixvim = {
    colorschemes = {
      base16 = {
        enable = false;
        settings = {
          cmp = true;
        };
      };
      kanagawa = {
        enable = false;
      };
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          transparent_background = true;
        };
      };
    };
  };
}
