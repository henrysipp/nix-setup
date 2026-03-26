{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
    inputs.lanzaboote.nixosModules.lanzaboote
    ./hardware-configuration.nix
  ];

  hokum = {
    desktop.gnome.enable = true;
    dev.enable = true;
    packages.enable = true;
    users.henrysipp.enable = true;
  };

  environment.systemPackages = [
    pkgs.filezilla
    pkgs.sbctl
  ];

  hardware.fw-fanctrl.enable = true;
  services.fwupd.enable = true;

  services.fprintd.enable = true;
  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };

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
