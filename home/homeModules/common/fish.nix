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
    functions = {
      fish_greeting = ''
        if set -q TMUX;
          echo ""
        else
          ${lib.getExe pkgs.microfetch}
        end
      '';
    };
  };
}
