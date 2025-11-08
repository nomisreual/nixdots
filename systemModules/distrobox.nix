{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    distrobox.enable = lib.mkEnableOption "Enable Distrobox";
  };
  config = lib.mkIf config.distrobox.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    environment.systemPackages = [pkgs.distrobox];
  };
}
