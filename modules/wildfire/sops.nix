{config, ...}: {
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets.devenv-pat = {};

    templates."nix-access-tokens.conf".content = ''
      access-tokens = github.com=${config.sops.placeholder.devenv-pat}
    '';
  };

  nix.extraOptions = ''
    !include ${config.sops.templates."nix-access-tokens.conf".path}
  '';
}
