{config, ...}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "ibuysausage";
      user.email = "bannansmooth68@proton.me";
    };
  };
}
