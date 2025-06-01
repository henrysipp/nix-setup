{...}: {
  flake.modules.homeManager.base = {config, ...}: {
    programs.home-manager.enable = true;

    home.file = {
      # Copy home files here
    };

    services = {
      home-manager.autoExpire = {
        enable = true;
        frequency = "weekly";
        store.cleanup = true;
      };
    };
  };
}
