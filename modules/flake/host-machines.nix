{
  config,
  inputs,
  lib,
  ...
}: let
  flake.nixosConfigurations = {
    gawain = linux "gawain";
  };
  flake.darwinConfigurations = {
    # albion = darwin-arm "albion";
    # mordred = darwin-arm "mordred";
  };
  linux = mkNixos "x86_64-linux" "nixos";
  linux-arm = mkNixos "aarch64-linux" "nixos";
  darwin-intel = mkDarwin "x86_64-darwin";
  darwin-arm = mkDarwin "aarch64-darwin";

  # Helper functions for creating system configurations
  mkNixos = system: cls: name: let
    hostModule = config.flake.modules.hosts.${name};
    specialArgs = {
      inherit inputs;
      hostConfig = hostModule // {name = name;};
    };
  in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system specialArgs;
      modules =
        hostModule.imports
        ++ [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = specialArgs;
            networking.hostName = lib.mkDefault name;
            nixpkgs.hostPlatform = lib.mkDefault system;
            nixpkgs.config.allowUnfree = true;
          }
        ];
    };

  mkDarwin = system: name: let
    hostModule = config.flake.modules.hosts.${name};
    specialArgs = {
      inherit inputs;
      hostConfig = hostModule // {name = name;};
    };
  in
    inputs.nix-darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules =
        hostModule.imports
        ++ [
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.extraSpecialArgs = specialArgs;
            networking.hostName = lib.mkDefault name;
            nixpkgs.hostPlatform = lib.mkDefault system;
            nixpkgs.config.allowUnfree = true;
            system.stateVersion = 6;
          }
        ];
    };
in {
  inherit flake;
}
