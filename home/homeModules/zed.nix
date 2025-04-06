{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      nixd
      alejandra
      package-version-server
      # pyright
      ruff
      python312
      python312Packages.python-lsp-server
    ];
    extensions = ["nix"];
    userSettings = {
      autosave = "off";
      features = {
        edit_prediction_provider = "none";
      };

      # Unclutter the UI
      cursor_blink = false;
      relative_line_numbers = true;
      scrollbar = {
        show = "never";
      };
      toolbar = {
        quick_actions = false;
        breadcrumbs = false;
      };

      # Theming
      ui_font_size = 16;
      buffer_font_size = 18;
      buffer_font_family = "FantasqueSansM Nerd Font Mono";
      theme = {
        mode = "system";
        light = "Rosé Pine Moon";
        dark = "Rosé Pine Moon";
      };

      # Vim Motions
      vim_mode = true;

      # General language specific settings
      languages = {
        Nix = {
          language_servers = ["nixd" "!nil"];
          format_on_save = "on";
          formatter = {
            external = {
              command = "alejandra";
            };
          };
        };
        python = {
          language_servers = ["ruff"];
          format_on_save = "on";
          formatter = {
            external = {
              command = "ruff";
              arguments = ["format"];
            };
          };
        };
      };
      lsp = {
        nixd = {
          settings = {
            diagnostic = {
              suppress = ["sema-extra-with"];
            };
          };
        };
        ruff = {
          initialization_options = {
            settings = {
              lineLength = 80;
              lint = {
                extendSelect = ["I"];
              };
            };
          };
        };
      };
    };
    userKeymaps = [
      {
        context = "Dock || Terminal || Editor";
        bindings = {
          ctrl-h = "workspace::ActivatePaneLeft";
          ctrl-l = "workspace::ActivatePaneRight";
          ctrl-k = "workspace::ActivatePaneUp";
          ctrl-j = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "Editor && VimControl && !VimWaiting && !menu";
        bindings = {
          "space e" = "workspace::ToggleLeftDock";
          "space f" = "project_panel::ToggleFocus";
        };
      }
    ];
  };
}
