{...}: {
  imports = [
    ./common.nix
    ./desktop.nix
    ./dev.nix
    ./gnome.nix
    ./hyprland.nix
    ./packages.nix
    ./users/henrysipp.nix
    ../system/berkeley-mono
  ];
}
