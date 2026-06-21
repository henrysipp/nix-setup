{
  osConfig,
  pkgs,
  lib,
  ...
}: let
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
      env = [
        {
          _args = [
            "HYPRCURSOR_THEME"
            cursorTheme
          ];
        }
        {
          _args = [
            "HYPRCURSOR_SIZE"
            (toString cursorSize)
          ];
        }
        {
          _args = [
            "XCURSOR_THEME"
            cursorTheme
          ];
        }
        {
          _args = [
            "XCURSOR_SIZE"
            (toString cursorSize)
          ];
        }
      ];

      config.cursor = {
        enable_hyprcursor = true;
      };
    };
  };
}
