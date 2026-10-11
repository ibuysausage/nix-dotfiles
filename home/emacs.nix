_: {
  programs.emacs = {
    enable = true;
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    client.arguments = ["-c" "-e" "\"(fancy-startup-screen)\""];
    startWithUserSession = true;
    defaultEditor = true;
  };
}
