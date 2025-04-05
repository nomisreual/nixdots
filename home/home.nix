{pkgs, ...}: {
  # User information
  home.username = "simon";
  home.homeDirectory = "/home/simon";

  home.stateVersion = "24.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./theme.nix
  ];

  # Packages
  home.packages = with pkgs; [
    _1password-gui
    yazi
  ];

  home.file = {
  };

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  programs.git = {
    enable = true;
    userName = "Simon Antonius Lauer";
    userEmail = "simon.lauer@posteo.de";
    extraConfig = {
      init = {
        defaultbranch = "main";
      };
      core = {
        editor = "vim";
      };
    };
  };

  # Environmental Variables

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
