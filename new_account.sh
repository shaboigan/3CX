#! /bin/bash

sudo touch file && sudo rm file
echo "By using this script, you'll create a new user account. Use CTRL+C to cancel the script"

echo "Set the Account Username"
read -p "Please enter the desired Username: " username
sudo useradd -m -s /bin/bash $username && sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev $username

echo "Set the Account Password"
sudo passwd $username

echo "Removing pi account from autologin ready for removal"
sudo sed -i "s/autologin-user=pi/autologin-user=$username/g" /etc/lightdm/lightdm.conf && sudo sed -i "s/--autologin pi/--autologin $username/g" /etc/systemd/system/autologin@.service

echo "Script will now reboot."
echo "Restart the putty session and login with the newly created account"
sudo reboot
