{ config, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;

    config = {
      modifier = "Mod1";
      up = "k";
      down = "j";
      left = "h";
      right = "l";
      menu = "rofi -show-drun -show-icons --theme ~/.config/rofi/config.rasi";
      terminal = "kitty";

      keybindings = {
        "Mod1+w" = "exec kitty";
        "Mod1+Space" = "exec rofi -show drun -show-icons --theme ~/.config/rofi/config.rasi";
        "Mod1+q" = "kill";
        "Mod1+p" = "exec grim ~/Pictures/Screenshots/$(date +%s).png";
        "Mod1+r" = "mode resize";

        "Mod1+Shift+c" = "reload";
        "Mod1+Shift+q" = "exit";
        "Mod1+shift+Return" = "exec swaylock -f";

        "Mod1+h" = "focus left";
        "Mod1+j" = "focus down";
        "Mod1+k" = "focus up";
        "Mod1+l" = "focus right";

        "Mod1+Shift+h" = "focus left";
        "Mod1+Shift+j" = "focus down";
        "Mod1+Shift+k" = "focus up";
        "Mod1+Shift+l" = "focus right";

        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86AudioStop" = "exec playerctl stop";
        "XF86AudioLowerVolume" = "exec ~/.config/sway/volume.sh down";
        "XF86AudioRaiseVolume" = "exec ~/.config/sway/volume.sh up";
        "XF86MonBrightnessDown" = "exec ~/.config/sway/brightness.sh down";
        "XF86MonBrightnessUp" = "exec ~/.config/sway/brightness.sh up";
      };

      modes = {
        resize = {
          "Mod1+h" = "resize shrink width 10 px";
          "Mod1+j" = "resize grow height 10 px";
          "Mod1+k" = "resize shrink height 10 px";
          "Mod1+l" = "resize grow width 10 px";

          "Escape" = "mode default";
          "Return" = "mode default";
        };
      };

      fonts = {
        names = [ "Caskaydia Nerd Font Mono" ];
        size = 10.0;
      };

      bars = [
        {
          position = "top";
          statusCommand = "while ~/.config/sway/status.sh; do sleep 1; done";

          fonts = {
            names = [ "CaskaydiaCove Nerd Font Mono" ];
            size = 11.0;
          };

          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = {
              border = "#32323200";
              background = "#32323200";
              text = "#5c5c5c";
            };
          };
        }
      ];

      input = {
        "type:touchpad" = {
          accel_profile = "flat";
          pointer_accel = "0.9";
          dwt = "disabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };

        "type:keyboard" = {
          xkb_layout = "us";
        };

        "type:mouse" = {
          accel_profile = "flat";
          pointer_accel = "0.9";
        };
      };

      output = {
        "*" = {
          bg = "${config.home.homeDirectory}/Pictures/Wallpapers/fractal.png fill";
        };

        eDP-1 = {
          mode = "1920x1080";
        };
      };

      startup = [
        {
          command = "autotiling";
          always = true;
        }
      ];
    };

    extraConfig = ''
      set $mod Mod1
      floating_modifier $mod normal

      bindswitch --reload --locked lid:on exec swaylock -f

      bindsym $mod+1 workspace number 1
      bindsym $mod+2 workspace number 2
      bindsym $mod+3 workspace number 3
      bindsym $mod+4 workspace number 4
      bindsym $mod+5 workspace number 5
      bindsym $mod+6 workspace number 6
      bindsym $mod+7 workspace number 7
      bindsym $mod+8 workspace number 8
      bindsym $mod+9 workspace number 9
      bindsym $mod+0 workspace number 10
      bindsym $mod+Shift+1 move container to workspace number 1
      bindsym $mod+Shift+2 move container to workspace number 2
      bindsym $mod+Shift+3 move container to workspace number 3
      bindsym $mod+Shift+4 move container to workspace number 4
      bindsym $mod+Shift+5 move container to workspace number 5
      bindsym $mod+Shift+6 move container to workspace number 6
      bindsym $mod+Shift+7 move container to workspace number 7
      bindsym $mod+Shift+8 move container to workspace number 8
      bindsym $mod+Shift+9 move container to workspace number 9
      bindsym $mod+Shift+0 move container to workspace number 10
    '';
  };
}
