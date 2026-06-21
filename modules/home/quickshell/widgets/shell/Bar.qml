import Quickshell.Services.SystemTray as TrayService
import QtQuick
import QtQuick.Layouts
import ".."

Item {
  id: barRoot

  readonly property int cloudInnerMargin: Theme.cloudAir + Theme.cloudPad

  Rectangle {
    id: cloudBg
    x: Theme.cloudAir
    y: Theme.cloudAir
    width: parent.width - 2 * Theme.cloudAir
    height: Theme.barHeight + 2 * Theme.cloudPad
    radius: Theme.barRadius
    color: Theme.barBackground
    z: 0
  }

  GridLayout {
    id: barGrid
    anchors.fill: parent
    anchors.leftMargin: cloudInnerMargin
    anchors.rightMargin: cloudInnerMargin
    anchors.topMargin: cloudInnerMargin + Theme.cloudPad
    anchors.bottomMargin: Theme.cloudInnerAir + Theme.cloudPad
    flow: GridLayout.LeftToRight
    rowSpacing: Theme.barGridSpacing
    columnSpacing: Theme.barGridSpacing
    columns: -1
    rows: 1

    Workspaces {}

    Item {
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    SystemTray {}

    BarDivider {
      visible: TrayService.SystemTray.items.count > 0
    }

    Item {
      Layout.preferredWidth: Theme.barModuleWidth
      Layout.preferredHeight: Theme.barHeight
      Layout.alignment: Qt.AlignVCenter
      BluetoothStatus { anchors.fill: parent }
    }

    Item {
      Layout.preferredWidth: Theme.barModuleWidth
      Layout.preferredHeight: Theme.barHeight
      Layout.alignment: Qt.AlignVCenter
      WifiStatus { anchors.fill: parent }
    }

    Item {
      Layout.preferredWidth: Theme.barModuleWidth
      Layout.preferredHeight: Theme.barHeight
      Layout.alignment: Qt.AlignVCenter
      VolumeStatus { anchors.fill: parent }
    }

    Item {
      Layout.preferredWidth: Theme.barModuleWidth
      Layout.preferredHeight: Theme.barHeight
      Layout.alignment: Qt.AlignVCenter
      PowerStatus { anchors.fill: parent }
    }
  }

  Clock {
    id: clockTimer
  }

  Item {
    id: clockItem
    anchors.horizontalCenter: cloudBg.horizontalCenter
    anchors.verticalCenter: cloudBg.verticalCenter
    z: 10
    implicitWidth: clockText.implicitWidth + 14
    implicitHeight: clockText.implicitHeight + 8

    Text {
      id: clockText
      anchors.centerIn: parent
      anchors.verticalCenterOffset: -1
      text: clockTimer.hh + ":" + clockTimer.mm
      color: Theme.foreground
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
      font.letterSpacing: 2
      font.weight: Font.Light
    }
  }
}
