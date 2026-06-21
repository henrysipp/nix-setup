# Global and app-specific window rules.
# Base: omarchy/default/hypr/windows.lua + default/hypr/apps.lua
{lib, ...}: let
  h = import ../../../lib/hyprland.nix {inherit lib;};
  apps = h.requireApps ./apps;
in {
  wayland.windowManager.hyprland.settings = {
    window_rule =
      [
        (h.window ".*" {suppress_event = "maximize";})
        (h.window ".*" {tag = "+default-opacity";})
        {
          match = {
            class = "^$";
            title = "^$";
            xwayland = true;
            float = true;
            fullscreen = false;
            pin = false;
          };
          no_focus = true;
        }
      ]
      ++ apps.windowRules
      ++ [
        (h.window {tag = "default-opacity";} {opacity = "0.97 0.9";})
      ];

    layer_rule = apps.layerRules;
  };
}
