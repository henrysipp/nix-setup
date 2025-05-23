#!/bin/sh
killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 1; done

waybar
# waybar -c $HOME/.config/hypr/waybar/config.jsonc -s $HOME/.config/hypr/waybar/style.css
# env GTK_DEBUG=interactive waybar -c $HOME/.config/hypr/waybar/config.jsonc -s $HOME/.config/hypr/waybar/style.css
