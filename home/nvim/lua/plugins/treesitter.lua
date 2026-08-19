return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").setup()

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })

        require("nvim-treesitter").install({
            "lua",
            "nix",
            "cpp",
            "dockerfile",
	    "vim",
	    "vimdoc",
        })
    end,
}
