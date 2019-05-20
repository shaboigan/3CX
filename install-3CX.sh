#! /bin/bash

Colour='\033[1;31m'
less='\033[0m'

echo -e "${Colour}By using this script, you'll remove the default pi account, update the system, install Teamviewer and install the 3CX SBC (Session Border Controller).\nUse CTRL+C to cancel the script\n\n${less}"

echo -e "${Colour}\nRemoving the default pi account and the associated home directory\n${less}"
sudo deluser pi

echo -e "${Colour}\n\nThe system will now upgrade all the software and firmware, as well as clean up old/unused packages.\n\n${less}"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean

echo -e "${Colour}\n\nTeamviewer is downloading now.\n\n${less}"
wget wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb -O teamviewer.deb

echo -e "${Colour}\n\nTeamviewer will be installed now.\n\n${less}"
sudo dpkg -i teamviewer.deb; sudo apt-get install -f -y

if [[ -z "$1" ]] ; then
echo -e "${Colour}\nSet the Teamviewer password\n${less}"
read -p "Please enter the desired password for Teamviewer (12 Characters or less): " password
sudo teamviewer passwd $password
else
echo -e "${Colour}\nYou will need to manually connect Teamviewer to an account, until TV resolve the error with automatic connection\n${less}"
read -p "${Colour}Press enter to acknowledge and continue${less}"
fi

echo -e "${Colour}\n\nThe 3CX SBC (Session Border Controller) is downloading now.\n\n${less}"
wget http://downloads.3cx.com/downloads/sbc/3cxsbc.zip -O 3cxsbc.zip

echo -e "${Colour}\n\nThe 3CX SBC (Session Border Controller) will be installed now.\n\n${less}"
sudo bash 3cxsbc.zip
