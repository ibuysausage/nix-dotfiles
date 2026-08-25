import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

PanelWindow {
  id: bar

  anchors {
    top: true
    left: true
    right: true
  }
  margins {
    top: 13
    left: 16
    right: 16
  }
  implicitHeight:35
  color: "transparent"

  Poller {
    id: clock
    command: "date +'%I:%M:%S %A'"
    interval: 1000
  }

  Poller {
    id: vol
    command: "wpctl get-volume 54 | awk '{printf \"%d\", $2*100}'"
    interval: 100
  }

  Poller {
    id: bat
    command: "cat /sys/class/power_supply/BAT0/capacity"
    interval: 30000
  }

  Poller {
    id: bt
    command: "bluetoothctl show | grep -q 'Powered: yes' && echo on || echo off"
    interval: 5000
  }
  Poller {
    id: net
    command: "nmcli -t -f NAME connection show --active | head -n1"
    interval: 1000
  }

  readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.players.values[0] ?? null

  RowLayout {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 14
    spacing: 8

    Pill { 
      icon: "music_note"
      maxLabelWidth: 200
      label: bar.player ? `${bar.player.trackArtist || "Unknown"} - ${bar.player.trackTittle || ""}` : "Nothing playing"
    }
  }

  RowLayout{
    id: centerGroup
    anchors.centerIn: parent
    spacing: 8

    Pill { icon: "nest_clock_farsight_analog"; label: clock.value }
  }

  RowLayout {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 14
    spacing: 8

    Pill { icon: "volume_up"; label: vol.value + "%" }
    Pill { icon: "battery_android_full"; label: bat.value }
    Pill { icon: "wifi"; label: net.value }
  }
}
