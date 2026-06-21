import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import ".."

Item {
  id: root
  height: Theme.barHeight
  width: Theme.barStatusHitWidth

  readonly property var icons: ["󰕿", "󰖀", "󰕾"]
  readonly property var audioSink: Pipewire.defaultAudioSink
  readonly property bool muted: audioSink?.audio?.muted ?? false

  readonly property color iconColor: {
    if (ShellState.currentName === "volume")
      return Theme.accent
    if (muted)
      return Theme.warning
    return Theme.foreground
  }

  IconText {
    id: volumeIcon
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -1
    text: {
      if (!audioSink?.audio)
        return "󰕿"
      if (audioSink.audio.muted)
        return "󰝟"
      const volume = audioSink.audio.volume ?? 0
      if (volume <= 0.33)
        return icons[0]
      if (volume <= 0.66)
        return icons[1]
      return icons[2]
    }
    color: root.iconColor
    font.pixelSize: Theme.barStatusIconSize
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: ShellState.togglePopup("volume", root)
  }
}
