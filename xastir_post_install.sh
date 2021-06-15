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

echo "Install desktop launcer"

sudo cp xastir.desktop /usr/share/applications/xastir.desktop

echo "Running common scripts"

sudo //usr/local/share/xastir/scripts/get-fcc-rac.pl
sudo //usr/local/share/xastir/scripts/get-NWSdata
sudo //usr/local/share/xastir/scripts/get-pop NE
sudo //usr/local/share/xastir/scripts/get-gnis NE

echo "Installation is now complete please configure Xastir as needed"


