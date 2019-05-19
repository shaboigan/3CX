#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

sudo touch file && sudo rm file
echo "${Colour}By using this script, you'll create a new user account.\nUse CTRL+C to cancel the script\n\n${less}"

echo "${Colour}\nSet the Account Username\n${less}"
read -p "Please enter the desired Username: " username
sudo useradd -m -s /bin/bash $username && sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev $username

echo "${Colour}\nSet the Account Password\n${less}"
sudo passwd $username

echo "${Colour}\nRemoving pi account from autologin ready for removal\n${less}"
sudo sed -i "s/autologin-user=pi/autologin-user=$username/g" /etc/lightdm/lightdm.conf && sudo sed -i "s/--autologin pi/--autologin $username/g" /etc/systemd/system/autologin@.service

echo "${Colour}\nScript will now reboot.\n${less}"
echo "${Colour}\nRestart the putty session and login with the newly created account\n${less}"
sudo reboot
