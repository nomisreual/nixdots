{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    plasma.enable = lib.mkEnableOption "Enable Plasma Desktop";
  };
  config = lib.mkIf config.plasma.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
