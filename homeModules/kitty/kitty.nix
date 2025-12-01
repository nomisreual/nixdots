{
  pkgs,
  config,
  lib,
  ...
}: {
  options.nomisos.kitty = {
    enable = lib.mkEnableOption "Enable Kitty";
    settings = lib.mkOption {
      type = lib.types.submodule {
        options = {
          font = lib.mkOption {
            type =
              lib.types.submodule
              {
                options = {
                  name = lib.mkOption {
                    type = lib.types.str;
                    default = "FantasqueSansM Nerd Font Mono";
                  };
                  package = lib.mkOption {
                    type = lib.types.package;
                    default = pkgs.nerd-fonts.fantasque-sans-mono;
                  };
                  size = lib.mkOption {
                    type = lib.types.int;
                    default = 18;
                  };
                };
              };
            default = {};
          };
          themeFile = lib.mkOption {
            type = lib.types.str;
            default = "Catppuccin-Mocha";
          };
        };
      };
      default = {};
    };
  };
  config = lib.mkIf config.nomisos.kitty.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = config.nomisos.kitty.settings.font.name;
        package = config.nomisos.kitty.settings.font.package;
        size = config.nomisos.kitty.settings.font.size;
      };
      themeFile = config.nomisos.kitty.settings.themeFile;
    };
  };
}
