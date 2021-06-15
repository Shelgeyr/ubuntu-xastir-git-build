#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

cp xastir.desktop /usr/share/applications/xastir.desktop

sudo -u $real_user chmod +x ubuntu-xastir-git-build.sh
sudo -u $real_user ./ubuntu-xastir-git-build.sh
