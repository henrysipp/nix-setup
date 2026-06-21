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

    hardware.bluetooth = {
      enable = lib.mkDefault true;
      powerOnBoot = lib.mkDefault true;
    };

    environment.systemPackages = [
      pkgs.kdePackages.dolphin
      pkgs.playerctl
      pkgs.bluez
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
