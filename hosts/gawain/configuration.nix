# Gawain
# This is the configuration for my desktop gaming PC.
{
  flake,
  config,
  pkgs,
  inputs,
  ...
}: let
  desktopManager = "gnome";
in {
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosModules.desktop-common # Common desktop utils
    inputs.self.nixosModules."${desktopManager}" #Desktop environment
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
    hostName = "gawain";
    wireless.enable = false;
    networkmanager.enable = true;
  };

  home-manager.backupFileExtension = "backup";
  home-manager.users.henry = {
    imports = [
      inputs.self.homeModules."${desktopManager}"
    ];
    config.home.stateVersion = "25.11";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "25.05"; # Did you read the comment?
}
