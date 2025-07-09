{
  config,
  pkgs,
  ...
}: {
  # Hyprland Window Manager
  programs.sway.enable = true;

  environment.systemPackages = with pkgs; [
  ];
}
