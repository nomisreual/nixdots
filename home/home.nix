{pkgs, ...}: {
  # User information
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "24.11";

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  imports = [
    ./homeModules/theme.nix
    ./homeModules/tmux
  ];

  # Packages
  home.packages = with pkgs; [
    _1password-gui
    yazi
    obsidian
  ];

  home.file = {
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      fzf # fuzzy finder
      wl-clipboard # clipboard provider
      ripgrep # grep on steroids
      fd # goated find

      # LSPs and formatters:

      stylua # lua formatter
      luajitPackages.lua-lsp # lua lsp

      nixd # nix lsp
      alejandra # nix formatter

      ruff # linter and formatter
      pyright # python lsp
    ];
  };

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.git = {
    enable = true;
    userName = "Simon Antonius Lauer";
    userEmail = "simon.lauer@posteo.de";
    extraConfig = {
      init = {
        defaultbranch = "main";
      };
      core = {
        editor = "nvim";
      };
    };
  };

  # Environmental Variables

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
