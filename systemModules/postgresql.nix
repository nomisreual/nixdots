{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    postgres.enable = lib.mkEnableOption "Enable Postgres";
  };
  config = lib.mkIf config.postgres.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_17;
    };
  };
}
