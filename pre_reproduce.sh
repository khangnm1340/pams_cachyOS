#!/usr/bin/env bash
# please remove this
# mkdir ~/my-drive
# sudo mount /dev/nvme0n1p3 ~/my-drive
# cp -pr ~/my-drive/@home/pampam/Documents/UTH/pams_cachyOS ~/Documents/

#yay
mkdir ~/builds
cd ~/builds
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
#nushell
yay && yay -S --needed nushell fd nordvpn-bin --noconfirm


# nordvpn
sudo groupadd nordvpn
sudo usermod -aG nordvpn $USER

cd ~/Documents/pams_cachyOS/
/usr/bin/nu -c "nu backup_conf.nu" && /usr/bin/nu -c "nu reproduce.nu" && /usr/bin/nu -c "nu reproduce_2.nu" 
# && /usr/bin/nu -c "nu STUPID_FUCKING_COMMAND.nu"
#
# Ensure iwd service will be started
sudo systemctl enable iwd.service

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
