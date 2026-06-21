# This file defines overlays
{inputs, ...}: {
  overlay-codex = _final: prev: {
    codex = prev.callPackage ./codex {};
  };

  overlay-cursor = _final: prev: {
    code-cursor = prev.callPackage ./code-cursor {
      inherit (prev) buildVscode;
    };
  };

  overlay-adwaita-hyprcursor = final: prev: {
    adwaita-hyprcursor = final.callPackage ./adwaita-hyprcursor {};
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
  overlay-unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
