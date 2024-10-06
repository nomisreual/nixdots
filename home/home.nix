{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.username = "simon";
  home.homeDirectory = "/home/simon";

  imports = [
    ./nvim/nvim.nix
  ];


  home.packages = with pkgs; [
    discord
    brave
    thunderbird
    slack
    _1password-gui
    pika-backup
    spotify
    obsidian
    teams-for-linux
    libreoffice
    naps2

    gotop
    yazi
    fzf
    fd

    (import ./scripts/tmux_select_directory.nix { inherit pkgs; })
  ];


  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };

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
    defaultKeymap = "viins";
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

      # Switch tmux sessions
      fp = "tmux_select_directory";

      # Neovim
      n = "nvim";

    };
    initExtra = ''
      if [[ -z $TMUX ]]; then
        fastfetch
      fi
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "simon.lauer@posteo.de";
    userName = "Simon Antonius Lauer";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
      };
    };
  };

  programs.poetry = {
    enable = true;
    settings = {
      virtualenvs.create = false;
    };
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
    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        # "display"
        "de"
        "wm"
        "wmtheme"
        # "theme"
        # "icons"
        # "font"
        # "cursor"
        "terminal"
        # "terminalfont"
        "cpu"
        "gpu"
        "memory"
        # "swap"
        # "disk"
        # "localip"
        # "battery"
        # "poweradapter"
        # "locale"
        "break"
        "colors"
      ];
    };
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



  home.file = {
    "mako" = {
      source = ./dotfiles/mako;
      target = ".config/mako";
      recursive = true;
    };
    "hypr" = {
      source = ./dotfiles/hypr;
      target = ".config/hypr";
      recursive = true;
    };
    "waybar" = {
      source = ./dotfiles/waybar;
      target = ".config/waybar";
      recursive = true;
    };
    # "nvim" = {
    #   source = ./dotfiles/nvim;
    #   target = ".config/nvim";
    #   recursive = true;
    # };
    "kitty" = {
      source = ./dotfiles/kitty;
      target = ".config/kitty";
      recursive = true;
    };
    "gammastep" = {
      source = ./dotfiles/gammastep;
      target = ".config/gammastep";
      recursive = true;
    };
    "wofi" = {
      source = ./dotfiles/wofi;
      target = ".config/wofi";
      recursive = true;
    };
    "rofi" = {
      source = ./dotfiles/rofi;
      target = ".config/rofi";
      recursive = true;
    };
  };

  home.sessionVariables = { };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
