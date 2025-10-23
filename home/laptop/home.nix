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
    ../homeModules/theme.nix
    ../homeModules/tmux
    ../homeModules/kitty
    ../homeModules/waybar
    ../homeModules/hyprland
    ../homeModules/wofi
    ../homeModules/common
  ];

  # Kitty on
  programs.kitty.font.size = 20;

  nixpkgs.config.allowUnfree = true;

  xdg.desktopEntries = {
    "fish" = {
      name = "fish";
      noDisplay = true;
    };
  };

  # Declare here, so hyprland.nix is more easy to share
  wayland.windowManager.hyprland = {
    settings = {
      monitor = "eDP-1, 1920x1080@60.05, 0x0, 1";
    };
  };

  # same for hyprpaper
  services.hyprpaper = {
    settings = {
      wallpaper = [
        "eDP-1, /home/simon/Pictures/Wallpapers/ruffy.jpg"
      ];
    };
  };
  # Packages
  home.packages = with pkgs; [
    # File Manager
    yazi

    # Devenv
    direnv
    nix-direnv

    # Notes
    obsidian

    # API
    postman

    # Media
    vlc # media player
    asunder # ripper
    lollypop # music library management
    easytag # manage metadata of music files
    mpv # media player

    # Password Manager
    _1password-gui
    proton-pass

    # Web Browsers
    firefox
    brave

    # Mail
    thunderbird

    # Office
    libreoffice-fresh

    # Neovim
    inputs.nomisvim.packages.${system}.default

    # Git Alert
    inputs.git_alert.packages."x86_64-linux".default

    # Tmux sessionizer
    inputs.sessionizer.packages."x86_64-linux".default
  ];

  home.file = {
  };

  # Environmental Variables

  home.sessionVariables = {
    EDITOR = "nvim";
    NH_FLAKE = "/home/simon/nixdots";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
