{
  lib,
  stdenv,
  buildVscode,
  fetchurl,
  appimageTools,
  undmg,
  commandLineArgs ? "",
  useVSCodeRipgrep ? stdenv.hostPlatform.isDarwin,
}: let
  inherit (stdenv) hostPlatform;
  finalCommandLineArgs = "--update=false " + commandLineArgs;

  sourcesJson = lib.importJSON ./sources.json;
  sources =
    lib.mapAttrs (
      _: info:
        fetchurl {
          inherit (info) url hash;
        }
    )
    sourcesJson.sources;

  source = sources.${hostPlatform.system};
in
  (buildVscode rec {
    inherit useVSCodeRipgrep;
    inherit (sourcesJson) version vscodeVersion;
    commandLineArgs = finalCommandLineArgs;

    pname = "cursor";

    executableName = "cursor";
    longName = "Cursor";
    shortName = "cursor";
    libraryName = "cursor";
    iconName = "cursor";

    src =
      if hostPlatform.isLinux
      then
        appimageTools.extract {
          inherit pname version;
          src = source;
        }
      else source;

    sourceRoot =
      if hostPlatform.isLinux
      then "${pname}-${version}-extracted/usr/share/cursor"
      else "Cursor.app";

    tests = {};

    updateScript = ./update.sh;

    dontFixup = stdenv.hostPlatform.isDarwin;
    patchVSCodePath = false;

    meta = {
      description = "AI-powered code editor built on vscode";
      homepage = "https://cursor.com";
      changelog = "https://cursor.com/changelog";
      license = lib.licenses.unfree;
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      maintainers = with lib.maintainers; [
        aspauldingcode
        prince213
        qweered
      ];
      platforms = [
        "x86_64-linux"
      ];
      mainProgram = "cursor";
    };
  }).overrideAttrs (oldAttrs: {
    nativeBuildInputs =
      (oldAttrs.nativeBuildInputs or []) ++ lib.optionals hostPlatform.isDarwin [undmg];

    autoPatchelfIgnoreMissingDeps =
      (oldAttrs.autoPatchelfIgnoreMissingDeps or [])
      ++ lib.optionals (stdenv.hostPlatform.isLinux && !stdenv.hostPlatform.isMusl) [
        "libc.musl-*.so.*"
      ];

    passthru =
      (oldAttrs.passthru or {})
      // {
        inherit sources;
      };
  })
