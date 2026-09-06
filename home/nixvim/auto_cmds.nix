{
  autoGroups = {
    highlight_yank = {};
    indentscope = {};
    restore_cursor = {};
  };

  autoCmd = [
    {
      group = "highlight_yank";
      event = ["TextYankPost"];
      pattern = "*";
      callback = {
        __raw = ''
          function()
            vim.hl.hl_op()
          end
        '';
      };
    }
    ## from NVChad https://nvchad.com/docs/recipes (this autocmd will restore the cursor position when opening a file)
    {
      group = "restore_cursor";
      event = ["BufReadPost"];
      pattern = "*";
      callback = {
        __raw = ''
          function()
            if
              vim.fn.line "'\"" > 1
              and vim.fn.line "'\"" <= vim.fn.line "$"
              and vim.bo.filetype ~= "commit"
              and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
            then
              vim.cmd "normal! g`\""
            end
          end
        '';
      };
    }
    {
      event = ["BufWritePre"];
      pattern = "*";
      callback = {
        __raw = ''
          function()
            local pos = vim.fn.getpos "."
            vim.cmd [[%s/\s\+$//e]]
            vim.fn.setpos(".", pos)
          end
        '';
      };
    }
    {
      event = "BufEnter";
      pattern = "oil://*";
      callback = {
        __raw = ''
          function()
            local dir = require("oil").get_current_dir()
            if dir then
              vim.cmd.lcd(dir)
            end
          end
        '';
      };
    }
  ];
}
