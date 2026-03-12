{pkgs, ...}: {
  fonts.packages = with pkgs; [
    (pkgs.stdenv.mkDerivation {
      name = "berkeley-mono";
      src = ./berkeley-mono.zip;

      nativeBuildInputs = [pkgs.unzip];

      unpackPhase = ''
        unzip $src
      '';

      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        # The fonts are extracted to berkeley-mono/ subdirectory
        cp berkeley-mono/*.otf $out/share/fonts/opentype/
      '';

      meta = {
        description = "Berkeley Mono typeface family";
        longDescription = ''
          Berkeley Mono is a monospace typeface family with 20 fonts
          including Thin, ExtraLight, Light, SemiLight, Regular, Medium,
          SemiBold, Bold, ExtraBold, and Black weights, each with oblique variants.
        '';
      };
    })
  ];
}
