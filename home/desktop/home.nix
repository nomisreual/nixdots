{
  pkgs,
  inputs,
  lib,
  nomispkgs,
  ...
}: {
  # User information
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  imports = [
  ];

  nomisos = {
    waybar.enable = false;
    kitty = {
      enable = true;
      settings.font.size = 18;
    };
    tmux.enable = true;
    hyprland = {
      enable = true;
      settings.monitors = [
        {monitor = "HDMI-A-1, 1920x1080@144, 0x0, 1";}
        {monitor = "HDMI-A-2, 1920x1080@144, 1920x0, 1";}
      ];
    };
    hypridle.enable = false;
    hyprlock.enable = true;
    hyprpaper = {
      enable = false;
      settings = {
        wallpaper = "/home/simon/Pictures/Wallpapers/nix-wallpaper-binary-black.png";
      };
    };
    swaynotificationcenter.enable = false;
    gtk.enable = true;
  };

  # gammastep
  services.gammastep = {
    enable = false;
    provider = "geoclue2";
    tray = true;
  };

  xdg.desktopEntries = {
    "fish" = {
      name = "fish";
      noDisplay = true;
    };
  };
  services.wayle = {
    enable = true;
    settings = {
      styling = {
        theme-provider = "wallust";
        theming-monitor = "HDMI-A-1";
      };
      bar = {
        background-opacity = 60;
        inset-edge = 0.5;
        inset-ends = 0.5;
        layout = [
          {
            monitor = "HDMI-A-1";
            left = ["hyprland-workspaces"];
            center = ["clock"];
            right = ["keyboard-input" "hyprsunset" "notifications" "systray" "dashboard"];
            show = true;
          }
          {
            monitor = "HDMI-A-2";
            left = ["hyprland-workspaces"];
            center = ["clock"];
            right = ["dashboard"];
            show = true;
          }
        ];
        rounding = "sm";
      };
      general = {
        font-mono = "FantasqueSansM Nerd Font Mono";
        font-sans = "FantasqueSansM Nerd Font Mono";
      };
      modules = {
        notifications = {
          label-show = false;
        };
        clock = {
          icon-show = false;
          format = "%d.%m.%y %H:%M";
        };
        hyprsunset = {
          border-color = "yellow";
          border-show = false;
          button-bg-color = "bg-surface-elevated";
          format = "{{ status }}";
          gamma = 100;
          icon-bg-color = "yellow";
          icon-color = "auto";
          icon-off = "ld-sun-symbolic";
          icon-on = "ld-moon-symbolic";
          icon-show = true;
          label-color = "yellow";
          label-max-length = 0;
          label-show = false;
          left-click = ":toggle";
          middle-click = "";
          right-click = "";
          scroll-down = "";
          scroll-up = "";
          temperature = 4000;
        };
        keyboard-input = {
          format = "{{ alias }}";
          icon-show = false;
          layout-alias-map = {
            "English (US)" = "en";
            German = "de";
          };
          left-click = "hyprctl switchxkblayout all next";
          right-click = "hyprctl switchxkblayout all prev";
          scroll-down = "hyprctl switchxkblayout all next";
          scroll-up = "hyprctl switchxkblayout all prev";
        };
      };
      styling = {
        palette = {
          bg = "#16161e";
          blue = "#7dcfff";
          elevated = "#202230";
          fg = "#c0caf5";
          fg-muted = "#a9b1d6";
          green = "#9ece6a";
          primary = "#7aa2f7";
          red = "#f7768e";
          surface = "#1a1b26";
          yellow = "#e0af68";
        };
      };
      wallpaper = {
        cycling-directory = "/home/simon/Pictures/Wallpapers";
        cycling-enabled = true;
        cycling-interval-mins = 10;
        transition-duration = 0.2;
        transition-fps = 59;
        transition-type = "fade";
      };
    };
  };
  # used by wayle as wallpaper engine
  services.awww.enable = true;

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
    enable = false;
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

      prismlauncher
      modrinth-app

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
      neomutt

      # Messanger
      signal-desktop

      # Chat
      discord

      # Office
      libreoffice-fresh
      simple-scan
      evince

      # Repair
      openboardview
      inputs.pld-usbc-v6.packages.${stdenv.hostPlatform.system}.default
      inputs.wallrust-pkg.packages.${stdenv.hostPlatform.system}.default

      # Neovim
      inputs.nomisvim.packages.${stdenv.hostPlatform.system}.default
    ]
    ++ [
      nomispkgs.git_alert
      nomispkgs.awww-info

      kdePackages.kdenlive

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
