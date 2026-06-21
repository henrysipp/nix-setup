import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Services.SystemTray as TrayService
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import ".."

Repeater {
  model: TrayService.SystemTray.items
  delegate: Item {
    id: trayCell
    required property SystemTrayItem modelData

    Layout.preferredWidth: Theme.barModuleWidth
    Layout.preferredHeight: Theme.barHeight
    Layout.alignment: Qt.AlignVCenter

    Rectangle {
      anchors.fill: parent
      anchors.margins: 3
      radius: Theme.barRadius
      color: mouse.containsMouse
        ? Qt.rgba(Theme.foreground.r, Theme.foreground.g, Theme.foreground.b, 0.08)
        : "transparent"
      Behavior on color { ColorAnimation { duration: 180 } }
    }

    IconImage {
      anchors.centerIn: parent
      width: Theme.trayIconSize
      height: Theme.trayIconSize
      source: trayCell.modelData.icon
      mipmap: true
      opacity: trayCell.modelData.status === Status.Passive ? 0.6 : 1
    }

    function displayMenu(x, y) {
      const pos = QsWindow.mapFromItem(trayCell, x, y)
      trayCell.modelData.display(QsWindow.window, pos.x, pos.y)
    }

    MouseArea {
      id: mouse
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor

      onClicked: event => {
        if (event.button === Qt.RightButton && trayCell.modelData.hasMenu) {
          trayCell.displayMenu(event.x, event.y)
        } else if (event.button === Qt.MiddleButton) {
          trayCell.modelData.secondaryActivate()
        } else if (event.button === Qt.LeftButton) {
          if (trayCell.modelData.onlyMenu && trayCell.modelData.hasMenu)
            trayCell.displayMenu(event.x, event.y)
          else
            trayCell.modelData.activate()
        }
      }

      onWheel: wheel => {
        trayCell.modelData.scroll(wheel.angleDelta.y / 120, false)
      }
    }
  }
}
