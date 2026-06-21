import QtQuick

Item {
  id: root

  property real value: 0
  property bool interactive: false

  signal seeked(real value)

  implicitHeight: interactive ? Math.max(Theme.progressHeight, 24) : Theme.progressHeight

  Rectangle {
    id: track

    anchors.verticalCenter: parent.verticalCenter
    width: parent.width
    height: Theme.progressHeight
    radius: height / 2
    color: Theme.progressTrack

    Rectangle {
      height: parent.height
      width: parent.width * Math.max(0, Math.min(1, root.value))
      radius: parent.radius
      color: Theme.progressFill
    }
  }

  MouseArea {
    anchors.fill: parent
    enabled: root.interactive
    cursorShape: Qt.PointingHandCursor
    onPressed: mouse => root.seeked(mouse.x / track.width)
    onPositionChanged: mouse => {
      if (pressed)
        root.seeked(mouse.x / track.width)
    }
  }
}
