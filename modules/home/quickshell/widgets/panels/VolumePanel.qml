import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
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

      ShellText {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: "Sound"
        variant: "label"
        color: Theme.foreground
      }

      Item {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: muteLabel.implicitWidth
        height: parent.height

        ShellText {
          id: muteLabel
          anchors.centerIn: parent
          text: root.muted ? "Muted" : "On"
          variant: "body1"
          color: root.muted ? Theme.muted : Theme.accent
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

    RowLayout {
      width: parent.width
      spacing: 10

      ProgressBar {
        Layout.fillWidth: true
        value: root.volume
        interactive: true
        onSeeked: level => root.setVolume(level)
      }

      ShellText {
        Layout.preferredWidth: 28
        horizontalAlignment: Text.AlignRight
        text: Math.round(root.volume * 100)
        variant: "body1"
        color: Theme.foreground
      }
    }
  }
}
