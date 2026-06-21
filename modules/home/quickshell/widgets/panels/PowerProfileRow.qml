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

    Text {
      anchors.verticalCenter: parent.verticalCenter
      width: 16
      text: root.selected ? "󰄬" : root.icon
      color: root.selected ? Theme.accent : Theme.foreground
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
      horizontalAlignment: Text.AlignHCenter
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      width: parent.width - 24
      elide: Text.ElideRight
      text: root.label
      color: root.selected ? Theme.accent : Theme.foreground
      font.family: Theme.monoFont
      font.pixelSize: Theme.fontSize
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}
