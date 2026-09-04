{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
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
    ./theme.nix
  ];
}
