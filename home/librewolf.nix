{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    profiles.byte = {
      id = 0;
      isDefault = true;
      path = "default";
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "ui.systemUsesDarkTheme" = 1;
        # Sets font for webpage
        "browser.display.use_document_fonts" = 0;
      };

      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          sidebery
        ];
      };
    };
  };
}
