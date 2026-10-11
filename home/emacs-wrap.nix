{pkgs, ...}: let
  emacsclientLauncher = pkgs.writeShellScriptBin "emacsclient-launcher" ''
    if [ "$#" -gt 0 ]; then
      exec emacsclient --alternate-editor= --display="$DISPLAY" "$@"
    else
      exec emacsclient --alternate-editor= --create-frame
    fi
  '';
in {
  # A wrapper that makes the regular emacs dekstop file run emacsclient
  # because emacsclient has a faster start up time.

  home.packages = [emacsclientLauncher];

  xdg.desktopEntries.emacs = {
    name = "Emacs";
    genericName = "Text Editor";
    comment = "Edit text";

    mimeType = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "text/x-c"
      "text/x-c++"
      "x-scheme-handler/org-protocol"
    ];

    exec = "${emacsclientLauncher}/bin/emacsclient-launcher %F";
    icon = "emacs";
    type = "Application";
    terminal = false;
    categories = ["Development" "TextEditor"];
    settings = {
      StartupNotify = "true";
      StartupWMClass = "Emacs";
      Keywords = "emacsclient;";
    };

    actions = {
      new-window = {
        name = "New Window";
        exec = "emacsclient --alternate-editor= --create-frame %F";
      };

      new-instance = {
        name = "New Instance";
        exec = "emacs %F";
      };
    };
  };
}
