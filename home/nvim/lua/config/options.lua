vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4

-- .nix files get 2 tab indent
vim.api.nvim_create_autocmd("FileType", {
	pattern = "nix",
	callback = function()
		vim.bo.tabstop = 2 -- number of spaces a tab counts for
		vim.bo.shiftwidth = 2 -- spaces used for indentation
		vim.bo.softtabstop = 2 -- spaces when pressing Tab
		vim.bo.expandtab = true -- use spaces instead of tabs
	end,
})
