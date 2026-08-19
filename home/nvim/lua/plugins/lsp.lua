return {
  { "neovim/nvim-lspconfig" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require('config.cmp')
    end,
  },
}
