#!/usr/bin/env bash

case "$1" in
  up) brightnessctl set 5%+ ;;
  down) brightnessctl set 5%- ;;
esac

brightness=$(brightnessctl -m | awk -F, '{print substr($4, 1, length($4)-1)}')

notify-send -h string:x-canonical-private-synchronous:brightness \
  -h int:value:"$brightness" -i "display-brightness-symbolic" \
  "Brightness: ${brightness}%"
