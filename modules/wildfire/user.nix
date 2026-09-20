{
  pkgs,
  config,
  ...
}: {
  sops.secrets.byte-password.neededForUsers = true;
  users.mutableUsers = false;

  users = {
    defaultUserShell = pkgs.zsh;
    users.byte = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.byte-password.path;
      extraGroups = [
        "wheel"
        "networkmgr"
        "docker"
        "input"
      ];
    };
  };
}
