import Quickshell.Bluetooth
import QtQuick
import ".."

Item {
  id: root
  implicitHeight: content.implicitHeight

  property bool active: false

  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property bool available: adapter !== null
  readonly property bool enabled: adapter?.enabled ?? false

  readonly property var sortedDevices: {
    void Bluetooth.devices.count
    return [...Bluetooth.devices.values].sort((a, b) => {
      if (a.connected !== b.connected)
        return b.connected - a.connected
      if (a.paired !== b.paired)
        return b.paired - a.paired
      return a.name.localeCompare(b.name)
    })
  }

  onActiveChanged: {
    if (adapter && active && enabled)
      adapter.discovering = true
    if (!active && adapter)
      adapter.discovering = false
  }

  onEnabledChanged: {
    if (!enabled && adapter)
      adapter.discovering = false
  }

  Column {
    id: content
    width: parent.width
    spacing: 8

    Item {
      width: parent.width
      height: Theme.barHeight

      Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: "Bluetooth"
        color: Theme.foreground
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize + 1
      }

      Item {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: toggleLabel.implicitWidth
        height: parent.height

        Text {
          id: toggleLabel
          anchors.centerIn: parent
          text: root.enabled ? "On" : "Off"
          color: root.enabled ? Theme.accent : Theme.muted
          font.family: Theme.monoFont
          font.pixelSize: Theme.fontSize
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            if (adapter)
              adapter.enabled = !adapter.enabled
          }
        }
      }
    }

    Item {
      width: parent.width
      height: Theme.barHeight
      visible: root.available && root.enabled

      Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: "Discovering"
        color: Theme.foreground
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize
      }

      Item {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: discoverLabel.implicitWidth
        height: parent.height

        Text {
          id: discoverLabel
          anchors.centerIn: parent
          text: adapter?.discovering ? "On" : "Off"
          color: adapter?.discovering ? Theme.accent : Theme.muted
          font.family: Theme.monoFont
          font.pixelSize: Theme.fontSize
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            if (adapter)
              adapter.discovering = !adapter.discovering
          }
        }
      }
    }

    Text {
      width: parent.width
      visible: !root.available
      text: "No Bluetooth adapter found"
      color: Theme.muted
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }

    Text {
      width: parent.width
      visible: root.available && !root.enabled
      text: "Bluetooth is disabled"
      color: Theme.muted
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }

    Text {
      width: parent.width
      visible: root.available && root.enabled && adapter?.discovering && sortedDevices.length === 0
      text: "Scanning…"
      color: Theme.muted
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }

    Text {
      width: parent.width
      visible: root.available && root.enabled && !adapter?.discovering && sortedDevices.length === 0
      text: "No devices found"
      color: Theme.muted
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }

    Flickable {
      width: parent.width
      visible: root.available && root.enabled && sortedDevices.length > 0
      height: Math.min(deviceColumn.implicitHeight, Theme.panelMaxHeight)
      contentHeight: deviceColumn.implicitHeight
      clip: true

      Column {
        id: deviceColumn
        width: parent.width
        spacing: 2

        Repeater {
          model: root.sortedDevices
          delegate: BluetoothDeviceRow {
            required property var modelData
            device: modelData
            onConnectClicked: {
              if (modelData.connected)
                modelData.disconnect()
              else if (!modelData.paired)
                modelData.pair()
              else
                modelData.connect()
            }
            onForgetClicked: modelData.forget()
          }
        }
      }
    }
  }
}
