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
    wrappers.url = "github:lassulus/wrappers";
    nomisvim = {
      url = "github:nomisreual/nomisvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nomispkgs = {
      url = "github:nomisreual/nomispkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nomispkgs,
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
    nomispkgs_for_system = architecture: (
      nomispkgs.packages.${architecture}
    );
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./system/desktop/configuration.nix
          ./systemModules
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./system/laptop/configuration.nix
          ./systemModules
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
        modules = [
          ./home/desktop/home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          nomispkgs = nomispkgs_for_system architectures.linux;
        };
      };

      "simon@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs_for_system architectures.linux;
        modules = [./home/laptop/home.nix];
        extraSpecialArgs = {
          inherit inputs;
        };
      };

      "simon@macbook" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs_for_system architectures.mac;
        modules = [./home/mac/home.nix];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
