{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    waylandSupport = true;
    withPython3 = true;

    initLua = builtins.readFile ./nvim/init.lua;
  };
}
