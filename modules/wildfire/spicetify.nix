{
  pkgs,
  inputs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      adblock
      popupLyrics
      wikify
      oneko
      aiBandBlocker
      ytVideo
    ];
    # MY BOY STYLIX GOT U DAWG
    #
    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = "mocha";
  };
}
