{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
    home-manager,
    ...
  } @ inputs: let
    linux = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      pkgs = import nixpkgs {
        system = linux;
        config.allowUnfree = true;
      };
      specialArgs = {inherit inputs;};
      modules = [
        ./system/configuration.nix
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
