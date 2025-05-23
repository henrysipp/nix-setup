{ flake, config, pkgs, inputs, ... }: 
{
  imports = [ 
    ./hardware-configuration.nix
    # inputs.self.nixosModules.host-shared 
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.gnome
  ];

  # on nixos this either isNormalUser or isSystemUser is required to create the user.
  users.users.henry.isNormalUser = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 6;
    };
  };

  networking = {
    hostName = "aquamarine";
    wireless.enable = false;
    networkmanager.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  home-manager.users.henry = {
    imports = [ inputs.self.homeModules.desktop ];
    config.home.stateVersion = "25.11";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "25.05"; # Did you read the comment?
}
