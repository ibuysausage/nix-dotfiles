{
  pkgs,
  inputs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    imports = [
      ./auto_cmds.nix
    ];

    extraPackages = [
      pkgs.luaPackages.tree-sitter-cli
    ];
    extraConfigLua = ''
      vim.opt.runtimepath:append("~/.local/share/nvim/site")
    '';
  };
  imports = [
    ./settings.nix
    ./lsp.nix
    ./keymaps.nix
    ./plugins.nix
    ./telescope.nix
    ./cmp.nix
    ./theme.nix
  ];
}
