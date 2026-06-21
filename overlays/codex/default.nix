{
  lib,
  stdenv,
  fetchurl,
}: let
  source = lib.importJSON ./sources.json;
in
  stdenv.mkDerivation {
    pname = "codex";
    inherit (source) version;

    src = fetchurl {
      inherit (source) url hash;
    };

    dontConfigure = true;
    dontBuild = true;

    unpackPhase = ''
      tar -xzf $src
    '';

    installPhase = ''
      install -Dm755 ${source.binary} $out/bin/codex
    '';

    passthru = {
      inherit source;
    };

    meta = with lib; {
      description = "OpenAI Codex CLI";
      homepage = "https://github.com/openai/codex";
      license = licenses.asl20;
      platforms = ["x86_64-linux"];
      mainProgram = "codex";
    };
  }
