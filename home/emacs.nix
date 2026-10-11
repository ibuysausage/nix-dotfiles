_: {
  programs.emacs = {
    enable = true;
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
