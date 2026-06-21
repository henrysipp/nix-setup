import Quickshell.Services.UPower
import QtQuick
import ".."

Item {
  id: root
  required property int profile
  required property string label
  required property string icon

  width: parent.width
  height: 28

  readonly property bool selected: PowerProfiles.profile === profile

  signal clicked()

  Row {
    anchors.fill: parent
    spacing: 8

    IconText {
      anchors.verticalCenter: parent.verticalCenter
      width: 16
      text: root.selected ? "󰄬" : root.icon
      color: root.selected ? Theme.accent : Theme.foreground
      horizontalAlignment: Text.AlignHCenter
    }

    ShellText {
      anchors.verticalCenter: parent.verticalCenter
      width: parent.width - 24
      elide: Text.ElideRight
      text: root.label
      variant: root.selected ? "body1Emphasized" : "body1"
      color: root.selected ? Theme.accent : Theme.foreground
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}
