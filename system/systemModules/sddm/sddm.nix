{
  pkgs,
  config,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    # theme = "${pkgs.sddm-chili-theme}";
  };
}
