vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

vim.keymap.set(
    'n',
    '<leader>t',
    [[<cmd>rightbelow vsplit | term<cr>A]],
    { desc = 'Open terminal in horizontal split' }
)
