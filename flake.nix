{
  description = "Henry's Nix Config";
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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nixvim,
    ...
  }: let
    username = "henry";
    userfullname = "Henry Sipp";
    useremail = "hesipp@gmail.com";

    # system = "aarch64-darwin";
    # hostname = "Henrys-MacBook-Pro";

    x64_system = "x86_64-linux";
    arch64_darwin = "aarch64-darwin";
    allSystems = [x64_system arch64_darwin];

    nixosSystem = import ./utils/nixosSystem.nix;
    macosSystem = import ./utils/macosSystem.nix;
    # macSystem = import (builtins.path {path = ./utils/macosSystem.nix;});
  in {
    # NixOS Configurations
    nixosConfigurations = let
      # Specify other nixos configurations here
      aquamarine_modules = {
        nixos-modules = [
          ./hosts/aquamarine
          # ./modules/nixos/hyprland.nix
        ];
        home-module = import ./home/linux/desktop-hyprland.nix;
      };

      system = x64_system;
      specialArgs =
        {
          inherit username userfullname useremail;
        }
        // inputs;

      base_args = {
        inherit home-manager nixvim system specialArgs;
      };

      stable_args = base_args // {inherit nixpkgs;};
    in {
      # Build them here
      aquamarine = nixosSystem (aquamarine_modules // stable_args);
    };

    # MacOS configuration
    darwinConfigurations = let
      system = arch64_darwin;
      specialArgs =
        {
          inherit username userfullname useremail;
        }
        // inputs;

      base_args = {
        inherit nix-darwin home-manager system specialArgs;
      };
    in {
      cerulean = macosSystem (base_args
        // {
          darwin-modules = [
            ./hosts/cerulean
          ];
          home-module = import ./home/darwin;
        });
    };


    # format the nix code in this flake
    # alejandra is a nix formatter with a beautiful output
    formatter = nixpkgs.lib.genAttrs allSystems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );
  };
  

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };
}
