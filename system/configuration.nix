{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./greetd.nix
    ];

  # Configure nixpkgs:
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix.settings = {
    # nix command and flakes
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Systemd-Boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking.
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Printer disovery.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # User accounts.
  users.users.simon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "scanner" "lp" ];
    packages = with pkgs; [
    ];
  };

  # System packages:
  environment.systemPackages = with pkgs; [
    unzip
    wget
    curl
    git
    gcc
    cifs-utils
    samba

    vim
    kitty

    mako
    rofi-wayland
    gammastep
    pyprland
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    hyprpaper
    hypridle

  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    font-awesome
  ];

  # Hyprland
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  # programs.waybar.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  # Nix LD
  programs.nix-ld.enable = true;

  # NH
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/simon/.nixdots";
  };

  # List services that you want to enable:
  services.gvfs.enable = true;

  services.geoclue2.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
  };

  # services.hypridle.enable = true;

  system.stateVersion = "24.05";
}

