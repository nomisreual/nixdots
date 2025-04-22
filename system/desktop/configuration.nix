{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Import other modules
  imports = [
    ./hardware-configuration.nix
    ../systemModules/steam.nix
    ../systemModules/hyprland
    ../systemModules/scan.nix
    ../systemModules/print.nix
    ../systemModules/postgresql.nix
    ../systemModules/gnome.nix
    ../systemModules/virtmanager.nix
    ../systemModules/distrobox.nix
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
  nix.settings.experimental-features = ["nix-command" "flakes"];

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

  # Cosmic Display Manager
  # services.displayManager.cosmic-greeter.enable = true;

  # Define users
  users.users.simon = {
    isNormalUser = true;
    description = "Simon Antonius Lauer";
    extraGroups = ["networkmanager" "wheel" "scanner" "lp" "cdrom"];
    packages = with pkgs; [];
  };

  # Enable nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 6";
    flake = "/home/simon/nixdots";
  };

  # System wide packages
  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];

  system.stateVersion = "24.11";
}
