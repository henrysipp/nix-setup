{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.hokum.desktop.hyprland;
  theme = config.hokum.theme;
in {
  programs.firefox = lib.mkIf cfg.enable {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      id = 0;
      isDefault = true;
      path = "49cb54wy.default";
      extensions.force = true;

      settings = {
        "ui.systemUsesDarkTheme" = theme.isDark;
        "browser.theme.content.color_scheme" = if theme.isDark then 1 else 2;
      };
    };
  };

  stylix.targets.firefox = lib.mkIf cfg.enable {
    enable = true;
    profileNames = ["default"];
    colorTheme.enable = true;
  };
}
