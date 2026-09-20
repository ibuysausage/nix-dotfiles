{...}: {
  networking = {
    networkmanager.enable = true;
    interfaces.wlp1s0.ipv4.addresses = [
      {
        address = "192.168.4.30";
        prefixLength = 24;
      }
    ];

    defaultGateway = "192.168.4.1";
    nameservers = ["127.0.0.1"];
    firewall.allowedTCPPorts = [8080 3000 8888 53];
    firewall.allowedUDPPorts = [53];
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  programs.ssh.startAgent = true;

  users.users."root".openssh.authorizedKeys.keys = [
    (builtins.readFile ../../keys/id_byte.pub)
  ];
}
