{pkgs, ...}: {
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
}
# some other themes:
# theme.name = "rose-pine-moon";
# theme.package = pkgs.rose-pine-gtk-theme;
# theme.name = "Nordic";
# theme.package = pkgs.nordic;

