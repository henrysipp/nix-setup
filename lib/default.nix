{inputs}: let
  host = import ./host.nix {inherit inputs;};
in
  host
  // {
    hyprland = import ./hyprland.nix;
  }
