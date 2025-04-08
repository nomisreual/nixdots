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
    ./homeModules/kitty
    ./homeModules/ghostty
    ./homeModules/waybar
    ./homeModules/hyprland
    ./homeModules/wofi
    ./homeModules/common
  ];

  # Packages
  home.packages = with pkgs; [
    _1password-gui
    yazi
    obsidian
    vlc
    asunder
    lollypop
    easytag
    hyprshot
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

  # Environmental Variables

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
