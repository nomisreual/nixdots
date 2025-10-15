{pkgs, ...}: {
  gtk = {
    enable = false;
    theme.package = pkgs.catppuccin-gtk.override {
      variant = "mocha";
    };
    theme.name = "catppuccin-mocha-blue-standard";
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine-moon";
    };
  };
}
