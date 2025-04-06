{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
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
      # Make neovim happy:
      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-features ",xterm-kitty:RGB"
      # Allow passthrough:
      # set-option -g allow-passthrough on

      # Rebind prefix:
      unbind C-b
      set-option -g prefix C-s
      bind-key C-s send-prefix

      # ESC time-out
      set -s escape-time 0

      # Enable mouse control (clickable windows, panes, resizable panes)
      set -g mouse on

      # don't rename windows automatically
      # set-option -g allow-rename off

      # split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # status bar top
      set-option -g status-position top
    '';
  };
}
