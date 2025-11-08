{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    niri.enable = lib.mkEnableOption "Enable niri window manager";
  };
  config = lib.mkIf config.niri.enable {
    # Niri
    programs.niri = {
      enable = true;
    };
    environment.systemPackages = with pkgs; [
      niriswitcher
      xwayland-satellite
    ];
  };
}
