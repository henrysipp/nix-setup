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

      ShellText {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: "Wi-Fi"
        variant: "label"
        color: Theme.foreground
      }

      Item {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: toggleLabel.implicitWidth
        height: parent.height

        ShellText {
          id: toggleLabel
          anchors.centerIn: parent
          text: Networking.wifiEnabled ? "On" : "Off"
          variant: "body1"
          color: Networking.wifiEnabled ? Theme.accent : Theme.muted
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: Networking.wifiEnabled = !Networking.wifiEnabled
        }
      }
    }

    ShellText {
      width: parent.width
      visible: wiredDevice?.connected ?? false
      text: "Ethernet connected"
      variant: "body1"
      color: Theme.foreground
      wrapMode: Text.WordWrap
    }

    ShellText {
      width: parent.width
      visible: !(wiredDevice?.connected ?? false) && !Networking.wifiEnabled
      text: "Wi-Fi is disabled"
      variant: "body1"
      color: Theme.muted
    }

    ShellText {
      width: parent.width
      visible: !(wiredDevice?.connected ?? false) && Networking.wifiEnabled && (wifiDevice?.scannerEnabled ?? false) && sortedNetworks.length === 0
      text: "Scanning…"
      variant: "body1"
      color: Theme.muted
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

      ShellText {
        width: parent.width
        text: "Password for " + (passwordNetwork?.name ?? "")
        variant: "body1"
        color: Theme.foreground
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

          ShellTextInput {
            id: passwordInput
            anchors.fill: parent
            anchors.margins: 6
            text: root.password
            echoMode: TextInput.Password
            variant: "body1"
            color: Theme.foreground
            onTextChanged: root.password = text
            Keys.onReturnPressed: root.submitPassword()
          }
        }

        Item {
          width: 56
          height: 28

          ShellText {
            anchors.centerIn: parent
            text: "Join"
            variant: "body1Emphasized"
            color: Theme.accent
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
