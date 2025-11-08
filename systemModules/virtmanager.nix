{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    virtmanager.enable = lib.mkEnableOption "Enable Virtmanager";
  };

  config = lib.mkIf config.virtmanager.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    # TODO: get hardcoded user out
    users.users."simon".extraGroups = ["libvirtd"];

    # enable USB redirection
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
