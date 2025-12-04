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
        preload = [
          "${settings.wallpaper}"
        ];
        wallpaper = [
          "${settings.display}, ${settings.wallpaper}"
        ];
      };
    };
  };
}
