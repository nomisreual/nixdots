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

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["sg"]; # required by MakeMKV for accessing BR drive.
    supportedFilesystems = ["nfs"];
    # Silence text output
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    kernelParams = [
      # for plymouth
      "quiet"
      "splash"
      "rd.systemd.show_status=auto"

      # sleep issues
      "mem_sleep_default=deep"
      "amd_pstate=disable"
    ];

    # Enable Plymouth
    plymouth = {
      enable = true;
    };
  };

  fileSystems."/mnt/media" = {
    device = "192.168.0.224:/media";
    options = ["rw"];
    fsType = "nfs4";
  };

  fileSystems."/mnt/backups" = {
    device = "/dev/disk/by-uuid/1724e2bc-215a-4a66-ab9d-7d0b4ed71fae";
    fsType = "ext4";
    options = ["defaults"];
  };

  services.usbmuxd = {
    enable = true;
    # package = pkgs.usbmuxd2;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  #
  hardware.enableRedistributableFirmware = true;

  # Enable PCSC-Lite daemon, to access smart cards using SCard API (PC/SC)
  services.pcscd.enable = true;

  # Hostname
  networking.hostName = "nixos";

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Enable Flakes and Nix command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Make sure you don't have services.resolved.enable on.

  # Add fish to /etc/shells
  programs.fish.enable = true;

  # Define users
  users.users.simon = {
    isNormalUser = true;
    description = "Simon Antonius Lauer";
    extraGroups = ["networkmanager" "wheel" "scanner" "lp" "cdrom" "dialout" "usbmux"];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # System wide packages
  environment.systemPackages = with pkgs; [
    git
    vim
    makemkv
    libbluray
    libaacs
    libbdplus

    libimobiledevice
    ifuse # optional, to mount using 'ifuse'
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fantasque-sans-mono
    ];
  };

  services.geoclue2 = {
    enable = false;
  };

  # GnuPG
  programs.gnupg.agent.enable = true;

  system.stateVersion = "24.11";
}
