{
  config,
  pkgs,
  ...
}: {
  # Hyprland Window Manager
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprsunset # night light
    waybar # panel
    wofi # app launcher
    hyprpaper # wallpaper daemon
    hypridle # idle daemon
    hyprlock # lock screen
    swaynotificationcenter # notifications
    pyprland # plugins (scratchpads)
    rose-pine-hyprcursor # cursor theme
    pavucontrol # gui for audio devices
    kitty # terminal
  ];
}
