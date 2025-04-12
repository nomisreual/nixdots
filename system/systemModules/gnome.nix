{
  pkgs,
  config,
  ...
}: {
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  # no apps
  services.gnome.core-utilities.enable = true;
}
