{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    systemdboot.enable = lib.mkEnableOption "Enable SystemD boot";
    grub = {
      enable = lib.mkEnableOption "Enable Grub";
      settings = lib.mkOption {
        type = lib.types.submodule {
          options = {
            device = lib.mkOption {
              type = lib.types.str;
              default = "";
            };
          };
        };
      };
    };
  };
  config = lib.mkMerge [
    (lib.mkIf
      config.systemdboot.enable
      {
        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      })
    (
      lib.mkIf
      config.grub.enable {
        boot.loader.grub.enable = true;
        boot.loader.grub.device = config.grub.settings.device;
        boot.loader.grub.useOSProber = true;
      }
    )
  ];
}
