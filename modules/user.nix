{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;
  users.users.byte = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmgr"
      "docker"
      "input"
    ];
  };
}
