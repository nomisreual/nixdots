{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Import other modules
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./tlp.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    auto-optimise-store = true;
  };

  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/7eec5c88-ae73-4bf3-aa41-49c464da71eb";
    fsType = "ext4";
    options = [ "defaults" ];
  };

  fileSystems."/export/media" = {
    device = "/mnt/media";
    fsType = "none";
    options = [ "bind"];
  };
  networking.firewall.allowedTCPPorts = [2049];
  services.nfs.server = {
    enable = true;
    exports = ''
      /export 192.168.0.0/24(rw,sync,no_subtree_check,crossmnt,fsid=0)
      /export/media 192.168.0.0/24(rw,sync,no_subtree_check)
    '';
  };

  services.logind = {
    settings.Login.HandleLidSwitch = "ignore";
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
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # System wide packages
  environment.systemPackages = with pkgs; [
    git
    vim
    neovim
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "simon";
  };

  services.openssh.enable = true;
  programs.gnupg.agent.enable = true;

  system.stateVersion = "24.11";
}
