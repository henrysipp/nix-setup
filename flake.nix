{
  description = "Nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:nix-darwin/nix-darwin/master";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let 
    username = "henry";
    system = "aarch64-darwin";
    hostname = "Henrys-MacBook-Pro";
    specialArgs =
      inputs
      // {
        inherit username hostname;
      };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [ 
        ./modules/configuration.nix
        ./modules/apps.nix
        # ./modules/host-users.nix
        
        # Network configuration in an inline module
        { 
          networking.hostName = hostname; 
          networking.computerName = hostname;
        }
        
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          
          home-manager.users.henry = import ./modules/home.nix;
          home-manager.extraSpecialArgs = specialArgs; 
        }
      ];
    };
  };
}