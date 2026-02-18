{
  config,
  pkgs,
  inputs,
  nomispkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Custom system Modules
  steam.enable = true;
  virtmanager.enable = true;
  qtile.enable = true;
  distrobox.enable = true;
  printing.enable = true;
  scan.enable = true;
  hyprland.enable = true;
  plasma.enable = false;
  niri.enable = false;
  # greetd.enable = true;
  nomisos.ly.enable = true;
  postgres.enable = true;
  systemdboot.enable = true;
  locales = {
    enable = true;
    settings = {
      locale = "en_US.UTF-8";
      extraLocale = "de_DE.UTF-8";
      timeZone = "Europe/Berlin";
    };
  };

  # Kernel
  boot.kernelModules = ["sg"]; # required by MakeMKV for accessing BR drive.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Blueman - a bluetooth manager
  # services.blueman.enable = true;

  # Enable PCSC-Lite daemon, to access smart cards using SCard API (PC/SC)
  services.pcscd.enable = true;

  # Hostname
  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings = {
    auto-optimise-store = true;
  };

  # Enable Flakes and Nix command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # # Time zone
  # time.timeZone = "Europe/Berlin";
  #
  # # Internationalisation
  # i18n.defaultLocale = "en_US.UTF-8";
  #
  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "de_DE.UTF-8";
  #   LC_IDENTIFICATION = "de_DE.UTF-8";
  #   LC_MEASUREMENT = "de_DE.UTF-8";
  #   LC_MONETARY = "de_DE.UTF-8";
  #   LC_NAME = "de_DE.UTF-8";
  #   LC_NUMERIC = "de_DE.UTF-8";
  #   LC_PAPER = "de_DE.UTF-8";
  #   LC_TELEPHONE = "de_DE.UTF-8";
  #   LC_TIME = "de_DE.UTF-8";
  # };

  # Add fish to /etc/shells
  programs.fish.enable = true;

  # Define users
  users.users.simon = {
    isNormalUser = true;
    description = "Simon Antonius Lauer";
    extraGroups = ["networkmanager" "wheel" "scanner" "lp" "cdrom"];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # Enable nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 6";
  };

  # System wide packages
  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
    ];
  };

  services.geoclue2 = {
    enable = true;
  };

  # GnuPG
  programs.gnupg.agent.enable = true;

  system.stateVersion = "24.11";
}
