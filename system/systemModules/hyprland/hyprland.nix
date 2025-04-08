{
  config,
  pkgs,
  ...
}: {
  # Hyprland Window Manager
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprsunset # night light
    wofi # app launcher
    hypridle # idle daemon
    hyprlock # lock screen
    swaynotificationcenter # notifications
    pyprland # plugins (scratchpads)
    rose-pine-hyprcursor # cursor theme
    pavucontrol # gui for audio devices
    kitty # terminal
  ];
}
