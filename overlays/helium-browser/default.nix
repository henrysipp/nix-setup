{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
}: let
  pname = "helium-browser";
  sourcesJson = lib.importJSON ./sources.json;
  inherit (stdenv) hostPlatform;
  sourceInfo = sourcesJson.sources.${hostPlatform.system} or (throw "Unsupported system: ${hostPlatform.system}");
  inherit (sourcesJson) version;

  src = fetchurl {
    inherit (sourceInfo) url hash;
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      for desktop in ${appimageContents}/*.desktop ${appimageContents}/usr/share/applications/*.desktop; do
        if [ -f "$desktop" ]; then
          install -m 444 -D "$desktop" $out/share/applications/${pname}.desktop
          substituteInPlace $out/share/applications/${pname}.desktop \
            --replace 'Exec=helium' 'Exec=${pname}'
          break
        fi
      done

      if [ -d ${appimageContents}/usr/share/icons ]; then
        cp -r ${appimageContents}/usr/share/icons $out/share
      fi
    '';

    passthru.updateScript = ./update.sh;

    meta = with lib; {
      description = "Helium Browser — a privacy-focused Chromium fork";
      homepage = "https://helium.computer/";
      changelog = "https://github.com/imputnet/helium-linux/releases";
      license = licenses.gpl3Only;
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      platforms = builtins.attrNames sourcesJson.sources;
      mainProgram = pname;
    };
  }
