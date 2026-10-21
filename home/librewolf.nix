{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    configPath = ".librewolf";
    profiles.byte = {
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
