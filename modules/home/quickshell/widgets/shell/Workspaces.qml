import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import ".."

Row {
  id: root

  spacing: Theme.barGridSpacing
  Layout.alignment: Qt.AlignVCenter

  readonly property var labels: ["一", "二", "三", "四", "五"]

  function focusWorkspace(id) {
    const ws = Hyprland.workspaces.values.find(w => w.id === id)
    if (ws) {
      ws.activate()
      return
    }
    if (Hyprland.usingLua)
      Hyprland.dispatch(`hl.dsp.focus({ workspace = "${id}" })`)
    else
      Hyprland.dispatch("workspace " + id)
  }

  Repeater {
    model: 5
    delegate: Item {
      required property int index

      width: 20
      height: Theme.barHeight

      property int workspaceId: index + 1
      property var workspace: Hyprland.workspaces.values.find(w => w.id === workspaceId)
      property bool isActive: Hyprland.focusedWorkspace?.id === workspaceId
      property bool present: !!workspace

      Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -1
        text: root.labels[index]
        color: isActive ? Theme.accent : (present ? Theme.foreground : Theme.muted)
        opacity: isActive ? 1 : (present ? 0.75 : 0.35)
        font.family: Theme.cjkFont
        font.pixelSize: isActive ? 14 : 12
        font.weight: Font.Light
        Behavior on color { ColorAnimation { duration: 120 } }
        Behavior on opacity { NumberAnimation { duration: 120 } }
        Behavior on font.pixelSize { NumberAnimation { duration: 120 } }
      }

      MouseArea {
        z: 1
        anchors.fill: parent
        anchors.margins: -2
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.focusWorkspace(workspaceId)
      }
    }
  }
}
