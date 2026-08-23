{config, ...}: let
  inherit (config.lib.formats.rasi) mkLiteral;
in {
  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "drun,window,run";
      icon-theme = "Papirus-Dark";
      show-icons = true;
      terminal = "kitty";
      font = "CaskaydiaCove Nerd Font 14";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      sidebar-mode = false;
      display-drun = " ";
      display-run = " ";
      display-window = " ";
      kb-row-up = "Up,Control+k";
      kb-row-left = "Left,Control+h";
      kb-row-right = "Right,Control+l";
      kb-row-down = "Down,Control+j";
      kb-accept-entry = "Control+z,Control+y,Return,KP_Enter";
      kb-remove-to-eol = "";
      kb-move-char-back = "Control+b";
      kb-remove-char-back = "BackSpace";
      kb-move-char-forward = "Control+f";
      kb-mode-complete = "Control+o";
    };

    theme = {
      window = {
        width = mkLiteral "900";
        orientation = mkLiteral "horizontal";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        transparency = "screenshot";
        border = mkLiteral "0px";
        border-radius = mkLiteral "6px";
        spacing = mkLiteral "0";
        children = mkLiteral "[ mainbox ]";
      };
      mainbox = {
        spacing = mkLiteral "0";
        children = mkLiteral "[ inputbar, message, listview ]";
      };
      inputbar = {
        padding = mkLiteral "11px";
        border = mkLiteral "3px 3px 2px 3px";
        border-radius = mkLiteral "6px 6px 0px 0px";
      };
      message = {
        padding = mkLiteral "0";
        border = mkLiteral "0px 1px 1px 1px";
      };
      "entry, prompt, case-indicator" = {
        text-font = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      entry = {cursor = "pointer";};
      prompt = {margin = mkLiteral "0px 5px 0px 0px";};
      listview = {
        layout = mkLiteral "vertical";
        padding = mkLiteral "8px";
        lines = mkLiteral "10";
        columns = mkLiteral "1";
        border = mkLiteral "0px 3px 3px 3px";
        border-radius = mkLiteral "0px 0px 6px 6px";
        dynamic = false;
      };
      element = {
        padding = mkLiteral "2px";
        vertical-align = mkLiteral "1";
        font = mkLiteral "inherit";
      };
      element-text = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
      };
      element-icon = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        size = mkLiteral "2.5em";
      };
      button = {
        padding = mkLiteral "6px";
        horizontal-align = mkLiteral "0.5";
        border = mkLiteral "2px 0px 2px 2px";
        border-radius = mkLiteral "4px 0px 0px 4px";
      };
      "button selected normal" = {
        border = mkLiteral "2px 0px 2px 2px";
      };
    };
  };
}
