#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

sudo touch file && sudo rm file
echo "${Colour}By using this script, you'll create a new user account. Use CTRL+C to cancel the script${less}"

echo "${Colour}Set the Account Username${less}"
read -p "Please enter the desired Username: " username
sudo useradd -m -s /bin/bash $username && sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev $username

echo "${Colour}Set the Account Password${less}"
sudo passwd $username

echo "${Colour}Removing pi account from autologin ready for removal${less}"
sudo sed -i "s/autologin-user=pi/autologin-user=$username/g" /etc/lightdm/lightdm.conf && sudo sed -i "s/--autologin pi/--autologin $username/g" /etc/systemd/system/autologin@.service

echo "${Colour}Script will now reboot.${less}"
echo "${Colour}Restart the putty session and login with the newly created account${less}"
sudo reboot
