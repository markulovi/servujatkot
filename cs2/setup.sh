#!/bin/bash

GAMEINFO_PATH="./steam/game/csgo/gameinfo.gi"

if [ ! -f "$GAMEINFO_PATH" ]; then
  echo "Error: gameinfo.gi file not found."
  exit 1
fi

if ! grep -q "csgo/addons/metamod" "$GAMEINFO_PATH"; then
  /usr/bin/sed -i 's/^\(\t\t\tGame\tcsgo\)\([^_]\)/\1\/addons\/metamod\r\n\t\t\tGame\tcsgo\2/' "$GAMEINFO_PATH"
  echo "Metamod plugin activated."
else
  echo "Metamod plugin is already activated."
fi
