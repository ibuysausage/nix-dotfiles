{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    extensions = {
      force = true;
      packages = with pkgs.nur.repos.rycee.firefox-addons; [
        # ublock-origin
        darkreader
        sidebery
      ];
    };
  };
}
