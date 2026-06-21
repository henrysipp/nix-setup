//@ pragma UseQApplication

import Quickshell
import Quickshell.Wayland
import QtQuick
import "widgets"

Scope {
  Launcher {}
  Osd {}

  LazyLoader {
    id: popoutLoader

    readonly property bool closing: item && item.popoutClip.openProgress > 0.001 && !ShellState.hasCurrent
    active: ShellState.hasCurrent || closing

    PanelWindow {
      id: popoutWindow
      screen: ShellState.screen ?? Quickshell.screens[0]
      color: "transparent"
      exclusionMode: ExclusionMode.Ignore

      readonly property alias popoutClip: popoutClip

      readonly property real panelWidth: popoutClip.implicitWidth
      readonly property real screenWidth: screen?.width ?? panelWidth

      readonly property real popoutLeftMargin: {
        const w = panelWidth
        if (w <= 0)
          return 0
        if (!ShellState.hasCurrent || ShellState.currentCenter <= 0)
          return screenWidth - w - Theme.barPaddingRight
        const centered = ShellState.currentCenter - w / 2
        const minX = Theme.barPaddingLeft
        const maxX = screenWidth - w - Theme.barPaddingRight
        return Math.max(minX, Math.min(centered, maxX))
      }

      anchors {
        top: true
        left: true
      }
      margins {
        top: Theme.panelTopMargin
        left: popoutLeftMargin
      }
      implicitWidth: popoutClip.implicitWidth
      implicitHeight: popoutClip.implicitHeight

      WlrLayershell.namespace: "quickshell-bar-panel"
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      focusable: false

      PopoutClipWrapper {
        id: popoutClip
        anchors.right: parent.right
      }
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: barWindow
      required property var modelData

      screen: modelData
      color: "transparent"
      anchors {
        top: true
        left: true
        right: true
      }
      implicitHeight: Theme.barHeight + Theme.barExtraThickness
      exclusiveZone: Theme.barHeight + Theme.barExtraThickness
      focusable: false

      WlrLayershell.namespace: "quickshell-bar"
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

      Bar {
        anchors.fill: parent
      }
    }
  }
}
