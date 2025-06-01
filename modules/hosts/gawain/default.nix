{...}: {
  flake.modules.hosts.gawain = {config, ...}: {
    system = "x86_64-linux";  
    imports = with (config.flake.modules.nixos);
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
  };
}