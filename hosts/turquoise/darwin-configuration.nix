{inputs, ...}: 
{
  imports = [
    # inputs.self.nixosModules.host-shared
    inputs.self.darwinModules.darwin-desktop
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users.henrysipp.home = /Users/henrysipp;
  system.primaryUser = "henrysipp";

  home-manager.users.henrysipp = {
    imports = [ inputs.self.homeModules.darwin-desktop ];
    config.home.stateVersion = "25.11";
  };
}
