{
  description = "NixOS configuration";

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
    mediaplayer = {
      url = "github:nomisreual/mediaplayer";
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
      modules = [./home/home.nix];
    };
  };
}
