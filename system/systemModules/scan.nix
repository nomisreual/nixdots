{pkgs, ...}: {
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.sane-airscan];
  };
  services.udev.packages = [pkgs.sane-airscan];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
}
