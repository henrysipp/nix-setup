{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hokum.desktop.hyprland.enable = lib.mkEnableOption "Hyprland desktop environment";

  config = lib.mkIf config.hokum.desktop.hyprland.enable {
    hokum.desktop.enable = lib.mkDefault true;

    services.displayManager.gdm.enable = true;
    services.displayManager.defaultSession = "hyprland";

    programs.hyprland = {
      enable = true;
      withUWSM = false;
      xwayland.enable = true;
    };

    fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];

    environment.systemPackages = [
      pkgs.kdePackages.dolphin
      pkgs.wofi
      pkgs.playerctl
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
