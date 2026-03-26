{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../../profiles/global.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };
}
