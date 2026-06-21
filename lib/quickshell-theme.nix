# Generate quickshell Theme.qml from Stylix base16 colors.
{
  colors,
  typography,
}: let
  tag = colors.withHashtag;
  fontSizeBase = typography.fontSizeBase;
in ''
  pragma Singleton

  import QtQuick

  QtObject {
    readonly property color background: "${tag.base00}"
    readonly property color surface: "${tag.base02}"
    readonly property color barBackground: Qt.rgba(${colors."base00-dec-r"}, ${colors."base00-dec-g"}, ${colors."base00-dec-b"}, 0.94)
    readonly property color foreground: "${tag.base05}"
    readonly property color accent: "${tag.base0D}"
    readonly property color muted: "${tag.base03}"
    readonly property color success: "${tag.base0B}"
    readonly property color warning: "${tag.base0A}"
    readonly property color error: "${tag.base08}"
    readonly property color progressTrack: Qt.rgba(${colors."base05-dec-r"}, ${colors."base05-dec-g"}, ${colors."base05-dec-b"}, 0.26)
    readonly property color progressFill: "${tag.base0D}"
    readonly property int progressHeight: 6
    readonly property string font: "Inter Variable"
    readonly property string iconFont: "JetBrainsMono Nerd Font"
    readonly property int barHeight: 26
    readonly property int barRadius: 0
    readonly property int cloudPad: 2
    readonly property int cloudAir: 5
    readonly property int cloudInnerAir: 2
    readonly property int barExtraThickness: 2 * cloudPad + cloudAir + cloudInnerAir
    readonly property int barPillBottom: cloudAir + barHeight + 2 * cloudPad
    readonly property int panelTopMargin: barPillBottom + barPanelGap
    readonly property int barCloudMargin: cloudAir + cloudPad
    readonly property int barPaddingLeft: barCloudMargin
    readonly property int barPaddingRight: barCloudMargin
    readonly property int barPanelGap: 2
    readonly property int barStatusIconSize: ${toString fontSizeBase}
    readonly property int barStatusHitWidth: 24
    readonly property int barModuleWidth: 24
    readonly property int barGridSpacing: 4
    readonly property int barSeparatorExtent: 12
    readonly property color barDivider: Qt.rgba(foreground.r, foreground.g, foreground.b, 0.18)
    readonly property int trayItemSpacing: 4
    readonly property int trayIconSize: 14
    readonly property int panelWidth: 300
    readonly property int panelRadius: 14
    readonly property int panelPadding: 14
    readonly property int panelMaxHeight: 280
    readonly property int launcherWidth: 420
    readonly property int launcherMaxHeight: 320
    readonly property int launcherIconSize: 18

    readonly property int animDefaultSpatialDuration: 350
    readonly property int animSlowSpatialDuration: 500
    readonly property int animDefaultEffectsDuration: 200
    readonly property int animSlowEffectsDuration: 300
    readonly property list<real> animSpatialCurve: [0.38, 1.21, 0.22, 1.0]
    readonly property list<real> animEffectsCurve: [0.27, 1.06, 0.22, 1.0]
  }
''
