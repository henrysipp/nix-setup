{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hokum.desktop.gnome.enable = lib.mkEnableOption "GNOME desktop environment";

  config = lib.mkIf config.hokum.desktop.gnome.enable {
    hokum.desktop.enable = lib.mkDefault true;

    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.desktopManager.gnome.sessionPath = [pkgs.gdm];
    services.gnome.gcr-ssh-agent.enable = false;

    environment.systemPackages = with pkgs; [
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-in-panel
      gnomeExtensions.dash-to-dock
      gnomeExtensions.hot-edge
      gnomeExtensions.appindicator
      gnomeExtensions.just-perfection
      gnomeExtensions.arc-menu
      gnomeExtensions.paperwm
      gnome-tweaks
      vscode
    ];
  };
}
