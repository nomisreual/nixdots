{
  description = "My NixOS config";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprcursor Theme
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    # Mediaplayer
    mediaplayer = {
      url = "github:nomisreual/mediaplayer";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self
    , nixpkgs
    , nix-darwin
    , home-manager
    , ...
    } @ inputs:
    let
      linux = "x86_64-linux";
      mac = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${linux};
      mac-pkgs = nixpkgs.legacyPackages.${mac};
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./system/desktop/configuration.nix
          ];
        };
      };

      darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
        inherit mac-pkgs;
        modules = [
          ./configuration.nix
        ];
      };

      homeConfigurations."simon@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home/desktop.nix ];

        extraSpecialArgs = {
          inherit inputs;
        };
      };

    };
}
