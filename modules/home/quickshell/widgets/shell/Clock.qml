import Quickshell
import Quickshell.Io
import QtQuick
import ".."

Scope {
  id: root

  property string hh: "--"
  property string mm: "--"

  Process {
    id: dateProc
    command: ["date", "+%H %M"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const parts = text.trim().split(/\s+/)
        if (parts.length >= 2) {
          root.hh = parts[0]
          root.mm = parts[1]
        }
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: dateProc.running = true
  }
}
