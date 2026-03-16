{
  pkgs,
  outputs,
  ...
}: {
  home-manager.backupFileExtension = "backup";
  environment.systemPackages = [
    # pkgs.unstable.claude-code
    pkgs.unstable.discord
    # pkgs.obs-studio
    # pkgs.telegram-desktop
    pkgs.nixos-anywhere
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["henrysipp"];
  };

  # programs.obs-studio = {
  #   enable = true;
  #   enableVirtualCamera = true;
  #   plugins = with pkgs.obs-studio-plugins; [
  #     wlrobs
  #     obs-backgroundremoval
  #     obs-pipewire-audio-capture
  #     obs-vaapi
  #     obs-gstreamer
  #     obs-vkcapture
  #   ];
  # };
}
