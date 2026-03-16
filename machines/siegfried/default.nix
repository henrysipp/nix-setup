{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.default
      inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
      inputs.lanzaboote.nixosModules.lanzaboote
      ../../modules/users/henrysipp.nix
      ./hardware-configuration.nix

      ../../profiles/global.nix
      ../../profiles/desktop.nix
      ../../profiles/dev.nix
      ../../profiles/packages.nix

      ../../profiles/gnome/default.nix
    ];

  home-manager.users.henrysipp = {
    imports = [
      ../../home/henrysipp
    ];
  };

  environment.systemPackages = [
    pkgs.filezilla
    pkgs.sbctl
  ];
  
  # Fan control
  hardware.fw-fanctrl.enable = true;
  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };
  services.fwupd.enable = true;
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  security.pam.services.sudo.fprintAuth = true;
  security.pam.services.gdm.fprintAuth = true;
  security.pam.services.gdm-password.fprintAuth = true;
  networking.hostName = "siegfried";
  system.stateVersion = "25.05";
  security.polkit.enable = true;

  boot.loader = {
    timeout = 5;
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = lib.mkForce false;
  };
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
