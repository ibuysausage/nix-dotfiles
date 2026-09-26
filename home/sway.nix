_: {
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

      floating = {
        modifier = "Mod1";
        criteria = [
          {class = "Emulator";}
        ];
      };

      window = {
        commands = [
          {
            command = "resize set 480 800";
            criteria = {
              class = "Emulator";
              title = "Android Emulator - NSA:5554";
            };
          }
          {
            command = "move position 100 100";
            criteria = {
              class = "Emulator";
              title = "Android Emulator - NSA:5554";
            };
          }
          {
            command = "floating enable";
            criteria = {
              class = "jetbrains-studio";
            };
          }
        ];
      };

      keybindings = {
        "Mod1+w" = "exec kitty";
        "Mod1+Space" = "exec rofi -show drun";
        "Mod1+q" = "kill";
        "Mod1+p" = "exec grim \"$HOME/Pictures/Screenshots/$(date +\"%Y-%m-%d %I:%M:%S %p\").png\"";
        "Mod1+Shift+p" = "exec grim -g \"$(slurp)\" \"$HOME/Pictures/Screenshots/$(date +\"%Y-%m-%d %I:%M:%S %p\").png\"";
        "Mod1+Shift+c" = "reload";
        "Mod1+Shift+q" = "exit";
        "Mod1+shift+Return" = "exec swaylock -f";

        # Window keybinds
        "Mod1+Shift+space" = "floating toggle";

        # change focus
        "Mod1+h" = "focus left";
        "Mod1+j" = "focus down";
        "Mod1+k" = "focus up";
        "Mod1+l" = "focus right";

        # move floating window
        "Mod1+Shift+h" = "move left 20px";
        "Mod1+Shift+j" = "move down 20px";
        "Mod1+Shift+k" = "move up 20px";
        "Mod1+Shift+l" = "move right 20px";

        # Caps is binded to esc
        "Escape+h" = "resize shrink width 10 px";
        "Escape+j" = "resize grow height 10 px";
        "Escape+k" = "resize shrink height 10 px";
        "Escape+l" = "resize grow width 10 px";

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

      bars = [
        {
          position = "top";
          statusCommand = "while ~/.config/sway/status.sh; do sleep 1; done";

          fonts.size = 11.0;

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
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };

        "type:keyboard" = {
          xkb_layout = "us";
          xkb_options = "caps:escape";
        };

        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0.6";
          natural_scroll = "enabled";
        };
      };

      output = {
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
      bindswitch --reload --locked lid:on exec swaylock -f

      bindsym Mod1+1 workspace number 1
      bindsym Mod1+2 workspace number 2
      bindsym Mod1+3 workspace number 3
      bindsym Mod1+4 workspace number 4
      bindsym Mod1+5 workspace number 5
      bindsym Mod1+6 workspace number 6
      bindsym Mod1+7 workspace number 7
      bindsym Mod1+8 workspace number 8
      bindsym Mod1+9 workspace number 9
      bindsym Mod1+0 workspace number 10
      bindsym Mod1+Shift+1 move container to workspace number 1
      bindsym Mod1+Shift+2 move container to workspace number 2
      bindsym Mod1+Shift+3 move container to workspace number 3
      bindsym Mod1+Shift+4 move container to workspace number 4
      bindsym Mod1+Shift+5 move container to workspace number 5
      bindsym Mod1+Shift+6 move container to workspace number 6
      bindsym Mod1+Shift+7 move container to workspace number 7
      bindsym Mod1+Shift+8 move container to workspace number 8
      bindsym Mod1+Shift+9 move container to workspace number 9
      bindsym Mod1+Shift+0 move container to workspace number 10
    '';
  };
}
