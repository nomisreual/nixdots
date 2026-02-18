{pkgs, ...}: {
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
  greetd.enable = false;
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
