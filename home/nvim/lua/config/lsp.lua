local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = { diagnostics = { globals = { 'vim' } } },
  },
})

vim.lsp.config("nixd", {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake (toString /etc/nixos)).nixosConfigurations.wildfire.options',
        },
        home_manager = {
          -- expr = '(builtins.getFlake (toString /etc/nixos)).homeConfigurations."byte@wildfire".options',
	  expr = '(builtins.getFlake (builtins.toString /etc/nixos)).nixosConfigurations.wildfire.options.home-manager.users.type.getSubOptions []',
        },
      },
    },
  },
})

vim.lsp.enable({ 'lua_ls', 'nixd', 'clangd', 'cmake', })

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
