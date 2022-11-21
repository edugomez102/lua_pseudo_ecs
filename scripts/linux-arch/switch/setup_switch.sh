#bin/bash

# === Installing the devkitpro ===

# --- Adding environment variables ---
DEVKITPRO=/opt/devkitpro
DEVKITARM=/opt/devkitpro/devkitARM
DEVKITPPC=/opt/devkitpro/devkitPPC

# --- Importing keys ---
sudo pacman-key --recv BC26F752D25B92CE272E0F44F7FD5492264BB9D0 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign BC26F752D25B92CE272E0F44F7FD5492264BB9D0

# --- Keyring ---
wget https://pkg.devkitpro.org/devkitpro-keyring.pkg.tar.xz

# --- Installing keyring ---
pacman -U devkitpro-keyring.pkg.tar.xz

# --- Adding repositories ---
echo '[dkp-libs]' >> /etc/pacman.conf
echo 'Server = https://pkg.devkitpro.org/packages' >> /etc/pacman.conf
echo '[dkp-linux]' >> /etc/pacman.conf
echo 'Server = https://pkg.devkitpro.org/packages/linux/$arch/' >> /etc/pacman.conf

# --- Update the system ---
pacman -Syu

# === Installing the switch-dev kit ===
pacman -S switch-dev

# === Installing love-potion ===
wget https://github.com/lovebrew/lovepotion/releases/download/2.4.0/Nintendo.Switch-a52d821.zip
unzip Nintendo.Switch-a52d821.zip
mkdir ~/.config/lovebrew
mv LOVEPotion.nro ~/.config/lovebrew
rm Nintendo.Switch-a52d821.zip LOVEPotion.elf

# === Installing lovebrew ===
wget https://github.com/lovebrew/lovebrew/releases/download/0.6.0/Linux-6aaa40e.zip
unzip Linux-6aaa40e.zip
mv lovebrew ~/.config/lovebrew
chmod +x ~/.config/lovebrew/lovebrew
rm Linux-6aaa40e.zip

# === Removing trash ===
rm devkitpro-keyring.pkg.tar.xz

