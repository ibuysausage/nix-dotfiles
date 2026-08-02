{ config, pkgs, inputs, ... }:

{

  programs.librewolf = {
    enable = true;

    profiles.byte = {
      id = 0;
      isDefault = true;
      path = "default";

      settings = {
        toolkit.legacyUserProfileCustomizations.stylesheets = true;
        svg.context-properties.content.enabled = true;
        browser.urlbar.scotchBonnet.enableOverride = true;
        sidebar.revamp = false;
      };
    };

    globalExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      darkreader
      sidebery
    ];
  };

}
