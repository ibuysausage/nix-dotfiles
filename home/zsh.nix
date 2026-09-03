{...}: {
  programs.carapace = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      save = 1000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "dirhistory"
        "history"
      ];
    };

    sessionVariables = {
      EDITOR = "vim";
      CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense";
    };

    shellAliases = {
      ls = "eza --icons always";
      cat = "bat";
      lg = "lazygit";
      man = "batman";
      ff = "clear";
      v = "nvim";
      # No fastfetch needed because clear alias already has && fastfetch
      c = "clear";
      clear = "clear && fastfetch";
      tree = "eza -T --icons always";
      dockerclean = "docker system prune -a --volumes";
    };

    initContent = ''
      fastfetch
      unsetopt BANG_HIST

      # switch-to-configuration swith
      export PATH="$PATH:/run/current-system/bin"

      # cargo programs
      export PATH="$PATH:/home/byte/.cargo/bin"
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      setopt NO_CASE_GLOB
      zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      # Add devenv
      eval "$(devenv hook zsh)"

      # Fzf history search
      source <(fzf --zsh)
    '';
  };
}
