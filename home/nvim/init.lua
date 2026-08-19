require('config.options')
require('config.keybinds')
require('config.lazy')

--vim.lsp.config("nixd", {
--  cmd = { "nixd" },
--  settings = {
--    nixd = {
--      nixpkgs = {
--        expr = "import <nixpkgs> { }",
--      },
--      formatting = {
--        command = { "nixfmt" }, -- or nixfmt or nixpkgs-fmt
--      },
--      options = {
--	nixos = {
--	    expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.wildfire.options',
--        },
--        home_manager = {
--            expr = '(builtins.getFlake "/etc/nixos").homeConfigurations.wildfire.options',
--        },
--      },
--    },
--  },
--})
--
--vim.lsp.enable('nixd')
