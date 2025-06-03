# Albion
# This is the configuration for my work Macbook Pro
{config, ...}: {
  flake.modules.hosts.albion = {
    imports = with (config.flake.modules.darwin); [
      system
      desktop
      #work
    ] 
    ++ [
      {
        home-manager.users.henry.nixpkgs.config.allowUnfree = true;
      }
      {
        home-manager.users.henry.imports = with config.flake.modules.homeManager; [
          base
          darwin-desktop
          shell
        ];
      }
    ];

    nixpkgs.hostPlatform = "aarch64-darwin";
    users.users.henry.home = /Users/henry;
    system.primaryUser = "henry";

    homebrew = {
      taps = [
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
  };
}
