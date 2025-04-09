{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.gutenprint];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
