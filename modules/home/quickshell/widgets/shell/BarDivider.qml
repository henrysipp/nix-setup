import QtQuick
import QtQuick.Layouts
import ".."

Rectangle {
  id: root

  Layout.alignment: Qt.AlignVCenter
  Layout.preferredWidth: 1
  Layout.preferredHeight: Theme.barSeparatorExtent
  Layout.leftMargin: Theme.barGridSpacing
  Layout.rightMargin: Theme.barGridSpacing
  color: Theme.barDivider
}
