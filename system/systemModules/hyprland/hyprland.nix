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
    rose-pine-hyprcursor # cursor theme
    pavucontrol # gui for audio devices
    kitty # terminal
  ];
}
