import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import ".."

Scope {
  id: root

  property bool open: false
  property string searchText: ""
  property int selectedIndex: 0

  readonly property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)
    ?? Quickshell.screens[0]

  readonly property var filteredEntries: {
    const query = searchText.trim().toLowerCase()
    void DesktopEntries.applications.count
    const entries = [...DesktopEntries.applications.values]
    const filtered = query.length === 0
      ? entries
      : entries.filter(entry => matchesQuery(entry, query))
    return filtered.sort((a, b) => a.name.localeCompare(b.name)).slice(0, 50)
  }

  function matchesQuery(entry, query) {
    if (entry.name.toLowerCase().includes(query))
      return true
    if (entry.comment && entry.comment.toLowerCase().includes(query))
      return true
    for (const keyword of entry.keywords) {
      if (keyword.toLowerCase().includes(query))
        return true
    }
    return false
  }

  function launch(entry) {
    if (!entry)
      return
    entry.execute()
    root.open = false
  }

  function launchCurrent() {
    if (selectedIndex < 0 || selectedIndex >= filteredEntries.length)
      return
    launch(filteredEntries[selectedIndex])
  }

  onOpenChanged: {
    if (open) {
      searchText = ""
      selectedIndex = 0
    }
  }

  onSearchTextChanged: selectedIndex = 0

  IpcHandler {
    target: "launcher"
    function toggle(): void {
      root.open = !root.open
    }
  }

  GlobalShortcut {
    name: "launcher"
    description: "Toggle app launcher"
    onPressed: root.open = !root.open
  }

  LazyLoader {
    id: launcherLoader
    active: root.open

    PanelWindow {
      id: launcherWindow
      screen: root.focusedScreen
      color: "transparent"
      focusable: true
      exclusionMode: ExclusionMode.Ignore

      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
      WlrLayershell.namespace: "quickshell-launcher"

      Component.onCompleted: searchInput.forceActiveFocus()

      anchors {
        top: true
        bottom: true
        left: true
        right: true
      }

      HyprlandFocusGrab {
        active: root.open
        windows: [launcherWindow]
        onCleared: root.open = false
      }

      Rectangle {
        anchors.fill: parent
        color: "#66000000"

        MouseArea {
          anchors.fill: parent
          onClicked: root.open = false
        }
      }

      Rectangle {
        id: panel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.12
        width: Theme.launcherWidth
        implicitHeight: panelContent.implicitHeight + 24
        radius: Theme.panelRadius
        color: Theme.background
        border.color: Qt.rgba(Theme.muted.r, Theme.muted.g, Theme.muted.b, 0.6)
        border.width: 1

        MouseArea {
          anchors.fill: parent
          onClicked: mouse => mouse.accepted = true
        }

        Column {
          id: panelContent
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          anchors.margins: 12
          spacing: 8

          Rectangle {
            width: parent.width
            height: 32
            radius: 6
            color: Theme.muted

            ShellTextInput {
              id: searchInput
              anchors.fill: parent
              anchors.margins: 8
              focus: true
              text: root.searchText
              variant: "body1"
              color: Theme.foreground
              clip: true
              onTextChanged: root.searchText = text

              Keys.onPressed: event => {
                if (event.key === Qt.Key_Down) {
                  root.selectedIndex = Math.min(root.selectedIndex + 1, root.filteredEntries.length - 1)
                  event.accepted = true
                } else if (event.key === Qt.Key_Up) {
                  root.selectedIndex = Math.max(root.selectedIndex - 1, 0)
                  event.accepted = true
                } else if (event.key === Qt.Key_Escape) {
                  root.open = false
                  event.accepted = true
                } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                  root.launchCurrent()
                  event.accepted = true
                }
              }
            }
          }

          ShellText {
            width: parent.width
            visible: filteredEntries.length === 0
            text: searchText.trim().length === 0 ? "No applications found" : "No matches"
            variant: "body1"
            color: Theme.muted
            horizontalAlignment: Text.AlignHCenter
          }

          ListView {
            id: appList
            width: parent.width
            height: Math.min(filteredEntries.length * 32, Theme.launcherMaxHeight)
            visible: filteredEntries.length > 0
            clip: true
            model: root.filteredEntries
            currentIndex: root.selectedIndex
            onCurrentIndexChanged: {
              if (currentIndex !== root.selectedIndex)
                root.selectedIndex = currentIndex
            }
            boundsBehavior: Flickable.StopAtBounds
            keyNavigationEnabled: true
            highlightFollowsCurrentItem: true

            delegate: LauncherRow {
              required property var modelData
              required property int index
              entry: modelData
              highlighted: appList.currentIndex === index
              onClicked: root.launch(modelData)
            }
          }
        }
      }
    }
  }
}
