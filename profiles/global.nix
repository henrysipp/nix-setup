{
  pkgs,
  lib,
  outputs,
  ...
}: {
  imports = [
  ];

  time.timeZone = "America/Chicago";
  nixpkgs = {
    overlays = [
      # outputs.overlays.overlay-additions
      # outputs.overlays.overlay-modifications
      outputs.overlays.overlay-codex
      outputs.overlays.overlay-cursor
      outputs.overlays.overlay-adwaita-hyprcursor
      outputs.overlays.overlay-unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = ["root" "henrysipp"];
  };
  services.tailscale.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = [pkgs.btop];
}
