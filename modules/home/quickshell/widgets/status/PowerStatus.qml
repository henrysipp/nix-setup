import Quickshell
import Quickshell.Io
import QtQuick
import ".."

Item {
  id: root

  readonly property var defaultIcons: ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
  readonly property var chargingIcons: ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]

  property int capacity: -1
  property string chargeStatus: ""
  property string batteryPath: ""

  readonly property bool batteryReady: capacity >= 0 && chargeStatus.length > 0
  readonly property bool charging: chargeStatus === "Charging" || chargeStatus === "Full"
  readonly property bool batteryPresent: batteryPath.length > 0
  readonly property string statusLabel: {
    switch (chargeStatus) {
    case "Charging":
      return "Charging"
    case "Discharging":
      return "Discharging"
    case "Full":
      return "Fully charged"
    case "Not charging":
      return "Not charging"
    default:
      return chargeStatus.length > 0 ? chargeStatus : "Unknown"
    }
  }

  visible: batteryPresent
  height: Theme.barHeight
  width: Theme.barStatusHitWidth

  onCapacityChanged: syncBattery()
  onChargeStatusChanged: syncBattery()
  onStatusLabelChanged: syncBattery()
  onBatteryPresentChanged: syncBattery()

  function syncBattery() {
    ShellState.batteryCapacity = capacity
    ShellState.batteryChargeStatus = chargeStatus
    ShellState.batteryStatusLabel = statusLabel
    ShellState.batteryPresent = batteryPresent
  }

  readonly property color iconColor: {
    if (ShellState.currentName === "battery")
      return Theme.accent
    if (!batteryReady)
      return Theme.foreground
    if (charging || chargeStatus === "Full")
      return Theme.success
    if (capacity <= 10)
      return Theme.error
    if (capacity <= 20)
      return Theme.warning
    return Theme.foreground
  }

  Component.onCompleted: syncBattery()

  IconText {
    id: batteryIcon
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -1
    text: {
      if (!batteryReady)
        return "󰂄"

      if (chargeStatus === "Full")
        return "󰂅"

      const index = Math.min(9, Math.max(0, Math.floor(capacity / 10)))
      if (charging)
        return chargingIcons[index]
      return defaultIcons[index]
    }
    color: root.iconColor
    font.pixelSize: Theme.barStatusIconSize
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: ShellState.togglePopup("battery", root)
  }

  Process {
    command: ["sh", "-c", "for d in /sys/class/power_supply/BAT*; do [ -f \"$d/capacity\" ] && echo \"$d\" && break; done"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const path = text.trim()
        if (!path)
          return
        root.batteryPath = path
        capacityFile.path = `${path}/capacity`
        statusFile.path = `${path}/status`
      }
    }
  }

  FileView {
    id: capacityFile
    path: ""
    watchChanges: true
    onFileChanged: reload()
    onLoaded: {
      const value = parseInt(text().trim())
      if (!isNaN(value))
        root.capacity = value
    }
  }

  FileView {
    id: statusFile
    path: ""
    watchChanges: true
    onFileChanged: reload()
    onLoaded: root.chargeStatus = text().trim()
  }

  Timer {
    interval: 5000
    running: root.batteryPresent
    repeat: true
    onTriggered: {
      capacityFile.reload()
      statusFile.reload()
    }
  }
}
