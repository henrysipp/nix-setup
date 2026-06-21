{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  h = import ../../../lib/hyprland.nix {inherit lib;};
  cfg = osConfig.hokum.desktop.hyprland;
  cursorTheme = "Adwaita";
  cursorSize = 24;
in {
  home.pointerCursor = lib.mkIf cfg.enable {
    package = pkgs.adwaita-hyprcursor;
    name = cursorTheme;
    size = cursorSize;

    gtk.enable = true;
    hyprcursor.enable = true;
  };

  wayland.windowManager.hyprland = lib.mkIf cfg.enable {
    # Hyprland starts from GDM before shell profile vars are loaded.
    importantPrefixes = lib.mkBefore ["env"];

    systemd.variables = [
      "DISPLAY"
      "HYPRLAND_INSTANCE_SIGNATURE"
      "WAYLAND_DISPLAY"
      "XDG_CURRENT_DESKTOP"
      "XDG_SESSION_TYPE"
      "HYPRCURSOR_THEME"
      "HYPRCURSOR_SIZE"
      "XCURSOR_THEME"
      "XCURSOR_SIZE"
    ];

    settings = {
      env = h.envs {
        HYPRCURSOR_THEME = cursorTheme;
        HYPRCURSOR_SIZE = cursorSize;
        XCURSOR_THEME = cursorTheme;
        XCURSOR_SIZE = cursorSize;
      };

      config.cursor.enable_hyprcursor = true;
    };
  };
}
