{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    configPath = ".librewolf";
    profiles.byte = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "signon.rememberSignons" = true;
      };

      userChrome = ''
        * { border-radius: 0px !important; }
      '';
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          # ublock-origin
          darkreader
          sidebery
        ];
      };
    };
  };
}
