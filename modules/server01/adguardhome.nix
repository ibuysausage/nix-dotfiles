_: {
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      http.address = "0.0.0.0:8888";
    };
  };
}
