{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    waylandSupport = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      python3Packages.pynvim
    ];

    extraConfig = ''
      vim.opt.clipboard = "unnamedplus"
    '';
  };
}
