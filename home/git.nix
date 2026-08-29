{...}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "ibuysausage";
      user.email = "bannansmooth68@proton.me";

      pull.rebase = true;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
