import QtQuick
import ".."

NumberAnimation {
  property int type: 0

  duration: type === 0
    ? Theme.animDefaultSpatialDuration
    : Theme.animDefaultEffectsDuration
  easing.type: Easing.BezierSpline
  easing.bezierCurve: type === 0
    ? Theme.animSpatialCurve
    : Theme.animEffectsCurve
}
