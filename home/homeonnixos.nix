{
  pkgs,
  inputs,
  ...
}: {
  # User information
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "24.11";

  imports = [
    ./homeModules/theme.nix
    ./homeModules/tmux
    ./homeModules/kitty
    ./homeModules/waybar
    ./homeModules/hyprland
    ./homeModules/wofi
    ./homeModules/common
    # ./homeModules/nvim
  ];

  # Kitty on
  programs.kitty.font.size = 18;

  # Packages
  home.packages = with pkgs; [
    # Here for now:
    wl-clipboard

    # File Manager
    yazi

    # Notes
    obsidian

    # Media
    vlc # media player
    asunder # ripper
    lollypop # music library management
    easytag # manage metadata of music files

    hyprshot

    # Password Manager
    _1password-gui

    # Web Browsers
    firefox
    brave

    # Mail
    thunderbird

    # Neovim
    inputs.nixvim.packages.${system}.default

    # Git Alert
    inputs.git_alert.packages."x86_64-linux".default
  ];

  home.file = {
  };

  # Environmental Variables

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
