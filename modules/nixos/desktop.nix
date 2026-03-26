{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hokum.desktop.enable = lib.mkEnableOption "desktop workstation defaults";

  config = lib.mkIf config.hokum.desktop.enable {
    home-manager.backupFileExtension = "backup";
    environment.systemPackages = [
      pkgs.unstable.discord
      pkgs.nixos-anywhere
    ];

    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };

    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = ["henrysipp"];
    };
  };
}
