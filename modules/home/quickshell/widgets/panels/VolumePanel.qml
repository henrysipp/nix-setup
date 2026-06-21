import Quickshell.Services.Pipewire
import QtQuick
import ".."

Item {
  id: root
  implicitHeight: content.implicitHeight

  property bool active: false

  readonly property var audioSink: Pipewire.defaultAudioSink
  readonly property var audio: audioSink?.audio
  readonly property real volume: audio?.volume ?? 0
  readonly property bool muted: audio?.muted ?? false

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  function setVolume(level) {
    if (!root.audio)
      return
    const clamped = Math.max(0, Math.min(1, level))
    root.audio.muted = false
    root.audio.volume = clamped
  }

  Column {
    id: content
    width: parent.width
    spacing: 10

    Item {
      width: parent.width
      height: Theme.barHeight

      Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: "Sound"
        color: Theme.foreground
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize + 1
      }

      Item {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: muteLabel.implicitWidth
        height: parent.height

        Text {
          id: muteLabel
          anchors.centerIn: parent
          text: root.muted ? "Muted" : "On"
          color: root.muted ? Theme.muted : Theme.accent
          font.family: Theme.monoFont
          font.pixelSize: Theme.fontSize
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            if (root.audio)
              root.audio.muted = !root.audio.muted
          }
        }
      }
    }

    Row {
      width: parent.width
      spacing: 10

      Item {
        width: parent.width - 36
        height: 24

        Rectangle {
          id: track
          anchors.verticalCenter: parent.verticalCenter
          width: parent.width
          height: 6
          radius: 3
          color: Theme.muted

          Rectangle {
            height: parent.height
            width: parent.width * Math.max(0, Math.min(1, root.volume))
            radius: parent.radius
            color: Theme.accent
          }
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onPressed: mouse => root.setVolume(mouse.x / track.width)
          onPositionChanged: mouse => {
            if (pressed)
              root.setVolume(mouse.x / track.width)
          }
        }
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter
        width: 28
        horizontalAlignment: Text.AlignRight
        text: Math.round(root.volume * 100)
        color: Theme.foreground
        font.family: Theme.monoFont
        font.pixelSize: Theme.fontSize
      }
    }
  }
}
