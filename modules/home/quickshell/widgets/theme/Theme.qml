pragma Singleton

import QtQuick

QtObject {
  readonly property color background: "#1a1b26"
  readonly property color barBackground: Qt.rgba(0.102, 0.106, 0.149, 0.94)
  readonly property color foreground: "#a9b1d6"
  readonly property color accent: "#7aa2f7"
  readonly property color muted: "#444b6a"
  readonly property color success: "#9ece6a"
  readonly property color warning: "#e0af68"
  readonly property color error: "#f7768e"
  readonly property string monoFont: "JetBrainsMono Nerd Font"
  readonly property string cjkFont: "Noto Sans Mono CJK JP"
  readonly property int fontSize: 12
  readonly property int barHeight: 26
  readonly property int barRadius: 6
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
  readonly property int barStatusIconSize: 12
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

  // Material-style expressive motion (approximates caelestia spatial/effects curves)
  readonly property int animDefaultSpatialDuration: 350
  readonly property int animSlowSpatialDuration: 500
  readonly property int animDefaultEffectsDuration: 200
  readonly property int animSlowEffectsDuration: 300
  readonly property list<real> animSpatialCurve: [0.38, 1.21, 0.22, 1.0]
  readonly property list<real> animEffectsCurve: [0.27, 1.06, 0.22, 1.0]
}
