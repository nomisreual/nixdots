{pkgs, ...}: {
  gtk = {
    enable = true;
    theme.name = "rose-pine-moon";
    theme.package = pkgs.rose-pine-gtk-theme;
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine-moon";
    };
  };
}
