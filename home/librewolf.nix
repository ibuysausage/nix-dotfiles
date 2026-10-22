{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    configPath = ".librewolf";
    profiles.byte = {
      settings = {
        "signon.rememberSignons" = true;
      };

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
