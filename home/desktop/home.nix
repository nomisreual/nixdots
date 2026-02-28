{
  pkgs,
  inputs,
  lib,
  nomispkgs,
  ...
}: let
  # libbluray = pkgs.libbluray.override {
  #   withAACS = true;
  #   withBDplus = true;
  # };
  # vlc-custom = pkgs.vlc.override {inherit libbluray;};
in {
  # User information
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  imports = [
  ];

  nomisos = {
    waybar.enable = true;
    kitty = {
      enable = true;
      settings.font.size = 18;
    };
    tmux.enable = true;
    hyprland = {
      enable = true;
      settings.screen = "DP-2, 1920x1080@165, 0x0, 1";
    };
    hypridle.enable = true;
    hyprlock.enable = true;
    hyprpaper = {
      enable = true;
      settings = {
        wallpaper = "/home/simon/Pictures/Wallpapers/nix-wallpaper-binary-black.png";
        display = "DP-2";
      };
    };
    swaynotificationcenter.enable = true;
    gtk.enable = true;
  };

  # gammastep
  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
  };

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
  home.packages = with pkgs;
    [
      # App launcher
      (
        inputs.wrappers.wrapperModules.fuzzel.apply
        {
          inherit pkgs;
          settings = {
            border.radius = 6;
            colors = {
              background = "1e1e2edd";
              text = "cdd6f4ff";
              prompt = "bac2deff";
              placeholder = "7f849cff";
              input = "cdd6f4ff";
              match = "b4befeff";
              selection = "585b70ff";
              selection-text = "cdd6f4ff";
              selection-match = "b4befeff";
              counter = "7f849cff";
              border = "b4befeff";
            };
          };
        }
      ).wrapper

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
      ghostty

      # Media
      # vlc-custom # media player
      # makemkv # dvd/ bd ripper
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
      protonmail-bridge-gui

      # Messanger
      signal-desktop

      # Chat
      discord

      # Office
      libreoffice-fresh
      simple-scan
      evince

      # Neovim
      inputs.nomisvim.packages.${stdenv.hostPlatform.system}.default
    ]
    ++ [
      nomispkgs.git_alert

      # Tmux sessionizer
      (
        pkgs.symlinkJoin
        {
          name = "sessionizer";
          buildInputs = [pkgs.makeWrapper];
          paths = [nomispkgs.sessionizer];
          postBuild = ''
            wrapProgram $out/bin/sessionizer \
            --set PROJECT_ROOT "/home/simon/Projects"
          '';
        }
      )
    ];

  # Environmental Variables

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
