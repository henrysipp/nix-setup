import Quickshell.Bluetooth
import QtQuick
import ".."

Item {
  id: root
  required property var device
  width: parent.width
  height: 28

  readonly property bool loading: device.state === BluetoothDeviceState.Connecting
    || device.state === BluetoothDeviceState.Disconnecting

  readonly property string deviceIcon: {
    switch (device.icon) {
    case "audio-headphones":
    case "audio-headset":
      return "󰋋"
    case "computer":
      return "󰌢"
    case "phone":
      return "󰄋"
    case "input-keyboard":
      return "󰌌"
    case "input-mouse":
      return "󰍽"
    default:
      return "󰂯"
    }
  }

  signal connectClicked()
  signal forgetClicked()

  Row {
    anchors.fill: parent
    spacing: 8

    Text {
      anchors.verticalCenter: parent.verticalCenter
      width: 16
      text: root.device.connected ? "󰄬" : root.deviceIcon
      color: root.device.connected ? Theme.accent : Theme.foreground
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
      horizontalAlignment: Text.AlignHCenter
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      width: parent.width - 88
      elide: Text.ElideRight
      text: root.loading ? `${device.name}…` : device.name
      color: root.device.connected ? Theme.accent : Theme.foreground
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      visible: root.device.batteryAvailable
      text: `${Math.round(root.device.battery * 100)}%`
      color: root.device.battery < 0.2 ? Theme.error : Theme.muted
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }

    Item {
      anchors.verticalCenter: parent.verticalCenter
      width: 28
      height: parent.height

      Text {
        anchors.centerIn: parent
        text: root.device.connected ? "󰌸" : "󰌺"
        color: root.loading ? Theme.muted : Theme.foreground
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize
      }

      MouseArea {
        anchors.fill: parent
        enabled: !root.loading
        cursorShape: Qt.PointingHandCursor
        onClicked: root.connectClicked()
      }
    }

    Item {
      anchors.verticalCenter: parent.verticalCenter
      visible: root.device.bonded
      width: 20
      height: parent.height

      Text {
        anchors.centerIn: parent
        text: "󰆴"
        color: Theme.muted
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.forgetClicked()
      }
    }
  }
}
