{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Import other modules
  imports = [
    ./hardware-configuration.nix
    ./greetd.nix
    ../systemModules/steam.nix
    ../systemModules/hyprland
    ../systemModules/scan.nix
    ../systemModules/print.nix
    ../systemModules/postgresql.nix
    # ../systemModules/gnome.nix
    ../systemModules/virtmanager.nix
    ../systemModules/distrobox.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  nixpkgs.config.allowUnfree = true;

  # Nvidia
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:2:0:0";
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };

  # power save

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

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

  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];

  # GnuPG
  programs.gnupg.agent.enable = true;

  system.stateVersion = "24.11";
}
