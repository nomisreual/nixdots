{ config, pkgs, ... }:
{
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
        # if [[ -z $TMUX ]]; then
        #   fastfetch
        # fi

      if [[ -z $TMUX && "$(uname)" != "Darwin" ]]; then
          fastfetch
      fi
      if [[ "$(uname)" == "Darwin" ]]; then
        export PATH=/usr/local/bin:$PATH
      fi
    '';
  };
}
