import QtQuick
import ".."

Item {
  id: root

  required property real offsetScale

  readonly property int animLength: Theme.animDefaultSpatialDuration
  readonly property var animCurve: Theme.animSpatialCurve

  readonly property real nonAnimWidth: content.implicitWidth
  readonly property real nonAnimHeight: content.implicitHeight

  implicitWidth: nonAnimWidth
  implicitHeight: nonAnimHeight
  width: implicitWidth
  height: implicitHeight
  clip: true

  focus: ShellState.hasCurrent
  Keys.onEscapePressed: ShellState.closeAll()

  PopoutContent {
    id: content
    popouts: ShellState
    panelsLoaded: ShellState.hasCurrent || root.offsetScale < 1
  }
}
