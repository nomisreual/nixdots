{
  pkgs,
  inputs,
  ...
}: {
  # User information
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "24.11";

  imports = [
  ];

  # Packages
  home.packages = [
  ];

  home.file = {
  };

  # Environmental Variables

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
