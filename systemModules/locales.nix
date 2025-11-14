{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    locales.enable = lib.mkEnableOption "Locales";
    locales.settings = lib.mkOption {
      type = lib.types.submodule {
        options = {
          locale = lib.mkOption {
            type = lib.types.str;
            default = "en_US.UTF-8";
          };

          extraLocale = lib.mkOption {
            type = lib.types.str;
            default = "de_DE.UTF-8";
          };

          timeZone = lib.mkOption {
            type = lib.types.str;
            default = "Europe/Berlin";
          };
        };
      };
    };
  };
  config = lib.mkIf config.locales.enable {
    # Time zone
    time.timeZone = config.locales.settings.timeZone;

    # Internationalisation
    i18n.defaultLocale = config.locales.settings.locale;

    i18n.extraLocaleSettings = let
      locale = config.locales.settings.extraLocale;
    in {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
    };
  };
}
