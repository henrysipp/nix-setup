pragma Singleton

import QtQuick

QtObject {
  property string currentName: ""
  property var screen: null
  property real currentCenter: 0

  property int batteryCapacity: -1
  property string batteryChargeStatus: ""
  property string batteryStatusLabel: ""
  property bool batteryPresent: false

  readonly property bool hasCurrent: currentName.length > 0

  function closeAll() {
    currentName = ""
  }

  function anchorPopupTo(item) {
    const p = item.mapToItem(null, item.width / 2, item.height / 2)
    currentCenter = p.x
  }

  function togglePopup(name, anchorItem) {
    if (name === "battery" && !batteryPresent)
      return
    if (currentName === name) {
      closeAll()
      return
    }

    anchorPopupTo(anchorItem)
    screen = anchorItem.QsWindow?.screen ?? null
    currentName = name
  }
}
