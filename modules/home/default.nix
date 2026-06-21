{...}: {
  imports = [
    # Add home-manager modules here.
    ./gnome-desktop.nix
    ./gnome-keybindings.nix
    ./hyprland
    ./programs.nix
  ];
}
