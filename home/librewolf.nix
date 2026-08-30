{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    profiles.byte = {
      id = 0;
      isDefault = true;
      path = "default";
      extensions.force = true;
      settings = {
      };
    };

    globalExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      darkreader
      sidebery
    ];
  };
}
# why have to be so hard to work with nixos

