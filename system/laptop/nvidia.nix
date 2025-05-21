{config, ...}: {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.nvidia = {
    # Use legacy driver 470 and no open source kernel module as it is not supported
    # running that driver version.
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

    # Run on integrated GPU and offload to Nvidia card.
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
}
