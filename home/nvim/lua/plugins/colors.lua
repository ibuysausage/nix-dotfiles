local theme = "tokyonight"

local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end
return {
    {
	"folke/tokyonight.nvim",
	config = function()
	   enable_transparency()
	   if theme == "tokyonight" then
	       vim.cmd.colorscheme("tokyonight")
	       enable_transparency()
	   end
	end,
    },
    {
	"rose-pine/neovim",
	name = "rose-pine-moon",
	config = function()
	    if theme == "rose-pine" then
		vim.cmd.colorscheme("rose-pine-moon")
		enable_transparency()
	    end
	end,
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	   "nvim-tree/nvim-web-devicons"
	},
	opts = {
	   theme = 'tokyonight',
	},
    },	
}
