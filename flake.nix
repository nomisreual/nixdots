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
    architectures = {
      linux = "x86_64-linux";
      mac = "x86_64-darwin";
    };
    pkgs_for_system = architecture: (
      import nixpkgs {
        system = architecture;
      }
    );
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./system/desktop/configuration.nix
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./system/laptop/configuration.nix
        ];
      };
    };

    darwinConfigurations = {
      macbook = nix-darwin.lib.darwinSystem {
        modules = [
          ./system/mac/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "simon@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs_for_system architectures.linux;
        modules = [./home/desktop/home.nix];
        extraSpecialArgs = {
          inherit inputs;
        };
      };

      "simon@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs_for_system architectures.linux;
        modules = [./home/laptop/home.nix];
        extraSpecialArgs = {
          inherit inputs;
        };
      };

      "simon@mac" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs_for_system architectures.mac;
        modules = [./home/mac/home.nix];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
