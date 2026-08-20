-- Change to "tokyonight", "rose-pine", or "lavender"
--local theme = "noctalia"
--
--local function enable_transparency()
--    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--end
--return {
--    {
--	"folke/tokyonight.nvim",
--	config = function()
--	   enable_transparency()
--	   if theme == "tokyonight" then
--	       vim.cmd.colorscheme("tokyonight")
--	       enable_transparency()
--	   end
--	end,
--    },
--    {
--	"rose-pine/neovim",
--	name = "rose-pine-moon",
--	config = function()
--	    if theme == "rose-pine" then
--		vim.cmd.colorscheme("rose-pine-moon")
--		enable_transparency()
--	    end
--	end,
--    },
return {
    {
	"nvim-lualine/lualine.nvim",
	    dependencies = {
		"nvim-tree/nvim-web-devicons"
	    },
	    opts = {
		options = {
		    theme = "gruvbox",
	    },
	},
    },
--	"https://codeberg.org/jthvai/lavender.nvim",
--	branch = "stable",
--	lazy = false,
--	config = function ()
--	    if theme == "lavender" then
--	    	vim.cmd.colorscheme("lavender")
--		enable_transparency()
--	    end
--	end
--    },
 --   {
--	"keremimo/noctalia.nvim",
--	main = "noctalia",
--	lazy = false,
--	config = function ()
--	    if theme == "noctalia" then
--	    	vim.cmd.colorscheme("noctalia")
--		enable_transparency ()
--	    end
--	end
 --   },
}
