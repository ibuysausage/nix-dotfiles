{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    waylandSupport = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    extraLuaPackages = luaPkgs: [luaPkgs.jsregexp];

    initLua = builtins.readFile ./nvim/init.lua;
  };
}
