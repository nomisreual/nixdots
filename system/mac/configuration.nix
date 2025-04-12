{pkgs, ...}: {
  nix.enable = true;
  ids.gids.nixbld = 350;
  imports = [
    ../systemModules/postgresdarwin.nix
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # web browsers
    firefox
    brave

    # nixd
    # nil
    # alejandra
    # nodejs_22
    # python313
    gnupg
    direnv
    uv
    # ripgrep
    # fzf
    # fd
    wget
    # neovim
    yazi
    # starship
    # zoxide
    # stow
    lazygit
    gh
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.hack
  ];

  # Homebrew
  homebrew = {
    enable = true;
    casks = [
      "filen"
      "obs"
      "1password"
      # "brave-browser"
      "thunderbird@esr"
      "spotify"
      "slack"
      "obsidian"
      # "kitty"
      # "ghostty"
      "signal"
      "vlc"
      # "zed"
      "microsoft-office"
      "slack"
      "balenaetcher"
      # "firefox"
      "zen-browser"
    ];
    brews = [
    ];
    taps = [
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
