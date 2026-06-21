import QtQuick
import ".."

Item {
  id: root

  required property var popouts
  required property bool panelsLoaded

  readonly property var currentPopout: content.children.find(c => c.shouldBeActive) ?? null

  implicitWidth: (currentPopout?.implicitWidth ?? 0) + Theme.panelPadding * 2
  implicitHeight: (currentPopout?.implicitHeight ?? 0) + Theme.panelPadding * 2
  width: implicitWidth
  height: implicitHeight
  clip: true

  Rectangle {
    anchors.fill: parent
    radius: Theme.panelRadius
    color: Theme.background
    border.color: Qt.rgba(Theme.muted.r, Theme.muted.g, Theme.muted.b, 0.6)
    border.width: 1
  }

  Item {
    id: content

    anchors.fill: parent
    anchors.margins: Theme.panelPadding

    Popout {
      name: "wifi"
      sourceComponent: WifiPanel {
        width: Theme.panelWidth
        active: root.popouts.currentName === "wifi"
      }
    }

    Popout {
      name: "bluetooth"
      sourceComponent: BluetoothPanel {
        width: Theme.panelWidth
        active: root.popouts.currentName === "bluetooth"
      }
    }

    Popout {
      name: "volume"
      sourceComponent: VolumePanel {
        width: Theme.panelWidth
        active: root.popouts.currentName === "volume"
      }
    }

    Popout {
      name: "battery"
      sourceComponent: PowerPanel {
        width: Theme.panelWidth
        active: root.popouts.currentName === "battery"
        capacity: root.popouts.batteryCapacity
        chargeStatus: root.popouts.batteryChargeStatus
        statusLabel: root.popouts.batteryStatusLabel
      }
    }
  }

  component Popout: Loader {
    id: popout

    required property string name
    readonly property bool shouldBeActive: root.popouts.currentName === name
      && (name !== "battery" || root.popouts.batteryPresent)

    anchors.centerIn: parent

    active: root.panelsLoaded
      && (name !== "battery" || root.popouts.batteryPresent)
    opacity: shouldBeActive ? 1 : 0
    visible: opacity > 0

    Behavior on opacity {
      Anim {
        type: 1
        property: "opacity"
      }
    }
  }
}
