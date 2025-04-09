{pkgs, ...}: {
  # User information
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "24.11";

  imports = [
    ./homeModules/theme.nix
    ./homeModules/tmux
    ./homeModules/kitty
    # ./homeModules/ghostty
    ./homeModules/waybar
    ./homeModules/hyprland
    ./homeModules/wofi
    ./homeModules/common
    ./homeModules/nvim
  ];

  # Kitty on
  programs.kitty.font.size = 18;

  # Packages
  home.packages = with pkgs; [
    wl-clipboard
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

  # Environmental Variables

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
