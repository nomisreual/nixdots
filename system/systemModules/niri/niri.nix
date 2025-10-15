{
  config,
  pkgs,
  ...
}: {
  # Niri
  programs.niri = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    niriswitcher
  ];
}
