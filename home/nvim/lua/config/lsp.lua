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
					expr =
					'(builtins.getFlake (builtins.toString /etc/nixos)).nixosConfigurations.wildfire.options.home-manager.users.type.getSubOptions []',
				},
			},
		},
	},
})

vim.lsp.config("rust-analyzer", {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { 'Cargo.toml', 'rust-project.json' },
	settings = {
		['rust-analyzer'] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = 'clippy' },
		},
	},
})

vim.lsp.enable({ 'lua_ls', 'nixd', 'clangd', 'cmake', 'marksman', 'rust-analyzer', })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	float = {
		border = "rounded",
		source = true,
	},
})
