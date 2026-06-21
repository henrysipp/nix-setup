import Quickshell.Services.UPower
import QtQuick
import ".."

Item {
  id: root
  implicitHeight: content.implicitHeight

  property bool active: false
  property int capacity: -1
  property string chargeStatus: ""
  property string statusLabel: ""

  readonly property bool batteryReady: capacity >= 0 && chargeStatus.length > 0
  readonly property var profiles: {
    const list = [
      {
        profile: PowerProfile.PowerSaver,
        label: "Power saver",
        icon: "󱐋"
      },
      {
        profile: PowerProfile.Balanced,
        label: "Balanced",
        icon: "󰔵"
      }
    ]
    if (PowerProfiles.hasPerformanceProfile) {
      list.push({
        profile: PowerProfile.Performance,
        label: "Performance",
        icon: "󰓅"
      })
    }
    return list
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
        text: "Power"
        color: Theme.foreground
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize + 1
      }

      Text {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        text: root.batteryReady ? `${root.capacity}% · ${root.statusLabel}` : "Battery unavailable"
        color: Theme.muted
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize
      }
    }

    Text {
      width: parent.width
      visible: PowerProfiles.degradationReason !== PerformanceDegradationReason.None
      text: "Performance degraded: " + PerformanceDegradationReason.toString(PowerProfiles.degradationReason)
      color: Theme.accent
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
      wrapMode: Text.WordWrap
    }

    Column {
      width: parent.width
      spacing: 2

      Repeater {
        model: root.profiles
        delegate: PowerProfileRow {
          required property var modelData
          profile: modelData.profile
          label: modelData.label
          icon: modelData.icon
          onClicked: PowerProfiles.profile = modelData.profile
        }
      }
    }
  }
}
