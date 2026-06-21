import Quickshell.Networking
import QtQuick
import ".."

Item {
  id: root
  required property var network
  width: parent.width
  height: 28

  readonly property var signalIcons: ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]

  readonly property bool needsPassword: {
    if (network.known || network.security === WifiSecurityType.Open)
      return false
    return network.security === WifiSecurityType.WpaPsk
      || network.security === WifiSecurityType.Wpa2Psk
      || network.security === WifiSecurityType.Sae
  }

  readonly property int signalIndex: {
    const strength = network.signalStrength ?? 0
    return Math.min(4, Math.max(0, Math.round(strength * 4)))
  }

  signal clicked()

  Row {
    anchors.fill: parent
    spacing: 8

    IconText {
      anchors.verticalCenter: parent.verticalCenter
      width: 16
      text: root.network.connected ? "󰄬" : (root.needsPassword ? "󰌾" : root.signalIcons[root.signalIndex])
      color: root.network.connected ? Theme.accent : Theme.foreground
      horizontalAlignment: Text.AlignHCenter
    }

    ShellText {
      anchors.verticalCenter: parent.verticalCenter
      width: parent.width - 52
      elide: Text.ElideRight
      text: root.network.name
      variant: root.network.connected ? "body1Emphasized" : "body1"
      color: root.network.connected ? Theme.accent : Theme.foreground
    }

    IconText {
      anchors.verticalCenter: parent.verticalCenter
      visible: !root.network.connected
      text: root.signalIcons[root.signalIndex]
      color: Theme.muted
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}
