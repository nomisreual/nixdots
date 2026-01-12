{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    greetd.enable = lib.mkEnableOption "Enable greetd";
  };
  config = lib.mkIf config.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session.command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time \
            --asterisks \
            --user-menu \
            --cmd start-hyprland
        '';
      };
    };
    #
    # environment.etc."greetd/environments".text = ''
    #   Hyprland
    #   fish
    #   bash
    # '';
  };
}
