{pkgs, ...}: {
  imports = [
    ./binds.nix
    ./hypridle.nix
    ./hyprland.nix
    # ./hyprlock.nix
    ./windowrules.nix
  ];
}
