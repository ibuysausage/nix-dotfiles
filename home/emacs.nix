{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    # Opens fancy dashboard
    # client.arguments = ["-c" "-e" "\"(fancy-startup-screen)\""];
    startWithUserSession = true;
    defaultEditor = true;
  };
}
