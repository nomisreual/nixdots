{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    printing.enable = lib.mkEnableOption "Enable Printing";
  };

  config = lib.mkIf config.printing.enable {
    services.printing = {
      enable = true;
      drivers = [pkgs.gutenprint];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    hardware.printers = {
      ensurePrinters = [
        {
          name = "SamsungPrinter";
          location = "Home";
          deviceUri = "dnssd://Samsung%20M267x%20287x%20Series%20(SEC30CDA716A59A)._printer._tcp.local";
          model = "gutenprint.5.3://pcl-g_6/expert";
          ppdOptions = {
            PageSize = "A4";
            Duplex = "DuplexNoTumble";
            Resolution = "600dpi";
            ColorModel = "Gray";
          };
        }
      ];
      ensureDefaultPrinter = "SamsungPrinter";
    };
  };
}
