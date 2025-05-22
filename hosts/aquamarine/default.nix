{config, ...} @ args: {
  imports = [
    ../../modules/nixos/core-desktop.nix
    ../../modules/nixos/user-groups.nix

    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "aquamarine";
    wireless.enable = false;
    networkmanager.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = true;
  };
}
