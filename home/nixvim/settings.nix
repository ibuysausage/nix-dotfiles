{
  programs.nixvim = {
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    enableMan = true;

    globals.mapleader = " ";

    opts = {
      clipboard = "unnamedplus";
      termguicolors = true;
      spelllang = "en_us";
      spell = true;

      # tab settings
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      shiftround = true;
      smartindent = true;
      # breakindent = true;

      # linenumbers
      number = true;
      relativenumber = true;
      wrap = false;
      cursorline = true;
      scrolloff = 10;

      # search
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = true;
    };
  };
}
