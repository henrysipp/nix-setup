import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import ".."

Scope {
  id: root

  property bool osdVisible: false
  property string mode: "volume"
  property real level: 0
  property bool muted: false
  property real lastBrightnessRatio: -1

  readonly property int osdWidth: 280
  readonly property int osdHeight: 40

  function show(kind) {
    mode = kind
    osdVisible = true
    hideTimer.restart()
  }

  function updateVolume() {
    const audio = Pipewire.defaultAudioSink?.audio
    muted = audio?.muted ?? false
    level = audio?.volume ?? 0
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  readonly property var audio: Pipewire.defaultAudioSink?.audio
  readonly property real watchVolume: audio?.volume ?? -1
  readonly property bool watchMuted: audio?.muted ?? false
  property bool volumeSynced: false
  property bool brightnessSynced: false
  property int maxBrightness: 1

  onWatchVolumeChanged: {
    if (watchVolume < 0)
      return
    if (!volumeSynced) {
      volumeSynced = true
      updateVolume()
      return
    }
    updateVolume()
    show("volume")
  }

  onWatchMutedChanged: {
    if (!volumeSynced)
      return
    updateVolume()
    show("volume")
  }

  function updateBrightness(current) {
    if (isNaN(current) || maxBrightness <= 0)
      return
    const ratio = current / maxBrightness
    if (brightnessSynced && Math.abs(ratio - lastBrightnessRatio) > 0.005) {
      level = ratio
      show("brightness")
    }
    if (!brightnessSynced)
      brightnessSynced = true
    lastBrightnessRatio = ratio
  }

  Process {
    id: backlightDiscovery
    command: ["sh", "-c", "p=$(ls -d /sys/class/backlight/*/brightness 2>/dev/null | head -1); [ -n \"$p\" ] && echo \"$p\" && cat \"${p%brightness}max_brightness\""]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const lines = text.trim().split("\n")
        if (lines.length < 2)
          return
        const max = parseInt(lines[1])
        if (isNaN(max) || max <= 0)
          return
        root.maxBrightness = max
        brightnessFile.path = lines[0]
      }
    }
  }

  FileView {
    id: brightnessFile
    path: ""
    watchChanges: true
    onFileChanged: reload()
    onLoaded: root.updateBrightness(parseInt(text().trim()))
  }

  Timer {
    id: hideTimer
    interval: 1500
    onTriggered: root.osdVisible = false
  }

  LazyLoader {
    active: root.osdVisible

    PanelWindow {
      screen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)

      color: "transparent"
      focusable: false
      exclusionMode: ExclusionMode.Ignore
      mask: Region {}

      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      WlrLayershell.namespace: "quickshell-osd"

      anchors.bottom: true
      margins.bottom: screen.height / 8
      margins.left: (screen.width - root.osdWidth) / 2

      implicitWidth: root.osdWidth
      implicitHeight: root.osdHeight

      Rectangle {
        anchors.fill: parent
        radius: 8
        color: Theme.background
        border.color: Theme.muted
        border.width: 1

        RowLayout {
          anchors.fill: parent
          anchors.margins: 10
          spacing: 10

          IconText {
            text: root.mode === "volume"
              ? (root.muted ? "󰝟" : "󰕾")
              : "󰃠"
            color: Theme.foreground
          }

          ProgressBar {
            Layout.fillWidth: true
            value: root.level
          }

          ShellText {
            text: Math.round(root.level * 100)
            variant: "body1"
            color: Theme.foreground
            Layout.preferredWidth: 28
            horizontalAlignment: Text.AlignRight
          }
        }
      }
    }
  }
}
