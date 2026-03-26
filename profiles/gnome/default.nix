{pkgs, ...}: {
  #   services.displayManager.gdm.enable = true;
  #   services.desktopManager.gnome.enable = true;
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.desktopManager.gnome.sessionPath = [pkgs.gdm];
  # Keep GNOME Keyring, but disable its GCR SSH agent so 1Password can own SSH_AUTH_SOCK.
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
}
