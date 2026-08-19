require('config.options')
require('config.keybinds')
require('config.lazy')

vim.lsp.config("nixd", {
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        -- Flake-based: resolves your actual nixpkgs input, doesn't need $NIX_PATH.
        expr = 'import (builtins.getFlake "/etc/nixos").inputs.nixpkgs { }',
      },
      formatting = {
        command = { "alejandra" },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.wildfire.options',
        },
        home_manager = {
          expr = '(builtins.getFlake "/etc/nixos").homeConfigurations.wildfire.options',
        },
      },
    },
  },
})

vim.lsp.enable("nixd")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.nix",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
