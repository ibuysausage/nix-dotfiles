import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root

  property string icon: ""
  property string label: ""
  property color iconColor: "#9c5fce"
  property int maxLabelWidth: 400

  implicitWidth: row.implicitWidth + 22
  implicitHeight: 35
  radius: height / 2
  color: "#241b26"

  RowLayout {
    id: row
    anchors.centerIn: parent
    spacing: 7

    Text {
      text: root.icon
      color: root.iconColor
      font.family: "Material Symbols Rounded"
      font.pixelSize: 16
    }

    Text {
      text: root.label
      color: "#eed5d9"
      font.family: "CaskaydiaCove Nerd Font"
      font.pixelSize: 16
      elide: Text.ElideRight
      Layout.maximumWidth: root.maxLabelWidth
      visible: root.label != ""
    }
  }
}
