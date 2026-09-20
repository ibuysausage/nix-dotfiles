_: {
  programs = {
    btop.enable = true;
    fzf.enable = true;
    lazygit.enable = true;
    yazi.enable = true;
  };

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
