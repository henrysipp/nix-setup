{...}: 
{
  imports = [
    inputs.self.nixosModules.host-shared
    inputs.self.darwinModules.darwin-desktop
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users.henry.home = /Users/henry;

  home-manager.users.henry = {
    imports = [ inputs.self.homeModules.darwin-desktop ];
    config.home.stateVersion = "25.11";
  };

  system.stateVersion = 6;
}
