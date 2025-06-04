{pkgs, ...}: {
  flake.modules.hosts.guren.boot = {
    # kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        # configurationLimit = 4;
      };
    };
  };
}
