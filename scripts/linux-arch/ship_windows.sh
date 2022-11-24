# --- Remove past builds ---
rm -f -r ../../shipping/game_win64

# --- Get the love win zip ---
wget https://github.com/love2d/love/releases/download/11.4/love-11.4-win64.zip
unzip love-11.4-win64.zip

# --- Creating directory and moving the unzip ---
mkdir ../../shipping
mv love-11.4-win64 ../../shipping/
mv ../../shipping/love-11.4-win64 ../../shipping/game_win64

# --- Zipping the .love and moving to shipping ---
cd ../..
zip -9 -r game.zip engine game main.lua modules
mv game.zip game.love
mv game.love shipping/game_win64

# --- Creating the windows binary ---
cd shipping/game_win64
cat love.exe game.love > game.exe
cd ../..

# --- Cleaning ---
cd scripts/linux-arch
rm love-11.4-win64.zip


