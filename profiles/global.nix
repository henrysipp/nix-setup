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
      # outputs.overlays.additions
      # outputs.overlays.modifications
      outputs.overlays.codex
      outputs.overlays.unstable-packages
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
