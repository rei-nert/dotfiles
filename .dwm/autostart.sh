#!/bin/sh

gpgconf --launch gpg-agent
picom &
#xbindkeys &
setxkbmap -model abnt2 -layout br &
xrdb -merge ~/.Xresources &
feh --bg-scale "$HOME/Nextcloud/Miscellaneous/sukuna-electric-3840x2160-22504.jpg"
dunst &
nm-applet &
pasystray &
blueman-applet &
while true; do
  # --- Battery Information ---
  if [ -d /sys/class/power_supply/BAT0 ]; then
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)
    status=$(cat /sys/class/power_supply/BAT0/status)
    if [ "$status" = "Charging" ]; then
      bat="⚡ ${capacity}%"
    else
      bat="🔋 ${capacity}%"
    fi
  elif [ -d /sys/class/power_supply/BAT1 ]; then
    capacity=$(cat /sys/class/power_supply/BAT1/capacity)
    status=$(cat /sys/class/power_supply/BAT1/status)
    if [ "$status" = "Charging" ]; then
      bat="⚡ ${capacity}%"
    else
      bat="🔋 ${capacity}%"
    fi
  else
    bat="🔌 AC"
  fi

  # --- Time and Date ---
  datetime=$(date '+%a %d/%m/%Y %H:%M')

  # --- Notification Status ---
  # Checks if Dunst is in Do-Not-Disturb mode
  if dunstctl is-paused | grep -q "true"; then
    notif="󰂛 DND"
  else
    notif="󰂚"
  fi

  # --- Render Status Bar via xsetroot ---
  xsetroot -name " [ $notif ] | [ $bat ] | [ $datetime ] "

  sleep 2
done &
xrdb -merge ~/.Xresources
xrandr --auto &
clipmenud &
/usr/sbin/lxsession &
