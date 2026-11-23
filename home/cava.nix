{pkgs, ...}: {
  programs.cava = {
    enable = true;
    package = pkgs.writeShellScriptBin "cava" ''
      [ -t 0 ] || exec st -c st-plain -g 150x35+400+200 -e ${pkgs.cava}/bin/cava "$@"
      exec ${pkgs.cava}/bin/cava "$@"
    '';
  };
}
