import Quickshell
import Quickshell.Widgets
import QtQuick
import ".."

Item {
  id: root
  required property var entry
  property bool highlighted: false

  signal clicked()

  readonly property string iconSource: Quickshell.iconPath(root.entry.icon, true)
  readonly property bool hasIcon: iconSource.length > 0

  width: ListView.view ? ListView.view.width : parent.width
  height: 32

  Rectangle {
    anchors.fill: parent
    radius: 4
    color: root.highlighted ? Qt.rgba(Theme.accent.r, Theme.accent.g, Theme.accent.b, 0.18) : "transparent"
  }

  Row {
    id: row
    anchors.fill: parent
    anchors.leftMargin: 8
    anchors.rightMargin: 8
    spacing: 8

    Item {
      width: Theme.launcherIconSize
      height: parent.height

      IconImage {
        anchors.centerIn: parent
        width: Theme.launcherIconSize
        height: Theme.launcherIconSize
        visible: root.hasIcon
        source: root.iconSource
        mipmap: true
      }
    }

    ShellText {
      width: Math.max(0, row.width - Theme.launcherIconSize - row.spacing)
      anchors.verticalCenter: parent.verticalCenter
      elide: Text.ElideRight
      text: root.entry.name
      variant: "body1"
      color: root.highlighted ? Theme.accent : Theme.foreground
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}
