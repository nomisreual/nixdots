{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.username = "simon";
  home.homeDirectory = "/home/simon";


  home.packages = with pkgs; [
    discord
    brave
    thunderbird
    slack
    _1password-gui
    pika-backup
    spotify
    obsidian

    gotop
    stow
    # fastfetch
    yazi

    neovim
    ripgrep
    fd
    fzf
    wl-clipboard
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    prefix = "C-s";
    escapeTime = 10;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-save 'k'
          set -g @resurrect-restore 'b'
          set -g @resurrect-dir '/home/simon/.local/state/tmux'
        '';
      }
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'moon'
        '';
      }
    ];

    extraConfig = ''
      set-option -sa terminal-features ',xterm-kitty:RGB'

      # don't rename windows automatically
      set-option -g allow-rename off

      # open new window
      bind c new-window -c "#{pane_current_path}"

      # split panes using | and -
      unbind '"'
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # resize pane size:
      bind , resize-pane -L 5
      bind . resize-pane -R 5
      bind u resize-pane -U 5
      bind o resize-pane -D 5

      # status bar top
      set-option -g status-position top
    '';
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    syntaxHighlighting = {
      enable = true;
    };
    history = {
      size = 1000;
      save = 1000;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    shellAliases = {
      # Yazi
      y = "yazi";
      # Servers
      box = "ssh boxuser@134.122.93.78";
      boxsftp = "sftp boxuser@134.122.93.78";
      # Fuzzy find files in current directory
      ff = "fd --type f --strip-cwd-prefix | fzf --height 40%  --layout reverse --border --bind 'enter:become(nvim {})' --preview 'bat --color=always {}'";
    };
    initExtra = ''
      if [[ -z $TMUX ]]; then
        fastfetch
      fi
    '';
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fastfetch = {
    enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine-moon";
    };
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine-moon";
    };
  };



  home.file = { };

  home.sessionVariables = { };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
