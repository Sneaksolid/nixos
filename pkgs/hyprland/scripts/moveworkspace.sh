#!/usr/bin/env bash

hyprctl -j monitors | jq -r '.[].name' | wofi -d | xargs hyprctl dispatch movecurrentworkspacetomonitor
