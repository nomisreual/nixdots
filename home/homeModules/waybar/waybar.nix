{
  pkgs,
  inputs,
  ...
}: let
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  mediaplayer = inputs.mediaplayer.packages.${pkgs.system}.default;
in {
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    style = builtins.readFile ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-left = 8;
        margin-right = 8;
        margin-top = 8;
        spacing = "4";
        modules-left = [
          "custom/start"
          "hyprland/workspaces"
          # "custom/media"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "hyprland/language"
          "tray"
          "custom/notification"
          "custom/power"
        ];
        "custom/start" = {
          on-click = "fuzzel";
          tooltip = false;
          format = "{icon}";
          format-icons = {
            default = "󱄅 ";
          };
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span> ";
            none = " ";
            dnd-notification = "<span foreground='red'><sup></sup></span> ";
            dnd-none = " ";
            inhibited-notification = "<span foreground='red'><sup></sup></span> ";
            inhibited-none = " ";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span> ";
            dnd-inhibited-none = " ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          format = "{:%b. %d - %H:%M}";
          timezone = "Europe/Berlin";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };
        network = {
          format-wifi = "{signalStrength}%  ";
          format-ethernet = "{ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          scroll-step = 1;
          # format = "{volume}% {icon} {format_source}";
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = " {volume}% ";
          format-source-muted = " ";
          format-icons = {
            headphone = "";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        "custom/media" = {
          format = "{text}";
          escape = true;
          return-type = "json";
          max-length = 40;
          on-click = "${playerctl} play-pause";
          on-click-right = "${playerctl} stop";
          smooth-scrolling-threshold = 10;
          on-scroll-up = "${playerctl} next";
          on-scroll-down = "${playerctl} previous";
          exec = "${mediaplayer}/bin/mediaplayer 2> /dev/null";
        };
        hyprland-language = {
          format = "{}";
          format-en = "en";
          format-de = "de";
        };
        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          menu = "on-click";
          menu-file = ./power_menu.xml;
          menu-actions = {
            shutdown = "shutdown 'now'";
            reboot = "reboot";
            suspend = "systemctl suspend";
          };
        };
        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
          max-length = 25;
        };
      };
    };
  };
}
