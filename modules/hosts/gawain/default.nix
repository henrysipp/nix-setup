{config, ...}: {
  flake.modules.hosts.gawain = {
    imports = with (config.flake.modules.nixos);
    # Import nixos modules for host `gawain`
      [
        base
        desktop
        dev
        games
        shell
        # fwupd
      ]
      ++ config.flake.modules.nixosUsers.root.imports
      ++ config.flake.modules.nixosUsers.henry.imports
      ++ [
        {
          home-manager.users.henry.nixpkgs.config.allowUnfree = true;
        }
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
  };
}
