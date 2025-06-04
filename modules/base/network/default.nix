{...}: {
  flake.modules.nixos.base = {hostConfig, ...}: {
    networking = {
      hostName = hostConfig.name;
      networkmanager.enable = true;
    };

    # DNS
    services.resolved.enable = true;
    # services.samba.enable = true;
  };
}
