{
  pkgs,
  config,
  ...
}: {
  programs.niri = {
    enable = true;

    settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      input = {
        mod-key = "Alt";
        mod-key-nested = "Super";

        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
          accel-profile = "flat";
          accel-speed = 0.9;
          disabled-on-external-mouse = true;
        };

        keyboard = {
          numlock = true;
        };
      };

      outputs."eDP-1" = {
        enable = true;
        scale = 1;

        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };

        position = {
          x = 1280;
          y = 0;
        };
      };

      layout = {
        gaps = 16;
        center-focused-column = "never";

        #focus-ring = {
        #  enable = true;
        #  width = 4;
        #};

        border = {
          enable = true;
        };

        shadow = {
          enable = true;
          softness = 30;
          spread = 5;

          offset = {
            x = 0;
            y = 5;
          };
        };
      };

      animations = {
        slowdown = 3;
      };

      window-rules = [
        {
          matches = [
            {app-id = "librewolf";}
            {app-id = "kitty";}
          ];
          open-maximized = true;
        }
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
        }
      ];

      switch-events = {
        lid-close.action.spawn = ["swaylock"];
      };

      spawn-at-startup = [
        {argv = ["${pkgs.swaybg}/bin/swaybg" "-i" "${config.stylix.image}" "-m" "fill"];}
        {argv = ["qs" "-c" "cheapbar"];}
      ];

      binds = {
        "Mod+Shift+Slash".action.show-hotkey-overlay = [];

        "Mod+W" = {
          action.spawn = "kitty";
          hotkey-overlay.title = "Open a Terminal: kitty";
        };
        "Mod+Space" = {
          action.spawn-sh = "rofi -show drun -show-icons";
          hotkey-overlay.title = "Run an Application: rofi";
        };
        "Mod+Shift+Return" = {
          action.spawn = "swaylock";
          hotkey-overlay.title = "Lock the Screen: swaylock";
        };

        "XF86AudioRaiseVolume" = {
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn-sh = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          allow-when-locked = true;
        };

        "XF86AudioPlay" = {
          action.spawn-sh = "playerctl play-pause";
          allow-when-locked = true;
        };
        "XF86AudioPause" = {
          action.spawn-sh = "playerctl play-pause";
          allow-when-locked = true;
        };
        "XF86AudioStop" = {
          action.spawn-sh = "playerctl stop";
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn-sh = "playerctl previous";
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action.spawn-sh = "playerctl next";
          allow-when-locked = true;
        };

        "XF86MonBrightnessUp" = {
          action.spawn-sh = "brightnessctl set 5%+ ";
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn-sh = "brightnessctl set 5%-";
          allow-when-locked = true;
        };

        "Mod+O" = {
          action.toggle-overview = [];
          repeat = false;
        };
        "Mod+Q" = {
          action.close-window = [];
          repeat = false;
        };

        "Mod+H".action.focus-column-left = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+L".action.focus-column-right = [];
        "Mod+Shift+H".action.move-column-left = [];
        "Mod+Shift+J".action.move-window-down = [];
        "Mod+Shift+K".action.move-window-up = [];
        "Mod+Shift+L".action.move-column-right = [];

        # Alternative commands that move across workspaces when reaching
        # the first or last window in a column.
        # "Mod+J".action.focus-window-or-workspace-down = [ ];
        # "Mod+K".action.focus-window-or-workspace-up = [ ];
        # "Mod+Ctrl+J".action.move-window-down-or-to-workspace-down = [ ];
        # "Mod+Ctrl+K".action.move-window-up-or-to-workspace-up = [ ];

        "Mod+Home".action.focus-column-first = [];
        "Mod+End".action.focus-column-last = [];
        "Mod+Ctrl+Home".action.move-column-to-first = [];
        "Mod+Ctrl+End".action.move-column-to-last = [];

        "Mod+Shift+Left".action.focus-monitor-left = [];
        "Mod+Shift+Down".action.focus-monitor-down = [];
        "Mod+Shift+Up".action.focus-monitor-up = [];
        "Mod+Shift+Right".action.focus-monitor-right = [];

        # never gonna have another monitor

        # "Mod+Shift+H".action.focus-monitor-left = [ ];
        # "Mod+Shift+J".action.focus-monitor-down = [ ];
        # "Mod+Shift+K".action.focus-monitor-up = [ ];
        # "Mod+Shift+L".action.focus-monitor-right = [ ];

        # "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [ ];
        # "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [ ];
        # "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [ ];
        # "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [ ];
        # "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [ ];
        # "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [ ];
        # "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [ ];
        # "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [ ];

        # Alternatively, there are commands to move just a single window:
        # "Mod+Shift+Ctrl+Left".action.move-window-to-monitor-left = [ ];
        # ...

        # And you can also move a whole workspace to another monitor:
        # "Mod+Shift+Ctrl+Left".action.move-workspace-to-monitor-left = [ ];
        # ...

        "Mod+Page_Down".action.focus-workspace-down = [];
        "Mod+Page_Up".action.focus-workspace-up = [];
        "Mod+U".action.focus-workspace-down = [];
        "Mod+I".action.focus-workspace-up = [];
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
        "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

        # Alternatively, there are commands to move just a single window:
        # "Mod+Ctrl+Page_Down".action.move-window-to-workspace-down = [ ];
        # ...

        "Mod+Shift+Page_Down".action.move-workspace-down = [];
        "Mod+Shift+Page_Up".action.move-workspace-up = [];
        "Mod+Shift+U".action.move-workspace-down = [];
        "Mod+Shift+I".action.move-workspace-up = [];

        # You can bind mouse wheel scroll ticks using the following syntax.
        # These binds will change direction based on the natural-scroll setting.
        #
        # To avoid scrolling through workspaces really fast, you can use
        # the cooldown-ms property. The bind will be rate-limited to this value.
        # You can set a cooldown on any bind, but it's most useful for the wheel.
        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = [];
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = [];
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action.move-column-to-workspace-down = [];
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action.move-column-to-workspace-up = [];
          cooldown-ms = 150;
        };

        "Mod+WheelScrollRight".action.focus-column-right = [];
        "Mod+WheelScrollLeft".action.focus-column-left = [];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];

        # Usually scrolling up and down with Shift in applications results in
        # horizontal scrolling; these binds replicate that.
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [];

        # Similarly, you can bind touchpad scroll "ticks".
        # Touchpad scrolling is continuous, so for these binds it is split into
        # discrete intervals.
        # These binds are also affected by touchpad's natural-scroll, so these
        # example binds are "inverted", since we have natural-scroll enabled for
        # touchpads by default.
        # "Mod+TouchpadScrollDown".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02+";
        # "Mod+TouchpadScrollUp".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02-";

        # You can refer to workspaces by index. However, keep in mind that
        # niri is a dynamic workspace system, so these commands are kind of
        # "best effort". Trying to refer to a workspace index bigger than
        # the current workspace count will instead refer to the bottommost
        # (empty) workspace.
        #
        # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # will all refer to the 3rd workspace.
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        # Alternatively, there are commands to move just a single window:
        # "Mod+Ctrl+1".action.move-window-to-workspace = 1;

        # Switches focus between the current and the previous workspace.
        # "Mod+Tab".action.focus-workspace-previous = [ ];

        # The following binds move the focused window in and out of a column.
        # If the window is alone, they will consume it into the nearby column to the side.
        # If the window is already in a column, they will expel it out.
        "Mod+BracketLeft".action.consume-or-expel-window-left = [];
        "Mod+BracketRight".action.consume-or-expel-window-right = [];

        # Consume one window from the right to the bottom of the focused column.
        "Mod+Comma".action.consume-window-into-column = [];
        # Expel the bottom window from the focused column to the right.
        "Mod+Period".action.expel-window-from-column = [];

        # Cycle through widths set in preset-column-widths.
        "Mod+R".action.switch-preset-column-width = [];
        # Cycling through the presets in reverse order is also possible.
        "Mod+Shift+R".action.switch-preset-column-width-back = [];

        "Mod+Ctrl+Shift+R".action.switch-preset-window-height = [];
        "Mod+Ctrl+R".action.reset-window-height = [];

        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];

        # While maximize-column leaves gaps and borders around the window,
        # maximize-window-to-edges doesn't: the window expands to the edges of the screen.
        # This bind corresponds to normal window maximizing,
        # e.g. by double-clicking on the titlebar.
        # "Mod+M".action.maximize-window-to-edges = [ ];

        # Expand the focused column to space not taken up by other fully visible columns.
        # Makes the column "fill the rest of the space".
        "Mod+Ctrl+F".action.expand-column-to-available-width = [];

        "Mod+C".action.center-column = [];

        # Center all fully visible columns on screen.
        "Mod+Ctrl+C".action.center-visible-columns = [];

        # Finer width adjustments.
        # This command can also:
        # * set width in pixels: "1000"
        # * adjust width in pixels: "-5" or "+5"
        # * set width as a percentage of screen width: "25%"
        # * adjust width as a percentage of screen width: "-10%" or "+10%"
        # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # set-column-width "100" will make the column occupy 200 physical screen pixels.
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        # Finer height adjustments when in column with other windows.
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Move the focused window between the floating and the tiling layout.
        "Mod+V".action.toggle-window-floating = [];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

        # Toggle tabbed column display mode.
        # Windows in this column will appear as vertical tabs,
        # rather than stacked on top of each other.
        # "Mod+W".action.toggle-column-tabbed-display = [ ];

        # Actions to switch layouts.
        # Note: if you uncomment these, make sure you do NOT have
        # a matching layout switch hotkey configured in xkb options above.
        # Having both at once on the same hotkey will break the switching,
        # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        # "Mod+Space".action.switch-layout = "next";
        # "Mod+Shift+Space".action.switch-layout = "prev";

        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
        "Alt+Print".action.screenshot-window = [];

        # Applications such as remote-desktop clients and software KVM switches may
        # request that niri stops processing the keyboard shortcuts defined here
        # so they may, for example, forward the key presses as-is to a remote machine.
        # It's a good idea to bind an escape hatch to toggle the inhibitor,
        # so a buggy application can't hold your session hostage.
        #
        # The allow-inhibiting=false property can be applied to other binds as well,
        # which ensures niri always processes them, even when an inhibitor is active.
        "Mod+Escape" = {
          action.toggle-keyboard-shortcuts-inhibit = [];
          allow-inhibiting = false;
        };

        # The quit action will show a confirmation dialog to avoid accidental exits.
        "Mod+Shift+Q".action.quit = [];

        # Powers off the monitors. To turn them back on, do any input like
        # moving the mouse or pressing any other key.
        "Mod+Shift+P".action.power-off-monitors = [];
      };

      #programs.niri.settings.spawn-at-startup = [
      #  { argv = [ "noctalia" ]; }
      #];
      #}
    };
  };
}
