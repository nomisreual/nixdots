{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };
  config = lib.mkIf config.hyprland.enable {
    # Hyprland Window Manager
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      hyprsunset # night light
      wofi # app launcher
      rose-pine-hyprcursor # cursor theme
      pavucontrol # gui for audio devices
      kitty # terminal
    ];
  };
}
