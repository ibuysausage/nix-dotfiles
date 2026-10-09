{pkgs, ...}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users.zinc = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmgr"
        "input"
      ];
    };
  };
  programs.zsh.enable = true;
}
