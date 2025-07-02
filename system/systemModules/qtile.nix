{pkgs, ...}: {
  services.xserver.windowManager.qtile.enable = true;
  environment.systemPackages = with pkgs; [
    wlr-randr
  ];
}
