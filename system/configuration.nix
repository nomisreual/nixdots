{ config, pkgs, inputs, ... }:

{
  # Import other modules
  imports =
    [
      ./hardware-configuration.nix
      ./steam.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Splash Screen
  boot.plymouth.enable = true;

  # Hostname
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Flakes and Nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Time zone
  time.timeZone = "Europe/Berlin";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Hyprland Window Manager
  programs.hyprland.enable = true;

  # Cosmic Display Manager
  services.displayManager.cosmic-greeter.enable = true;

  # Define users
  users.users.simon = {
    isNormalUser = true;
    description = "Simon Antonius Lauer";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Enable nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 6";
    flake = "/home/simon/.nixdots";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

  gcc

  # web browsers
  firefox
  brave

  thunderbird  # mail client

  git  # no need for an introduction
  vim  # the classic

  # for neovim
  neovim  # text editor
  # fzf  # fuzzy finder
  ripgrep  # grep on steroids
  fd  # goated find
  # wl-clipboard  # clipboard

  stow  # for managing dotfiles


  # For media controls from within waybar
  inputs.mediaplayer.packages.${pkgs.system}.default
  playerctl

  # For Hyprland
  hyprsunset  # night light
  waybar  # panel
  wofi  # app launcher
  hyprpaper  # wallpaper daemon
  hypridle  # idle daemon
  hyprlock  # lock screen
  swaynotificationcenter  # notifications
  pyprland  # plugins (scratchpads)
  rose-pine-hyprcursor  # cursor theme
  pavucontrol  # gui for audio devices
  kitty  # terminal
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
