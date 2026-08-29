{
  pkgs,
  config,
  ...
}: {
  sops.secrets.byte-password.neededForUsers = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.byte = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.byte-password.path;
    extraGroups = [
      "wheel"
      "networkmgr"
      "docker"
      "input"
    ];
  };
}
