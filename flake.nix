{
  description = "Nix configuration for my linux desktop and Mac";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nomisreual/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mediaplayer = {
      url = "github:nomisreual/mediaplayer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git_alert = {
      url = "github:nomisreual/git_alert";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # only if nixpkgs unstable is in use
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sessionizer = {
      url = "github:nomisreual/sessionizer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  } @ inputs: let
    linux = "x86_64-linux";
    mac = "x86_64-darwin";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      pkgs = import nixpkgs {
        system = linux;
        config.allowUnfree = true;
      };
      specialArgs = {inherit inputs;};
      modules = [
        ./system/desktop/configuration.nix
      ];
    };

    darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
      pkgs = import nixpkgs {
        system = mac;
        config.allowUnfree = true;
      };
      modules = [
        ./system/mac/configuration.nix
      ];
    };

    homeConfigurations."simon" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = linux;
        config.allowUnfree = true;
      };
      modules = [./home/desktop/home.nix];
      extraSpecialArgs = {
        inherit inputs;
      };
    };

    homeConfigurations."simon@mac" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = mac;
        config.allowUnfree = true;
      };
      modules = [./home/mac/home.nix];
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}
