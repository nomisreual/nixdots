{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    shellInit = ''
      bind --mode insert ctrl-y accept-autosuggestion
      set -g fish_key_bindings fish_vi_key_bindings
    '';
  };
}
