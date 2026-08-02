{ config, pkgs, inputs, ... }:

{

  programs.librewolf = {
    enable = true;

    globalExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      darkreader
      sidebery
    ];
  };

}
