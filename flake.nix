{
  description = "Henry's Nix Config";
  inputs = {
    nixpkgs.url = "github:/nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:/nixos/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-webapps.url = "github:TLATER/nix-webapps";

    ags.url = "github:Aylur/ags";

    import-tree.url = "github:vic/import-tree";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {
    imports = [
      inputs.flake-parts.flakeModules.modules
    ] ++ (inputs.import-tree ./modules).imports;
    
    # Systems must be defined at the top level for flake-parts
    systems = import inputs.systems;
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
  };
}
