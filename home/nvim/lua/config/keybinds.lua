vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>p", "<cmd>Telescope project_cli_commands open<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>;", "<cmd>Telescope project_cli_commands running<CR>", { noremap = true, silent = true })
