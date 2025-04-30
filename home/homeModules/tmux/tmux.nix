{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    escapeTime = 0;
    mouse = true;
    prefix = "C-s";
    terminal = "screen-256color";
    baseIndex = 1;
    focusEvents = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'moon'
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          # Customize resurrect:
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-save k
          set -g @resurrect-restore r
        '';
      }
    ];
    extraConfig = ''
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Status Bar on top
      set-option -g status-position top

      # Resize panes
      bind j resize-pane -D 5
      bind k resize-pane -U 5
    '';
  };
}
