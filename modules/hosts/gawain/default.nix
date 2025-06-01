{config, ...}: {
  flake.modules.hosts.gawain.imports = with (config.flake.modules.nixos);
  # Import nixos modules for host `gawain`
    [
      base
      desktop
      shell
      # fwupd
    ]
    # Import the `nixosUsers`
    ++ config.flake.modules.nixosUsers.root.imports
    ++ config.flake.modules.nixosUsers.henry.imports
    ++ [
      #Import home-manager modules for `henry` only.
      {
        home-manager.users.henry.imports = with config.flake.modules.homeManager; [
          base
          desktop
          dev
          games
          shell
        ];
      }
    ];

  # home-manager.backupFileExtension = "backup";
  # home-manager.users.henry = {
  #   imports = [
  #     inputs.self.homeModules."${desktopManager}"
  #   ];
  #   config.home.stateVersion = "25.11";
  # };
}
