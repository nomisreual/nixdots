{
  pkgs,
  config,
  lib,
  ...
}: {
  options.nomisos.gtk = {
    enable = lib.mkEnableOption "Enable GTK Styling";
  };

  config = lib.mkIf config.nomisos.gtk.enable {
    gtk = {
      enable = true;
      theme.package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
      };
      theme.name = "catppuccin-mocha-blue-standard";
      iconTheme = {
        package = pkgs.rose-pine-icon-theme;
        name = "rose-pine-moon";
      };
    };
  };
}
