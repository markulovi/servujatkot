#!/bin/bash

GAME_PATH="./steam/game/csgo"
GAME_INFO="gameinfo.gi"

cd $GAME_PATH

echo "Downloading Metamod..."
curl -L $METAMOD_RELEASE_URL -o metamod.tar.gz
echo "Unpacking Metamod..."
tar -xvf metamod.tar.gz
echo "Removing Metamod tar file..."
rm metamod.tar.gz
echo "Metamod installed successfully."

echo "Downloading CSSharp..."
curl -L $CSSHARP_RELEASE_URL -o cssharp.zip
echo "Unpacking CSSharp..."
unzip cssharp.zip
echo "Removing CSSharp zip file..."
rm cssharp.zip
echo "CSSharp installed successfully."

echo "Downloading MatchZy..."
curl -L $MATCHZY_RELEASE_URL -o matchzy.zip
echo "Unpacking MatchZy..."
unzip matchzy.zip
echo "Removing MatchZy zip file..."
rm matchzy.zip
echo "MatchZy installed successfully."

if [ ! -f "$GAME_INFO" ]; then
  echo "Error: gameinfo.gi file not found."
  exit 1
fi

if ! grep -q "csgo/addons/metamod" "$GAME_INFO"; then
  /usr/bin/sed -i 's/^\(\t\t\tGame\tcsgo\)\([^_]\)/\1\/addons\/metamod\r\n\t\t\tGame\tcsgo\2/' "$GAME_INFO"
  echo "Metamod plugin activated."
else
  echo "Metamod plugin is already activated."
fi
