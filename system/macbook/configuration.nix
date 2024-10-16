{ self, pkgs, ... }:
{

  # Hide dock and menu bar:
  # system.defaults = {
  #   dock.autohide = true;
  #   NSGlobalDomain._HIHideMenuBar = true;
  # };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Enable TouchID for sudo:
  # security.pam.enableSudoTouchIdAuth = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";


  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    gnupg

    uv
    nodejs_22
    python3

    ripgrep
    fzf
    fd
    wget
    neovim
    tmux
    yazi
    starship
    zoxide
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FantasqueSansMono" "Hack" ]; })
  ];


  # Homebrew
  homebrew = {
    enable = true;
    casks = [
      "1password"
      "brave-browser"
      "thunderbird@esr"
      "spotify"
      "slack"
      "obsidian"
      "kitty"
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
