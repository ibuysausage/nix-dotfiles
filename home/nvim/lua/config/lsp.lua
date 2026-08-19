local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- applied to every server as a default
vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = { diagnostics = { globals = { 'vim' } } },
  },
})

vim.lsp.config('nixd', {
  cmd = { 'nixd' },
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> { }' },
      formatting = { command = { 'nixfmt' } },
    },
  },
})

vim.lsp.enable({ 'lua_ls', 'nixd' })

-- buffer-local keymaps once a server attaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
