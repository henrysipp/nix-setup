import QtQuick
import ".."

Item {
  id: root

  readonly property alias content: content

  property real offsetScale: ShellState.hasCurrent ? 0 : 1

  readonly property real openProgress: 1 - offsetScale

  visible: width > 0 && height > 0
  clip: true

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight * openProgress
  width: implicitWidth
  height: implicitHeight

  PopoutWrapper {
    id: content
    offsetScale: root.offsetScale

    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: (-implicitHeight - Theme.barPanelGap) * offsetScale
  }

  Behavior on offsetScale {
    Anim {
      duration: content.animLength
      easing.type: Easing.BezierSpline
      easing.bezierCurve: content.animCurve
    }
  }
}
