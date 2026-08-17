#!/usr/bin/env bash

case "$1" in
  up) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
  down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
  mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)

if [ "$muted" = "1" ]; then
  icon="audio-volume-muted-symbolic"
  notify-send -h string:x-canonical-private-synchronous:volume \
    -h int:value:0 -i "$icon" "Muted"
else
  icon="audio-volume-high-symbolic"
  [ "$volume" -lt 30 ] && icon="audio-volume-low-symbolic"
  [ "$volume" -eq 0 ] && icon="audio-volume-muted-symbolic"
  notify-send -h string:x-canonical-private-synchronous:volume \
    -h int:value:"$volume" -i "$icon" "Volume: ${volume}%"
fi
