#!/usr/bin/env bash
# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

sep='<span weight="bold" foreground="#00ff00">|</span>'
bat="/sys/class/power_supply/BAT0"

date=$(date "+%a %F") 

time=$(date "+%H:%M:%S")

sys_info=$(uname -ar | cut -d " " -f 1,3)

disk_info=$(df -h | grep '/' | head -1 | awk -F' ' '{print $5, $3}')

if [[ $OSTYPE == "freebsd"* ]]; then
    battery_status="$(acpiconf -i 0 | grep 'Remaining capacity' | awk -F' ' '{print $3}') <span weight=\"bold\">$(acpiconf -i 0 | grep 'State' | awk -F' ' '{print $2}')</span>"
else
battery_status="$(cat $bat/capacity)% <span weight=\"bold\">$(cat $bat/status)</span>"
fi

if [[ $OSTYPE == "freebsd"* ]]; then
# Use grep -m1 because of other ips from jails.
    private_ip=$(ifconfig wlan0 | grep -m1 'inet' | cut -d ' ' -f2)
else
    private_ip=$(ip -4 addr show wlo1 | awk '/inet / {print $2}' | cut -d/ -f1,2)
fi

echo "$sep  $disk_info  $sep  $sys_info  $sep  $private_ip  $sep  $date  $sep  $battery_status  $sep  $time  $sep"
