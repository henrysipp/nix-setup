{
  flake,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.self.homeModules.home-shared
    inputs.self.homeModules.nix-desktop
  ];
}
