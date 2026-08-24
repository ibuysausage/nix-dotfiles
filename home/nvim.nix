{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    waylandSupport = true;
    extraLuaPackages = luaPkgs: [luaPkgs.jsregexp];

    initLua = builtins.readFile ./nvim/init.lua;
  };
}
