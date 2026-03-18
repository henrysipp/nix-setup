# This file defines overlays
{inputs, ...}: {
  codex = _final: prev: let
    mkCodex = {version, sha256}: let
      binary = "codex-x86_64-unknown-linux-musl";
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/${binary}.tar.gz";
    in
      prev.stdenv.mkDerivation {
        pname = "codex";
        inherit version;

        src = prev.fetchurl {
          inherit url;
          hash = sha256;
        };

        dontConfigure = true;
        dontBuild = true;

        unpackPhase = ''
          tar -xzf $src
        '';

        installPhase = ''
          install -Dm755 ${binary} $out/bin/codex
        '';

        meta = with prev.lib; {
          description = "OpenAI Codex CLI";
          homepage = "https://github.com/openai/codex";
          license = licenses.apache2;
          platforms = ["x86_64-linux"];
        };
      };
  in {
    codexFromRelease = mkCodex;
    codex = mkCodex {
      version = "0.115.0";
      sha256 = "sha256-/HedTrMZksLYDnboSHUGMxmVnxrNepBECZh3bzK83QA=";
    };
  };

  # This one brings our custom packages from the 'pkgs' directory
  #   additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  #   modifications = final: prev: {
  #     # example = prev.example.overrideAttrs (oldAttrs: rec {
  #     # ...
  #     # });
  #   };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
