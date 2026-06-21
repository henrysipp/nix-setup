import Quickshell
import Quickshell.Networking
import QtQuick
import ".."

Item {
  id: root
  height: Theme.barHeight
  width: Theme.barStatusHitWidth

  readonly property var icons: ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]
  readonly property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
  readonly property var wiredDevice: Networking.devices.values.find(d => d.type === DeviceType.Wired)
  readonly property var activeWifi: wifiDevice?.networks?.values?.find(n => n.connected)

  readonly property bool connected: (wiredDevice?.connected ?? false)
    || (Networking.wifiEnabled && (wifiDevice?.connected ?? false))

  readonly property color iconColor: {
    if (ShellState.currentName === "wifi")
      return Theme.accent
    if (connected)
      return Theme.accent
    if (!Networking.wifiEnabled)
      return Theme.muted
    return Theme.foreground
  }

  IconText {
    id: wifiIcon
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -1
    text: {
      if (wiredDevice?.connected ?? false)
        return "󰀂"
      if (!Networking.wifiEnabled || !(wifiDevice?.connected ?? false))
        return "󰤮"
      const strength = activeWifi?.signalStrength ?? 0
      const index = Math.min(4, Math.max(0, Math.round(strength * 4)))
      return icons[index]
    }
    color: root.iconColor
    font.pixelSize: Theme.barStatusIconSize
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: ShellState.togglePopup("wifi", root)
  }
}
