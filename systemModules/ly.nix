{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    nomisos.ly.enable = lib.mkEnableOption "Enable ly";
  };
  config = lib.mkIf config.nomisos.ly.enable {
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        vi_mode = true;
        animation = "matrix";
        bigclock = true;
      };
    };
  };
}
