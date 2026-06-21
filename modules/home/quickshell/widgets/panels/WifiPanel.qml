import Quickshell.Networking
import QtQuick
import ".."

Item {
  id: root
  implicitHeight: content.implicitHeight

  property bool active: false

  readonly property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
  readonly property var wiredDevice: Networking.devices.values.find(d => d.type === DeviceType.Wired)
  readonly property var activeWifi: wifiDevice?.networks?.values?.find(n => n.connected)

  readonly property var sortedNetworks: {
    if (!wifiDevice || wiredDevice?.connected || !Networking.wifiEnabled)
      return []
    void wifiDevice.networks.count
    return [...wifiDevice.networks.values].sort((a, b) => {
      if (a.connected !== b.connected)
        return b.connected - a.connected
      return b.signalStrength - a.signalStrength
    })
  }

  property var passwordNetwork: null
  property string password: ""

  onActiveChanged: {
    if (wifiDevice)
      wifiDevice.scannerEnabled = active
    if (!active) {
      passwordNetwork = null
      password = ""
    }
  }

  function connectTo(network) {
    if (network.connected || network.stateChanging)
      return

    if (network.known || network.security === WifiSecurityType.Open) {
      passwordNetwork = null
      network.connect()
      return
    }

    if (network.security === WifiSecurityType.WpaPsk
      || network.security === WifiSecurityType.Wpa2Psk
      || network.security === WifiSecurityType.Sae) {
      passwordNetwork = network
      password = ""
      return
    }

    network.connect()
  }

  function submitPassword() {
    if (!passwordNetwork || password.length === 0)
      return
    passwordNetwork.connectWithPsk(password)
    passwordNetwork = null
    password = ""
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
        text: "Wi-Fi"
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
          text: Networking.wifiEnabled ? "On" : "Off"
          color: Networking.wifiEnabled ? Theme.accent : Theme.muted
          font.family: Theme.monoFont
          font.pixelSize: Theme.fontSize
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: Networking.wifiEnabled = !Networking.wifiEnabled
        }
      }
    }

    Text {
      width: parent.width
      visible: wiredDevice?.connected ?? false
      text: "Ethernet connected"
      color: Theme.foreground
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
      wrapMode: Text.WordWrap
    }

    Text {
      width: parent.width
      visible: !(wiredDevice?.connected ?? false) && !Networking.wifiEnabled
      text: "Wi-Fi is disabled"
      color: Theme.muted
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }

    Text {
      width: parent.width
      visible: !(wiredDevice?.connected ?? false) && Networking.wifiEnabled && (wifiDevice?.scannerEnabled ?? false) && sortedNetworks.length === 0
      text: "Scanning…"
      color: Theme.muted
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }

    Flickable {
      width: parent.width
      visible: !(wiredDevice?.connected ?? false) && Networking.wifiEnabled && sortedNetworks.length > 0
      height: Math.min(networkColumn.implicitHeight, Theme.panelMaxHeight)
      contentHeight: networkColumn.implicitHeight
      clip: true

      Column {
        id: networkColumn
        width: parent.width
        spacing: 2

        Repeater {
          model: root.sortedNetworks
          delegate: WifiNetworkRow {
            required property var modelData
            network: modelData
            onClicked: root.connectTo(modelData)
          }
        }
      }
    }

    Column {
      width: parent.width
      visible: passwordNetwork !== null
      spacing: 6

      Text {
        width: parent.width
        text: "Password for " + (passwordNetwork?.name ?? "")
        color: Theme.foreground
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize
        elide: Text.ElideRight
      }

      Row {
        width: parent.width
        spacing: 8

        Rectangle {
          width: parent.width - 64
          height: 28
          radius: 4
          color: Theme.muted

          TextInput {
            id: passwordInput
            anchors.fill: parent
            anchors.margins: 6
            text: root.password
            echoMode: TextInput.Password
            color: Theme.foreground
            font.family: Theme.monoFont
            font.pixelSize: Theme.fontSize
            selectionColor: Theme.accent
            onTextChanged: root.password = text
            Keys.onReturnPressed: root.submitPassword()
          }
        }

        Item {
          width: 56
          height: 28

          Text {
            anchors.centerIn: parent
            text: "Join"
            color: Theme.accent
            font.family: Theme.monoFont
            font.pixelSize: Theme.fontSize
          }

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.submitPassword()
          }
        }
      }
    }
  }

  onPasswordNetworkChanged: if (passwordNetwork)
    passwordInput.forceActiveFocus()
}
