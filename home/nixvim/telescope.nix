{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      extensions = {
        fzf-native = {
          settings.case_mode = "ignore_case";
        };
      };
      settings = {
        defaults = {
          layout_config = {
            prompt_position = "top";
          };
        };
      };
      keymaps = {
        "<leader><space>" = {
          action = "find_files";
          options = {
            desc = "find project files";
          };
        };
        "<leader>/" = {
          action = "live_grep";
          options = {
            desc = "grep (root dir)";
          };
        };
        "<leader>b" = {
          action = "buffers";
          options = {
            desc = "+buffer";
          };
        };
        "<leader>:" = {
          action = "command_history";
          options = {
            desc = "command history";
          };
        };
      };
    };
  };
}
