{
  description = "Modular nix-darwin + home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      system = "x86_64-darwin"; # or "aarch64-darwin"
      hostname = "Toyos-MacBook-Pro";
    in {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./config.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.users.toyo = import ./home.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}

