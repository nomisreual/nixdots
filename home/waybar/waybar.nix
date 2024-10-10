{ config, lib, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        spacing = 4;
        margin = "2";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
          # "custom/media"
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

        "hyprland/workspaces" = {
          persistent-workspaces = {
            DP-1 = [ 1 2 3 4 5 ];
            DP-2 = [ 6 7 8 9 10 ];
          };
        };
        # "custom/media" =
        #   let
        #     script = import ./mediaplayer.nix { inherit pkgs; };
        #   in
        #   {
        #     format = "{icon} {}";
        #     escape = true;
        #     return-type = "json";
        #     max-length = 40;
        #     on-click = "playerctl play-pause";
        #     on-click-right = "playerctl stop";
        #     smooth-scrolling-threshold = 10;
        #     on-scroll-up = "playerctl next";
        #     on-scroll-down = "playerctl previous";
        #     exec = "${lib.getExe script}";
        #   };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };
        "pulseaudio" = {
          scroll-step = 1;
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        "network" = {
          format-wifi = "{signalStrength}%  ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        "cpu" = {
          format = "{usage}%  ";
          tooltip = true;
        };
        "memory" = {
          format = "{}%  ";
        };
        "temperature" = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format-critical = "{temperatureC}°C {icon}";
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" ];
        };
        "hyprland/language" = {
          format = "{}";
          format-en = "en";
          format-de = "de";
        };
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        "tray" = {
          spacing = 10;
        };
        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          menu = "on-click";
          menu-file = ./power_menu.xml;
          menu-actions = {
            shutdown = "shutdown";
            "reboot" = "reboot";
            "suspend" = "systemctl suspend";
          };
        };
      };
    };
    style = ./style.css;
  };
}	
