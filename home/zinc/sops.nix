_: {
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/zinc/.config/sops/age/keys.txt";

    secrets = {
      "private-keys/zinc" = {
        path = "/home/zinc/.ssh/id_ed25519";
      };
    };
  };
}
