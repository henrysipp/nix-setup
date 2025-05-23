# Albion
# This is the configuration for my work Macbook Pro
{inputs, ...}: 
{
  imports = [
    # inputs.self.nixosModules.host-shared
    inputs.self.darwinModules.darwin-desktop
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users.henry.home = /Users/henry;
  system.primaryUser = "henry";
  
  home-manager.users.henry = {
    imports = [ inputs.self.homeModules.darwin-desktop ];
    config.home.stateVersion = "25.11";
  };

   # Add homebrew package management
  homebrew = {
    taps = [
      # "nikitabobko/aerospace"
      "tuist/tuist"
    ];
    brews = [
      "tuist/tuist/tuist@4.20.0"
      "awscli"
      "swiftformat"
      "swiftlint"
      "lefthook"
    ];
    casks = [];
  };

}
