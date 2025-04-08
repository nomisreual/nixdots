{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "1";
        spacing = "4";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "custom/media"
        ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "hyprland/language"
          "clock"
          "tray"
          "custom/power"
        ];
        idle_inhibitor = {
          format = "{icon}";
          "format-icons" = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          timezone = "Europe/Berlin";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          "critical-threshold" = 80;
          format = "{temperatureC}°C {icon}";
          "format-icons" = ["" "" ""];
        };
        network = {
          "format-wifi" = "{signalStrength}%  ";
          "format-ethernet" = "{ipaddr}/{cidr}";
          "tooltip-format" = "{ifname} via {gwaddr}";
          "format-linked" = "{ifname} (No IP)";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{volume}% {icon} {format_source}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = "󰝟 {icon} {format_source}";
          "format-muted" = "󰝟 {format_source}";
          "format-source" = " {volume}% ";
          "format-source-muted" = " ";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "󰋎";
            "headset" = "󰋎";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
          };
          "on-click" = "pavucontrol";
        };
        "custom/media" = {
          format = "{icon} {}";
          escape = true;
          "return-type" = "json";
          "max-length" = 40;
          "on-click" = "playerctl play-pause";
          "on-click-right" = "playerctl stop";
          "smooth-scrolling-threshold" = 10;
          "on-scroll-up" = "playerctl next";
          "on-scroll-down" = "playerctl previous";
          exec = "mediaplayer 2> /dev/null";
        };
        "hyprland-language" = {
          "format" = "{}";
          "format-en" = "en";
          "format-de" = "de";
        };
        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          menu = "on-click";
          "menu-file" = ./power_menu.xml;
          "menu-actions" = {
            shutdown = "shutdown 'now'";
            reboot = "reboot";
            suspend = "systemctl suspend";
          };
        };
      };
    };
  };
}
