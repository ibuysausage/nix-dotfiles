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
        #TabsToolbar { display: none !important; }
        #sidebar-panel-header { display: none !important; }
        #sidebar-box { padding-inline-start: 0px !important; }
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
