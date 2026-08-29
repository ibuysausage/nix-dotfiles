import QtQuick
import QtQuick.Layouts
import qs.theme

Rectangle {
  id: root

  property string icon: ""
  property string label: ""
  property color iconColor: Theme.base03
  property int maxLabelWidth: 400

  implicitWidth: row.implicitWidth + 22
  implicitHeight: 35
  radius: height / 2
  color: Theme.base00

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
      color: Theme.base05
      font.family: "CaskaydiaCove Nerd Font"
      font.pixelSize: 16
      elide: Text.ElideRight
      Layout.maximumWidth: root.maxLabelWidth
      visible: root.label != ""
    }
  }
}
