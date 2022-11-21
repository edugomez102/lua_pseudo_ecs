@echo off
cd ..

@REM Removing past builds if that is the case 
rd /s /q shipping/game_win64

@REM Making the .love file
7z a -tzip Game.zip game engine modules main.lua
move Game.zip Game.love

@REM Making the .exe file
copy /b "C:\Program Files\LOVE\love.exe" + Game.love Game.exe

@REM Removing stuff not necessary to keep the root clean
del Game.love

@REM Making the game folder ready for shipping
mkdir shipping
mkdir shipping\game_win64
move Game.exe shipping\game_win64\Game.exe
copy /v /b "C:\Program Files\LOVE\*.dll" shipping\game_win64

PAUSE
