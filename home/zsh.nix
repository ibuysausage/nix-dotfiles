{config, ...}: {
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
      size = 100000;
      save = 100000;
      append = true;
      path = "${config.home.homeDirectory}/.histfile";
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
      CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense";
    };

    shellAliases = {
      ls = "eza --icons always --total-size -lh";
      cat = "bat";
      lg = "lazygit";
      man = "batman";
      ff = "clear";
      v = "nvim";
      vnix = "nvim /etc/nixos";
      no = "yes n";
      grabs = "grim -g $(slurp)";
      # No fastfetch needed because clear alias already has && fastfetch
      c = "clear";
      clear = "clear && fastfetch";
      tree = "eza -T --icons always";
      restarte = "systemctl --user restart emacs";
      cursor = "echo -ne '\e[6 q'";
    };

    initContent = ''
      if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ "$TERM" != linux ]] && [[ -z "$INSIDE_EMACS" ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
         exec tmux new-session -A -s main
      fi

      unsetopt BANG_HIST
      export PATH="$PATH:/run/current-system/bin"

      export PATH="$PATH:/home/byte/.cargo/bin"
      zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
      setopt NO_CASE_GLOB
      zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      # Fzf history search
      source <(fzf --zsh)

      vterm_printf() {
          if [ -n "$TMUX" ] \
              && { [ "''${TERM%%-*}" = "tmux" ] \
                  || [ "''${TERM%%-*}" = "screen" ]; }; then
              # Tell tmux to pass the escape sequences through
              printf "\ePtmux;\e\e]%s\007\e\\" "$1"
          elif [ "''${TERM%%-*}" = "screen" ]; then
              # GNU screen (screen, screen-256color, screen-256color-bce)
              printf "\eP\e]%s\007\e\\" "$1"
          else
              printf "\e]%s\e\\" "$1"
          fi
      }

      fastfetch

      # Add devenv
      eval "$(devenv hook zsh)"

      nvim() {
        command nvim "$@"
        echo -ne "\e[6 q"
      }

      _splatoon_venv() {
        local venv="$HOME/splatoon/splatoon"
        if [[ "$PWD" == "$HOME/splatoon" || "$PWD" == "$HOME/splatoon/"* ]]; then
          # inside ~/splatoon or any subdir: make sure our venv is active
          [[ "$VIRTUAL_ENV" != "$venv" ]] && source "$venv/bin/activate"
        elif [[ "$VIRTUAL_ENV" == "$venv" ]] && (( $+functions[deactivate] )); then
          # left the tree: deactivate, but only if it's this venv
          deactivate
        fi
      }
      
      autoload -U add-zsh-hook
      add-zsh-hook chpwd _splatoon_venv
      _splatoon_venv   # also run once at shell startup

      docker() {
          case "$1" in
              clean)
                  command docker system prune -af
                  ;;
              *)
                  command docker "$@"
                  ;;
          esac
      }
    '';
  };
}
