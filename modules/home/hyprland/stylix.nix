{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
  typography = import ../../../lib/quickshell-typography.nix lib;
  mkTheme = import ../../../lib/quickshell-theme.nix;
  h = import ../../../lib/hyprland.nix {inherit lib;};
  restartQuickshell = pkgs.writeShellScript "restart-quickshell" ''
    export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    ${pkgs.systemd}/bin/systemctl --user restart quickshell.service 2>/dev/null || true
  '';
in {
  stylix = lib.mkIf cfg.enable {
    autoEnable = false;

    targets = {
      gtk.enable = true;
      qt.enable = true;
      kde = {
        enable = true;
        useWallpaper = false;
      };

      ghostty = {
        enable = true;
        fonts.enable = false;
      };
    };
  };

  xdg.configFile."quickshell/widgets/theme/Theme.qml" = lib.mkIf cfg.enable {
    text = mkTheme {
      colors = config.hokum.theme.colors;
      inherit typography;
    };
    onChange = "${restartQuickshell}";
  };

  # Dolphin reads ~/.config/kdeglobals before XDG_CONFIG_DIRS, so a stale
  # Breeze file from an earlier session blocks the Stylix KDE color scheme.
  xdg.configFile."kdeglobals".text = lib.mkIf cfg.enable ''
    [KDE]
    LookAndFeelPackage[$i]=stylix
    widgetStyle=Breeze

    [UiSettings]
    ColorScheme=Stylix
  '';

  xdg.configFile."kdedefaults/kdeglobals".text = lib.mkIf cfg.enable ''
    [General]
    ColorScheme=Stylix

    [KDE]
    widgetStyle=Breeze
  '';

  # Hyprland starts before login-shell profile vars; push Qt6 theming into the
  # compositor environment so Dolphin picks up qt6ct + Kvantum.
  wayland.windowManager.hyprland.settings.env = lib.mkIf cfg.enable (
    h.envs {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_STYLE_OVERRIDE = "kvantum";
    }
  );
}
