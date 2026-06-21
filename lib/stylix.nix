# Canonical Stylix theme: switch `theme` to change colors and wallpapers.
{lib}: let
  wallpapersRoot = ../home/henrysipp/files/Pictures/Wallpapers;

  imageExtensions = [".png" ".jpg" ".jpeg" ".webp"];

  isImage = name:
    lib.any (ext: lib.hasSuffix ext name) imageExtensions;

  themes = {
    one-light = {
      scheme = "one-light";
      polarity = "light";
    };

    tokyo-night = {
      scheme = "tokyo-night-dark";
      polarity = "dark";
    };

    catppuccin-macchiato = {
      scheme = "catppuccin-macchiato";
      polarity = "dark";
    };
  };

  themeIds = lib.attrNames themes;

  # Switch themes here.
  theme = "tokyo-night";

  active = themes.${theme};
  wallpaperDir = "${wallpapersRoot}/${theme}";

  resolveWallpaper = dir: let
    entries = builtins.readDir dir;
    images = lib.sort (a: b: a < b) (lib.filter isImage (lib.attrNames entries));
  in
    if images == []
    then null
    else {
      name = lib.head images;
      path = "${dir}/${lib.head images}";
    };

  wallpaper = resolveWallpaper wallpaperDir;
in {
  inherit theme themeIds wallpaper wallpaperDir;

  scheme = active.scheme;
  polarity = active.polarity;

  schemePath = pkgs: "${pkgs.base16-schemes}/share/themes/${active.scheme}.yaml";

  mkTheme = {
    colors,
    polarity ? active.polarity,
  }: {
    inherit colors polarity;
    isDark = polarity == "dark";
  };
}
