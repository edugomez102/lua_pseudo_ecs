#bin/bash

# --- Remove past builds ---
rm -f -r ../../../shipping/game_switch

# --- Making folders for compiling the switch game ---  
mkdir Project
mkdir Project/game

# --- Copy game and engine files to the project folder ---
cp -r ../../../engine Project/game/
cp -r ../../../game Project/game/
cp -r ../../../modules Project/game/
cp -r ../../../main.lua Project/game/

# --- Change lovebrew config ---
cp lovebrew.toml Project/
cd Project

# --- Creating directories to store the compiled game ---
mkdir ../../../../shipping/
mkdir ../../../../shipping/game_switch

# --- Building the game ---
~/.config/lovebrew/lovebrew build

# --- Moving the compiled game to the directory ---
mv build/SuperGame.nro ../../../../shipping/game_switch/

# --- Cleaning up ---
rm -r build
cd ..
rm -r Project