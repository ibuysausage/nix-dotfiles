{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<CR>";
        action = "o<ESC>";
        options = {
          silent = true;
          desc = "create newline in normal mode";
        };
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>ToggleTerm<CR>";
        options = {
          silent = true;
          desc = "open terminal";
        };
      }
      {
        mode = "n";
        key = "<leader>tl";
        action = "<cmd>ToggleTerm size=100 direction=vertical<CR>";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {
          silent = true;
          desc = "open lazygit";
        };
      }
      {
        mode = "n";
        key = "<leader>o";
        action = "<cmd>Oil<CR>";
        options = {
          silent = true;
          desc = "open oil";
        };
      }
      {
        mode = "t";
        key = "<C-h>";
        action = "<cmd>wincmd h<cr>";
        options = {
          desc = "Go to Left Window";
        };
      }
      {
        mode = "t";
        key = "<C-j>";
        action = "<cmd>wincmd j<cr>";
        options = {
          desc = "Go to Lower Window";
        };
      }
      {
        mode = "t";
        key = "<C-k>";
        action = "<cmd>wincmd k<cr>";
        options = {
          desc = "Go to Upper Window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<cmd>wincmd l<cr>";
        options = {
          desc = "Go to Right Window";
        };
      }
    ];
  };
}
