{...}: {
  programs.btop.enable = true;
  programs.fzf.enable = true;
  programs.lazygit.enable = true;
  programs.yazi.enable = true;
  dconf.enable = true;
  gtk.enable = true;
  qt.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };
}
