{pkgs, ...}: {
  home.packages = with pkgs; [
    pyprland
  ];

  home.file = {
    "pyprland.toml" = {
      source = ./pyprland.toml;
      target = ".config/hypr/pyprland.toml";
    };
  };
}
