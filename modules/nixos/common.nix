{
  flake,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./henry.nix
    inputs.home-manager.nixosModules.default
  ];

  time.timeZone = "America/Chicago";

  services.samba.enable = true;
  #   fileSystems."/mnt/share" = {
  #   device = "//henrysnas/music";
  #   fsType = "cifs";
  #   options = let
  #     # this line prevents hanging on network split
  #     automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=58,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

  #   in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  # };

  # nix-flatpak.nixosModules.nix-flatpak
  environment.systemPackages = with pkgs; [
    cifs-utils
    neovim
    wget
    curl
    git
    neofetch
    gh
    gnumake
  ];

  programs = {
    firefox.enable = true;
    steam.enable = true;
    _1password-gui.enable = true;
    dconf.enable = true;
  };
}
