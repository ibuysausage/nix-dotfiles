{...}: {
  sops = {
    defaultSopsFile = ../secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/byte/.config/sops/age/keys.txt";

    # secrets = {
    #   "private-keys/byte" = {
    #     path = "/home/byte/.ssh/id_demo";
    #   };
    # };
  };
}
