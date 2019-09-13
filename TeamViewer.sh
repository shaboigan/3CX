#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

echo -e "${Colour}By using this script, you'll install Teamviewer.\nUse CTRL+C to cancel the script\n\n${less}"

echo -e "${Colour}\n\nTeamviewer is downloading now.\n\n${less}"
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb -O teamviewer.deb

echo -e "${Colour}\n\nTeamviewer will be installed now.\n\n${less}"
sudo dpkg -i teamviewer.deb; sudo apt-get install -f -y

if [[ -z "$1" ]] ; then
echo -e "${Colour}\nConnect Teamviewer to account\n${less}"
sudo teamviewer setup
else
echo -e "${Colour}\nSet the Teamviewer password\n${less}"
read -p "Please enter the desired password for Teamviewer (12 Characters or less): " password
sudo teamviewer passwd $password
echo -e "${Colour}\nYou will need to manually connect Teamviewer to an account, until TV resolve the error with automatic connection\n${less}"
read -p "Press enter to acknowledge and continue"
fi
