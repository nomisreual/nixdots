{pkgs, ...}: {
  gtk = {
    enable = true;
    theme.name = "rose-pine-moon";
    theme.package = pkgs.rose-pine-gtk-theme;
  };
}
