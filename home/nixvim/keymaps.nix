{ ... }: {
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<CR>";
        action = "o<ESC>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>t";
        action = "<cmd>ToggleTerm<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options.silent = true;
      }
    ];
  };
}
