{
  lib,
  stdenv,
  adwaita-icon-theme,
  hyprcursor,
  xcur2png,
}:
stdenv.mkDerivation {
  pname = "adwaita-hyprcursor";
  version = adwaita-icon-theme.version;

  dontUnpack = true;

  nativeBuildInputs = [
    hyprcursor
    xcur2png
  ];

  buildPhase = ''
    mkdir -p work/compiled

    hyprcursor-util --extract ${adwaita-icon-theme}/share/icons/Adwaita --output work
    sed -i 's/name = Extracted Theme/name = Adwaita/' work/extracted_Adwaita/manifest.hl
    hyprcursor-util --create work/extracted_Adwaita --output work/compiled

    mkdir -p $out/share/icons/Adwaita
    cp -r work/compiled/theme_Adwaita/* $out/share/icons/Adwaita/
    ln -s ${adwaita-icon-theme}/share/icons/Adwaita/cursors $out/share/icons/Adwaita/cursors
    cp ${adwaita-icon-theme}/share/icons/Adwaita/index.theme $out/share/icons/Adwaita/
  '';

  meta = {
    description = "Adwaita cursor theme in Hyprcursor format with XCursor fallback";
    homepage = "https://gitlab.gnome.org/GNOME/adwaita-icon-theme";
    license = lib.licenses.lgpl21Plus;
  };
}
