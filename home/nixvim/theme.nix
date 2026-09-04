{
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
          # latte frappe macchito mocha
          flavour = "mocha";
          transparent_background = true;
        };
      };
    };
  };
}
