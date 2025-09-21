{pkgs, ...}: {
  services.xserver.windowManager.qtile = {
    enable = false;
  };
  environment.systemPackages = with pkgs; [
    # wlr-randr # xrandr for wayland
    # rofi # app launcher X11
  ];
  services.xserver = {
    enable = false;
    xkb = {
      options = "caps:swapescape,grp:alt_shift_toggle";
    };
  };
}
