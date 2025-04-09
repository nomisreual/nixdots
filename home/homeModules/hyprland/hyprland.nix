{pkgs, ...}: let
  # Rosé Pine Moon Color Palette:
  iris = "0xffc4a7e7";
  muted = "0xff6e6a86";
  base = "0xff232136";
  surface = "0xff2a273f";
  overlay = "0xff393552";
  subtle = "0xff908caa";
  text = "0xffe0def4";
  love = "0xffeb6f92";
  gold = "0xfff6c177";
  rose = "0xffea9a97";
  pine = "0xff3e8fb0";
  foam = "0xff9ccfd8";
  highlightLow = "0xff2a283e";
  highlightMed = "0xff44415a";
  highlightHigh = "0xff56526e";

  # My programs
  terminal = "kitty";
  menu = "wofi --show drun";

  hyprshot = "${pkgs.hyprshot}/bin/hyprshot";
  pypr = "${pkgs.pyprland}/bin/pypr";

  myMonitor = "DP-2, 1920x1080@165, 0x0, 1";

  switchworkspace = builtins.genList (x: "$mainMod, ${builtins.toString (x + 1)}, workspace, ${builtins.toString (x + 1)}") 8;

  movetoworkspace = builtins.genList (x: "$mainMod SHIFT, ${builtins.toString (x + 1)}, movetoworkspace, ${builtins.toString (x + 1)}") 8;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = myMonitor;

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hyprland.org/Configuring/Environment-variables/

      env = [
        "XCURSOR_SIZE,24"
        # Hyprcursor with Rosé Pine Theme
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,24"
      ];

      #################
      ### AUTOSTART ###
      #################
      exec-once = [
        "${pypr} --debug /tmp/pypr.log &"
        "swaync &"
      ];

      #####################
      ### LOOK AND FEEL ###
      #####################

      general = {
        # Gaps
        gaps_in = 2;
        gaps_out = 2;

        # Window Borders
        border_size = 2;
        "col.active_border" = iris;
        "col.inactive_border" = muted;

        resize_on_border = true;

        allow_tearing = false;

        layout = "dwindle";
      };
      decoration = {
        rounding = 8;
        active_opacity = "1.0";
        inactive_opacity = "1.0";
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = "0.1696";
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 1;
        disable_hyprland_logo = true;
      };

      #############
      ### INPUT ###
      #############

      input = {
        kb_layout = "us, de";
        kb_options = "caps:swapescape, grp:alt_shift_toggle";

        follow_mouse = 1;

        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };

      gestures = {
        workspace_swipe = false;
      };

      ###################
      ### KEYBINDINGS ###
      ###################

      "$mainMod" = "SUPER";

      bind =
        [
          "$mainMod, M, exit"
          "$mainMod, C, killactive"
          "$mainMod, Q, exec, ${terminal}"
          "$mainMod, V, togglefloating"
          "$mainMod, R, exec, ${menu}"

          # Move focus with mainMod + hjkl
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"
        ]
        # Switch to specified workspace
        ++ switchworkspace
        # Move active window to specified workspace
        ++ movetoworkspace
        ++ [
          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ]
        # Hyprshot Keybinds
        ++ [
          # Region (only clipboard)
          "$mainMod, Print, exec, ${hyprshot} -m region --clipboard-only"
          # Region (saved to disk)
          "$mainMod SHIFT, Print, exec, ${hyprshot} -m region"
          # Active window (saved to disk)
          "$mainMod ALT, Print, exec, ${hyprshot} -m window -m active"
        ]
        # Pyprland Keybinds
        ++ [
          "$mainMod, A, exec, pypr toggle term"
        ];
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindl = [
        # Requires playerctl
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindel = [
        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      windowrulev2 = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"
        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        # Kitty:
        "opacity 0.8 0.8, class:^(kitty)$"
        # 1Password
        "float, class:^(1Password)"
      ];
    };
  };
}
