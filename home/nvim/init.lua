require('config.options')
require('config.keybinds')
require('config.autocmd')
require('config.lazy')
require('config.lsp')
require('config.cmp')

vim.lsp.handlers["textDocument/hover"] =
	vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

vim.lsp.handlers["textDocument/signatureHelp"] =
	vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "nix",
	callback = function()
		vim.bo.tabstop = 2  -- number of spaces a tab counts for
		vim.bo.shiftwidth = 2 -- spaces used for indentation
		vim.bo.softtabstop = 2 -- spaces when pressing Tab
		vim.bo.expandtab = true -- use spaces instead of tabs
	end,
})
