{config, ...}: {
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      # sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/home/byte/.config/sops/age/keys.txt";
      generateKey = true;
    };

    secrets.github-pat = {};

    templates."nix-access-tokens.conf".content = ''
      access-tokens = github.com=${config.sops.placeholder.github-pat}
    '';
  };

  nix.extraOptions = ''
    !include ${config.sops.templates."nix-access-tokens.conf".path}
  '';
}
