require('config.options')
require('config.keybinds')
require('config.lazy')

local nvim_lsp = vim.lsp
nvim_lsp.config("nixd", {
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
          expr = '(builtins.getFlake (toString ./.)).nixosConfigurations.wildfire.options',
        },
        home_manager = {
          expr = '(builtins.getFlake (toString ./.)).homeConfigurations."byte@wildfire".options',
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

nvim_lsp.enable("nixd")

