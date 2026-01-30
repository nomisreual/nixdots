{
  pkgs,
  config,
  lib,
  ...
}: {
  options.nomisos.hyprpaper = {
    enable = lib.mkEnableOption "Enable Hyprpaper";

    settings = lib.mkOption {
      type = lib.types.submodule {
        options = {
          wallpaper = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
          display = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
          fit_mode = lib.mkOption {
            type = lib.types.str;
            default = "cover";
          };
          splash = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
        };
      };
      default = {};
    };
  };

  config = lib.mkIf config.nomisos.hyprpaper.enable {
    services.hyprpaper = let
      settings = config.nomisos.hyprpaper.settings;
    in {
      enable = true;
      settings = {
        splash = settings.splash;
        wallpaper = [
          {
            monitor = "${settings.display}";
            path = "${settings.wallpaper}";
            fit_mode = "${settings.fit_mode}";
          }
        ];
      };
    };
  };
}
