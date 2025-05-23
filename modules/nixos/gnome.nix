{ ... }:
{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  # Disable indexing service to save power
  services.gnome.localsearch.enable = false;
  services.libinput.enable = true;
}