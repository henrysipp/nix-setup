import QtQuick
import ".."

TextInput {
  property string variant: "body1"

  readonly property var textStyle: Typography.style(variant)

  font.family: Theme.font
  font.pixelSize: textStyle.pixelSize
  font.weight: textStyle.weight
  selectionColor: Theme.accent
}
