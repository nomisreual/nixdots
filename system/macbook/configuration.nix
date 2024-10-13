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

  environment.systemPackages =
    with pkgs; [
      mise
      vim
      htop
      neovim
      poetry
      tmux
      wget
      tree-sitter
      gnupg
      stow
      starship
      zoxide
      fd
      ripgrep
      fzf
      bat
      yazi
    ];
  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FantasqueSansMono" "Hack" ]; })
  ];


  # Homebrew
  homebrew = {
    enable = true;
    casks = [
      "visual-studio-code"
      "spotify"
      "google-chrome"
      "docker"
      "tower"
      "1password"
      "postman"
      "dbeaver-community"
      "kitty"
      "slack"
      "thunderbird"
      "zed"
      "brave-browser"
      "firefox"
      "obsidian"
      "warp"
      "brave-browser"
      "pdf-expert"
    ];
    brews = [
    ];
    taps = [
    ];
    onActivation = {
      autoUpdate = false;
      cleanup = "none";
    };
  };


  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}
