{pkgs, ...}: let
  shimmer = pkgs.fetchFromGitHub {
    owner = "nuclearcodecat";
    repo = "shimmer";
    rev = "c346a37";
    sha256 = "sha256-z3yEiKFkuQNOzdaAt7vGsB3V/7XgcaFN48uihjSFoz8=";
  };
in {
  programs.librewolf = {
    enable = true;
    profiles.byte = {
      id = 0;
      isDefault = true;
      path = "default";
      settings = {
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        toolkit.legacyUserProfileCustomizations.stylesheets = true;
        svg.context-properties.content.enabled = true;
        browser.urlbar.scotchBonnet.enableOverride = false;
        sidebar.revamp = false;
        shimmer.enable-theme-aware-wallpapers = true;
      };
      userChrome = builtins.readFile "${shimmer}/userChrome.css";
      userContent = builtins.readFile "${shimmer}/userContent.css";
    };
    globalExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      darkreader
      sidebery
    ];
  };

  home.file.".librewolf/default/chrome/assets" = {
    source = "${shimmer}/assets";
    recursive = true;
  };
}
