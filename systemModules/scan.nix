{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    scan.enable = lib.mkEnableOption "Enable Scanning";
  };

  config = lib.mkIf config.scan.enable {
    hardware.sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
    };
    services.udev.packages = [pkgs.sane-airscan];
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
  };
}
