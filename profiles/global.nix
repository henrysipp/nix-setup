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
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };
  nix.settings.experimental-features = "nix-command flakes";
  services.tailscale.enable = true;

  environment.systemPackages = [pkgs.btop];
}
