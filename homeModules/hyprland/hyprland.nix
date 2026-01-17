{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  options.nomisos.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland";

    settings = lib.mkOption {
      type = lib.types.submodule {
        options = {
          screen = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
        };
      };
      default = {};
    };
  };

  config = lib.mkIf config.nomisos.hyprland.enable {
    wayland.windowManager.hyprland = let
      # Import colors
      colors = import ./colors.nix;

      # My programs
      terminal = lib.getExe pkgs.kitty;
      menu =
        lib.getExe
        (
          inputs.wrappers.wrapperModules.fuzzel.apply
          {
            inherit pkgs;
            settings = {
              border.radius = 6;
              colors = {
                background = "1e1e2edd";
                text = "cdd6f4ff";
                prompt = "bac2deff";
                placeholder = "7f849cff";
                input = "cdd6f4ff";
                match = "b4befeff";
                selection = "585b70ff";
                selection-text = "cdd6f4ff";
                selection-match = "b4befeff";
                counter = "7f849cff";
                border = "b4befeff";
              };
            };
          }
        ).wrapper;

      pypr = lib.getExe pkgs.pyprland;

      switchworkspace = builtins.genList (x: "$mainMod, ${builtins.toString (x + 1)}, workspace, ${builtins.toString (x + 1)}") 8;

      movetoworkspace = builtins.genList (x: "$mainMod SHIFT, ${builtins.toString (x + 1)}, movetoworkspace, ${builtins.toString (x + 1)}") 8;
    in {
      enable = true;

      settings = {
        ### Display ###
        monitor = config.nomisos.hyprland.settings.screen;

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
          "${lib.getExe pkgs.waybar} &"

          "[workspace 1 silent] ${lib.getExe pkgs.kitty}"
          "[workspace 2 silent] ${lib.getExe pkgs.brave}"
          "[workspace 3 silent] ${lib.getExe pkgs.thunderbird}"
        ];

        #####################
        ### LOOK AND FEEL ###
        #####################

        general = {
          # Gaps
          gaps_in = 2;
          gaps_out = 8;

          # Window Borders
          border_size = 2;

          "col.active_border" = colors.catppuccin.mocha.lavender;
          "col.inactive_border" = colors.catppuccin.mocha.base;

          resize_on_border = true;

          allow_tearing = false;

          layout = "dwindle";
        };
        decoration = {
          rounding = 8;
          active_opacity = "1.0";
          inactive_opacity = "1.0";
          shadow = {
            enabled = false;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = false;
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
            # "workspacesIn, 1, 1.21, almostLinear, fade"
            # "workspacesOut, 1, 1.94, almostLinear, fade"
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

        ###################
        ### KEYBINDINGS ###
        ###################

        "$mainMod" = "SUPER";

        bind = let
          region_cb_only = pkgs.writeShellApplication {
            name = "region_cb_only";
            runtimeInputs = [
              pkgs.hyprshot
            ];
            text = ''
              hyprshot -m region --clipboard-only
            '';
          };
          region = pkgs.writeShellApplication {
            name = "region";
            runtimeInputs = [
              pkgs.hyprshot
            ];
            text = ''
              hyprshot -m region
            '';
          };
          active_window = pkgs.writeShellApplication {
            name = "active_window";
            runtimeInputs = [
              pkgs.hyprshot
            ];
            text = ''
              hyprshot -m window -m active
            '';
          };
        in
          [
            "$mainMod, M, exit"
            "$mainMod, Q, killactive"
            "$mainMod, RETURN, exec, ${terminal}"
            "$mainMod, V, togglefloating"
            "$mainMod, F, fullscreen"
            "$mainMod, R, exec, ${menu}"

            # Move focus with mainMod + hjkl
            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"

            # swap windows
            "$mainMod SHIFT, H, swapwindow, l"
            "$mainMod SHIFT, L, swapwindow, r"
            "$mainMod SHIFT, K, swapwindow, u"
            "$mainMod SHIFT, J, swapwindow, d"

            # swaynotificationcenter
            "$mainMod, N, exec, swaync-client --toggle-panel"
            "$mainMod SHIFT, N, exec, swaync-client --close-all"
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
            "$mainMod, Print, exec, ${lib.getExe region_cb_only}"
            # Region (saved to disk)
            "$mainMod SHIFT, Print, exec,${lib.getExe region}"
            # Active window (saved to disk)
            "$mainMod ALT, Print, exec, ${lib.getExe active_window}"
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
  };
}
