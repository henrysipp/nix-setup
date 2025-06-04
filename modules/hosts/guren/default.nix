{
  inputs,
  config,
  ...
}: {
  flake.modules.hosts.guren = {
    imports = with (config.flake.modules.nixos);
      [
        # inputs.nixos-hardware.nixosModules.framework-13-amd-ai-300-series
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        base
        desktop
        dev
        games
        shell
      ]
      ++ config.flake.modules.nixosUsers.root.imports
      ++ config.flake.modules.nixosUsers.henry.imports
      ++ [
        {
          home-manager.users.henry.nixpkgs.config.allowUnfree = true;
        }
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

    hardware.graphics.enable = true;
    services.fwupd.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
