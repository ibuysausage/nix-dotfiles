{
  inputs,
  pkgs,
  ...
}: {
  services.flameshot = {
    enable = true;
    package = inputs.nixpkgs-flameshot.legacyPackages.${pkgs.system}.flameshot;
    #settings = {
    #
    #};
  };
}
