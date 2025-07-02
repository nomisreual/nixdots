{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # User information
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

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
  programs.kitty.font.size = 18;

  xdg.desktopEntries = {
    "fish" = {
      name = "fish";
      noDisplay = true;
    };
  };

  programs.fish = {
    functions = {
      fish_greeting =
        /*
        fish
        */
        ''
          if set -q TMUX;
            echo ""
          else
            ${lib.getExe pkgs.microfetch}
          end
        '';
    };
  };

  # Declare here, so hyprland.nix is more easy to share
  wayland.windowManager.hyprland = {
    settings = {
      monitor = "DP-2, 1920x1080@165, 0x0, 1";
    };
  };

  # same for hyprpaper
  services.hyprpaper = {
    settings = {
      wallpaper = [
        "DP-2, /home/simon/Pictures/Wallpapers/penguin.jpg"
      ];
    };
  };

  # Game launcher
  programs.lutris = {
    enable = true;
  };

  # Packages
  home.packages = with pkgs; [
    # File Manager
    yazi

    ausweisapp
    pcsc-cyberjack

    # Devenv
    direnv
    nix-direnv

    # Notes
    obsidian

    # API
    postman

    # Utilities
    quickemu # easy VMs
    htop
    btop

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
    inputs.zen-browser.packages."${system}".default

    # Mail
    thunderbird

    # Chat
    discord

    # Office
    libreoffice-fresh
    simple-scan

    # Neovim
    inputs.nixvim.packages.${system}.default

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
