{
  pkgs,
  inputs,
  lib,
  ...
}: let
  libbluray = pkgs.libbluray.override {
    withAACS = true;
    withBDplus = true;
  };
  vlc = pkgs.vlc.override {inherit libbluray;};
in {
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
        "DP-2, /home/simon/Pictures/Wallpapers/ruffy.jpg"
      ];
    };
  };

  # Game launcher
  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [
      gamescope
      gamemode
      mangohud
    ];
    winePackages = with pkgs; [
      wineWow64Packages.full
    ];
    protonPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # Packages
  home.packages = with pkgs; [
    # App launcher
    fuzzel

    # File Manager
    yazi

    # Card reader
    ausweisapp
    pcsc-cyberjack # user space driver for Reiner SCT chipcard reader

    # Direnv
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
    makemkv # dvd/ bd ripper
    asunder # ripper
    lollypop # music library management
    easytag # manage metadata of music files
    mpv # media player

    # Password Manager
    _1password-gui

    # Web Browsers
    firefox
    brave

    # Mail
    thunderbird

    # Messanger
    signal-desktop

    # Chat
    discord

    # Office
    libreoffice-fresh
    simple-scan

    #
    banana-cursor

    # Neovim
    inputs.nixvim.packages.${system}.default

    # Git Alert
    inputs.git_alert.packages."x86_64-linux".default

    # Tmux sessionizer
    inputs.sessionizer.packages."x86_64-linux".default
  ];

  home.file = {
    "config.kdl" = {
      source = ../homeModules/niri/config.kdl;
      target = "/.config/niri/config.kdl";
    };
  };

  # Environmental Variables

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
