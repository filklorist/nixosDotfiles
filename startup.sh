#!/usr/bin/env bash

hyprctl hyprpaper wallpaper ,~/Pictures/1920\ black.png &&
sleep 0.5 &
wait
hyprctl dispatch "exec kitty -e ./.dotfiles/loading.sh" &&
sleep 7.4
hyprctl dispatch "exec killall hyprpaper && hyprpaper" &&
sleep 2
hyprctl dispatch "exec kitty -e gotop"
sleep 1
hyprctl dispatch "exec kitty -e ranger"
sleep 2
hyprctl dispatch "exec [opacity 1] kitty -e ./.dotfiles/astroterm.sh"
