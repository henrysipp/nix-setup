import Quickshell
import Quickshell.Bluetooth
import QtQuick
import ".."

Item {
  id: root

  height: Theme.barHeight
  width: Theme.barStatusHitWidth

  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property bool adapterReady: adapter !== null
  readonly property bool enabled: adapter?.enabled ?? false
  readonly property bool hasConnected: adapterReady
    && Bluetooth.devices.values.some(d => d.connected)

  readonly property color iconColor: {
    if (ShellState.currentName === "bluetooth")
      return Theme.accent
    if (!adapterReady || !enabled)
      return Theme.muted
    if (hasConnected)
      return Theme.accent
    return Theme.foreground
  }

  Text {
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -1
    text: {
      if (!adapterReady || !enabled)
        return "󰂲"
      if (hasConnected)
        return "󰂱"
      return "󰂯"
    }
    color: root.iconColor
    font.family: Theme.monoFont
    font.pixelSize: Theme.barStatusIconSize
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: ShellState.togglePopup("bluetooth", root)
  }
}
