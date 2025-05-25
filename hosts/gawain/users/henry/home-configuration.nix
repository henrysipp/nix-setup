{
  flake,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.self.homeModules.home-shared
    inputs.self.homeModules.desktop
    # inputs.self.homeModules.hyprland
  ];
}
