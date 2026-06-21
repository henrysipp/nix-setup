{
  description = "Henrysipp's Nix Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # 26.05 required for Hyprland Lua config generation (configType = "lua")
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    omarchy.url = "github:henrysipp/omarchy-nix";
    omarchy.inputs.nixpkgs.follows = "nixpkgs";
    omarchy.inputs.home-manager.follows = "home-manager";

    lanzaboote.url = "github:nix-community/lanzaboote/v1.0.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    flakeLib = import ./lib {inherit inputs;};
    localOverlays = import ./overlays {inherit inputs;};
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    lib = flakeLib;
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          localOverlays.overlay-cursor
        ];
      };
    in {
      default = pkgs.mkShell {
        packages = with pkgs;
          [
            alejandra
            git
            nil
            nixd
          ]
          ++ nixpkgs.lib.optionals (system == "x86_64-linux") [
            code-cursor
          ];
      };
    });
    checks = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatting =
        pkgs.runCommand "nix-setup-formatting-check" {
          nativeBuildInputs = [pkgs.alejandra];
        } ''
          cd ${self}
          alejandra --check .
          touch $out
        '';
    });

    overlays = localOverlays;
    nixosModules = {
      default = import ./modules/nixos;
    };
    homeModules = {
      default = import ./modules/home;
    };
    nixosConfigurations = {
      siegfried = flakeLib.mkNixosHost {
        path = ./hosts/siegfried;
      };
    };
  };
}
