{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  options = {
    nomisos.wayle = {
      enable = lib.mkEnableOption "Enable Wayle";
    };
  };
  config = lib.mkIf config.nomisos.wayle.enable {
    services.wayle = {
      enable = true;
      settings = {
        styling = {
          theme-provider = "wallust";
          theming-monitor = "HDMI-A-1";
        };
        bar = {
          background-opacity = 60;
          inset-edge = 0.5;
          inset-ends = 0.5;
          layout = [
            {
              monitor = "HDMI-A-1";
              left = ["hyprland-workspaces"];
              center = ["clock"];
              right = ["keyboard-input" "hyprsunset" "notifications" "systray" "dashboard"];
              show = true;
            }
            {
              monitor = "HDMI-A-2";
              left = ["hyprland-workspaces"];
              center = ["clock"];
              right = ["dashboard"];
              show = true;
            }
          ];
          rounding = "sm";
        };
        general = {
          font-mono = "FantasqueSansM Nerd Font Mono";
          font-sans = "FantasqueSansM Nerd Font Mono";
        };
        modules = {
          notifications = {
            label-show = false;
          };
          clock = {
            icon-show = false;
            format = "%d.%m.%y %H:%M";
          };
          hyprsunset = {
            border-color = "yellow";
            border-show = false;
            button-bg-color = "bg-surface-elevated";
            format = "{{ status }}";
            gamma = 100;
            icon-bg-color = "yellow";
            icon-color = "auto";
            icon-off = "ld-sun-symbolic";
            icon-on = "ld-moon-symbolic";
            icon-show = true;
            label-color = "yellow";
            label-max-length = 0;
            label-show = false;
            left-click = ":toggle";
            middle-click = "";
            right-click = "";
            scroll-down = "";
            scroll-up = "";
            temperature = 4000;
          };
          keyboard-input = {
            format = "{{ alias }}";
            icon-show = false;
            layout-alias-map = {
              "English (US)" = "en";
              German = "de";
            };
            left-click = "hyprctl switchxkblayout all next";
            right-click = "hyprctl switchxkblayout all prev";
            scroll-down = "hyprctl switchxkblayout all next";
            scroll-up = "hyprctl switchxkblayout all prev";
          };
        };
        styling = {
          palette = {
            bg = "#16161e";
            blue = "#7dcfff";
            elevated = "#202230";
            fg = "#c0caf5";
            fg-muted = "#a9b1d6";
            green = "#9ece6a";
            primary = "#7aa2f7";
            red = "#f7768e";
            surface = "#1a1b26";
            yellow = "#e0af68";
          };
        };
        wallpaper = {
          cycling-directory = "/home/simon/Pictures/Wallpapers";
          cycling-enabled = true;
          cycling-interval-mins = 10;
          transition-duration = 0.2;
          transition-fps = 59;
          transition-type = "fade";
        };
      };
    };
    # used by wayle as wallpaper engine
    services.awww.enable = true;
  };
}
