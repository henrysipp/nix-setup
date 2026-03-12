{pkgs, ...}: {
  #   services.displayManager.gdm.enable = true;
  #   services.desktopManager.gnome.enable = true;
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-in-panel
    gnomeExtensions.dash-to-dock
    gnomeExtensions.hot-edge
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
    gnomeExtensions.paperwm
    gnome-tweaks
    vscode
  ];
}
