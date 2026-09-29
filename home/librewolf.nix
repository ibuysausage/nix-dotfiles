{
  lib,
  pkgs,
  ...
}: {
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
        "font.name.serif.x-western" = "Literata";
        "font.name.sans-serif.x-western" = "Inter";
        "font.name.monospace.x-western" = lib.mkForce "JetBrains Mono";
        "font.default.x-western" = "sans-serif";
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
