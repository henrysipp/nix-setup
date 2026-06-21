# Typography tokens and semantic text styles for quickshell QML.
lib: let
  fontSizeTokens = {
    sm = 11;
    base = 12;
    lg = 13;
    "2xl" = 14;
    "3xl" = 16;
    "4xl" = 18;
  };

  fontWeightTokens = {
    normal = "Font.Normal";
    bold = "Font.Bold";
  };

  textStyles = {
    headline1 = {
      fontSize = "4xl";
      fontWeight = "bold";
      lineHeight = 1.2;
    };
    headline2 = {
      fontSize = "3xl";
      fontWeight = "bold";
      lineHeight = 1.25;
    };
    title = {
      fontSize = "2xl";
      fontWeight = "normal";
      lineHeight = 1.25;
    };
    titleEmphasized = {
      fontSize = "2xl";
      fontWeight = "bold";
      lineHeight = 1.25;
    };
    label = {
      fontSize = "lg";
      fontWeight = "normal";
      lineHeight = 1.25;
    };
    labelEmphasized = {
      fontSize = "lg";
      fontWeight = "bold";
      lineHeight = 1.25;
    };
    body1 = {
      fontSize = "base";
      fontWeight = "normal";
      lineHeight = 1.25;
    };
    body1Emphasized = {
      fontSize = "base";
      fontWeight = "bold";
      lineHeight = 1.25;
    };
    body2 = {
      fontSize = "sm";
      fontWeight = "normal";
      lineHeight = 1.25;
    };
    body2Emphasized = {
      fontSize = "sm";
      fontWeight = "bold";
      lineHeight = 1.25;
    };
  };

  inherit (fontSizeTokens) sm base lg;
  fontSize2xl = fontSizeTokens."2xl";
  fontSize3xl = fontSizeTokens."3xl";
  fontSize4xl = fontSizeTokens."4xl";

  resolveSize = token: fontSizeTokens.${token};
  resolveWeight = token: fontWeightTokens.${token};

  styleCase = name: style: ''
    case "${name}":
      return {
        pixelSize: ${toString (resolveSize style.fontSize)},
        weight: ${resolveWeight style.fontWeight},
        lineHeight: ${toString style.lineHeight},
      }
  '';

  styleProperty = name: style: let
    px = resolveSize style.fontSize;
    wt = resolveWeight style.fontWeight;
  in ''
    readonly property int ${name}FontSize: ${toString px}
    readonly property int ${name}FontWeight: ${wt}
    readonly property real ${name}LineHeight: ${toString style.lineHeight}
  '';
in {
  inherit fontSizeTokens fontWeightTokens textStyles;
  fontSizeBase = fontSizeTokens.base;

  qml = ''
    pragma Singleton

    import QtQuick

    QtObject {
      readonly property int fontSizeSm: ${toString sm}
      readonly property int fontSizeBase: ${toString base}
      readonly property int fontSizeLg: ${toString lg}
      readonly property int fontSize2xl: ${toString fontSize2xl}
      readonly property int fontSize3xl: ${toString fontSize3xl}
      readonly property int fontSize4xl: ${toString fontSize4xl}

      readonly property int fontWeightNormal: Font.Normal
      readonly property int fontWeightBold: Font.Bold

      ${lib.concatMapStringsSep "\n\n      " (name: styleProperty name textStyles.${name}) (lib.attrNames textStyles)}

      function fontSize(token) {
        switch (token) {
        case "sm": return fontSizeSm
        case "base": return fontSizeBase
        case "lg": return fontSizeLg
        case "2xl": return fontSize2xl
        case "3xl": return fontSize3xl
        case "4xl": return fontSize4xl
        default: return fontSizeBase
        }
      }

      function fontWeight(token) {
        switch (token) {
        case "normal": return fontWeightNormal
        case "bold": return fontWeightBold
        default: return fontWeightNormal
        }
      }

      function style(name) {
        switch (name) {
        ${lib.concatMapStringsSep "\n        " (name: styleCase name textStyles.${name}) (lib.attrNames textStyles)}
        default:
          return style("body1")
        }
      }
    }
  '';
}
