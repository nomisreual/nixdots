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
  programs.fish.enable = true;

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
      "obs"
      "1password"
      "thunderbird@esr"
      "spotify"
      "slack"
      "obsidian"
      "signal"
      "vlc"
      "microsoft-office"
      "balenaetcher"
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

  users.users."simon".shell = pkgs.fish;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
