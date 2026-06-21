import QtQuick
import ".."

Text {
  property string variant: "body1"

  readonly property var textStyle: Typography.style(variant)

  font.family: Theme.font
  font.pixelSize: textStyle.pixelSize
  font.weight: textStyle.weight
  lineHeight: textStyle.lineHeight
  lineHeightMode: Text.ProportionalHeight
}
