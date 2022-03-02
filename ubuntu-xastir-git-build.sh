#!/bin/bash
# Build script for Xastir-git on Ubuntu(Kubuntu/Xubuntu) 10.04 thru 16.04
# Released under GNU GPL v3. NO WARRANTY OF ANY KIND.
#
# May 14 2010 production-ready version. peter+aprs(at)duonet.net
# Jul 24 2010 removed git 'login' command.  Seems to not be needed.
# Jan 02 2011 added support for Ubuntu 10.10
# Jan 03 2011 Fix to add correct UbuntuGIS repo
# Jan 04 2011 Switched from aptitude to apt-get for package management.
# May 05 2011 Added support for Ubuntu 11.04
# Oct 02 2011 For Ubuntu 11.04, corrected the curl dev package to libcurl4-openssl-dev
# Dec 24 2011 Added support for Ubuntu 11.10
# Jul 15 2012 Added support for Ubuntu 12.04, does not use UbuntuGIS repo if 11.10 or 12.04
# Mar 31 2013 Added support for Ubuntu 12.10
# Nov 26 2013 Added support for Ubuntu 13.04 and 13.10
# May 18 2014 Added support for Ubuntu 14.04
# Jan 09 2016 Added support for Ubuntu, 14.10, 15.04, and 15.10
# Jul 09 2016 Added support for Ubuntu 16.04
# Jul 04 2018 Added support for Ubuntu 16.10, 17.04, 17.10, and 18.04
# Nov 18 2020 Added support for Ubuntu 18.10, 19.04, 19.10, 20.04, and 20.10
# Jun 15 2021 Added support for Ubuntu 21.04
# Mar 02 2022 Added support for Ubuntu 21.10 and 22.04; edited comments for clarity; fixed python-dev with python2-dev for versions > 20.01

gis=true
IDK=true
needfont=false

packages="build-essential git autoconf automake xorg-dev graphicsmagick gv gpsman gpsmanshp libpcre3-dev libdb5.3-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libwebp-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"

if grep -q "^deb.*xenial-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 16.04 (xenial)."
  release=xenial
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*yakkety-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 16.10 (yakkety)."
  release=yakkety
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*zesty-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 17.04 (zesty)."
  release=zesty
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*artful-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 17.10 (artful)."
  release=artful
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*bionic-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 18.04 (bionic)."
  release=bionic
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*cosmic-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 18.10 (cosmic)."
  release=cosmic
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*disco-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 19.04 (disco)."
  release=disco
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*eoan-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 19.10 (eoan)."
  release=eoan
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*focal-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 20.04 LTS (focal)."
  release=focal
  gis=false
  IDK=false
  needfont=true
fi

packages="build-essential git autoconf automake xorg-dev graphicsmagick gv gpsman gpsmanshp libpcre3-dev libdb5.3-dev python2-dev libax25-dev shapelib libshp-dev festival festival-dev libwebp-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"

if grep -q "^deb.*groovy-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 20.10 (groovy)."
  release=groovy
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*hirsute-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 21.04 (hirsute)."
  release=hirsute
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*impish-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 21.10 (impish)."
  release=impish
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*jammy-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 22.04 LTS (jammy)."
  release=jammy
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*wily-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 15.10 (wily)."
  packages="build-essential git autoconf automake xorg-dev graphicsmagick gv gpsman gpsmanshp libpcre3-dev libdb5.3-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libwebp-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"
  release=wily
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*vivid-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 15.04 (vivid)."
  packages="build-essential git autoconf automake xorg-dev graphicsmagick gv libxp-dev gpsman gpsmanshp libpcre3-dev libdb5.3-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"
  release=vivid
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*utopic-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 14.10 (utopic)."
  packages="build-essential git autoconf automake xorg-dev graphicsmagick gv libxp-dev gpsman gpsmanshp libpcre3-dev libdb5.3-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"
  release=utopic
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*trusty-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 14.04 (trusty)."
  packages="build-essential git autoconf automake xorg-dev graphicsmagick gv libxp-dev gpsman gpsmanshp libpcre3-dev libdb5.3-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"
  release=trusty
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*saucy-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 13.10 (saucy)."
  packages="build-essential git autoconf automake xorg-dev graphicsmagick gv libxp-dev tcl8.4 gpsman gpsmanshp libpcre3-dev libdb5.1-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libgraphicsmagick1-dev libmotif-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"
  release=saucy
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*raring-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 13.04 (raring)."
  packages="build-essential git autoconf automake xorg-dev graphicsmagick gv libxp-dev tcl8.4 gpsman gpsmanshp libpcre3-dev libdb5.1-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libgraphicsmagick1-dev lesstif2-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"
  release=raring
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*quantal-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 12.10 (quantal)."
  packages="build-essential git autoconf automake xorg-dev graphicsmagick gv libxp-dev tcl8.4 gpsman gpsmanshp libpcre3-dev libdb5.1-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libgraphicsmagick1-dev lesstif2-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"
  release=quantal
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*oneiric-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 11.10 (oneiric)."
  packages="build-essential git autoconf automake xorg-dev imagemagick gv libxp-dev gpsman gpsmanshp libpcre3-dev libdb4.8-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libmagickcore-dev lesstif2-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev"
  release=oneiric
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*precise-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 12.04 (precise)."
  packages="build-essential git autoconf automake xorg-dev imagemagick gv libxp-dev gpsman gpsmanshp libpcre3-dev libdb4.8-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libmagickcore-dev lesstif2-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev xfonts-100dpi xfonts-75dpi"
  release=precise
  gis=false
  IDK=false
  needfont=true
fi
if grep -q "^deb.*lucid-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 10.04 (lucid)."
  packages="build-essential git autoconf automake xorg-dev imagemagick gv libxp-dev gpsman gpsmanshp libpcre3-dev libdb4.8-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libmagickcore-dev lesstif2-dev libcurl3-dev libproj-dev libgeotiff-dev"
  release=lucid
  IDK=false
fi
if grep -q "^deb.*maverick-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 10.10 (maverick)."
  packages="build-essential git autoconf automake xorg-dev imagemagick gv libxp-dev gpsman gpsmanshp libpcre3-dev libdb4.8-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libmagickcore-dev lesstif2-dev libcurl3-dev libproj-dev libgeotiff-dev"
  release=maverick
  IDK=false
fi
if grep -q "^deb.*natty-updates" /etc/apt/sources.list; then
  echo "Detected Ubuntu 11.04 (natty)."
  packages="build-essential git autoconf automake xorg-dev imagemagick gv libxp-dev gpsman gpsmanshp libpcre3-dev libdb4.8-dev python-dev libax25-dev shapelib libshp-dev festival festival-dev libmagickcore-dev lesstif2-dev libcurl4-openssl-dev libproj-dev libgeotiff-dev"
  release=natty
  IDK=false
fi

if $IDK; then
  echo "I don't know what to do with your OS.  Can't detect a supported version of Ubuntu."
  exit 1
fi

# the newer releases don't need the UbuntuGIS repo added
if $gis; then
# Add the UbuntuGIS repo and signing key, if needed.
  if ! [ -f /etc/apt/sources.list.d/ubuntugis-unstable.list ]; then
    echo "Adding the UbuntuGIS repository to the apt sources directory."

    echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu ${release} main
deb-src http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu ${release} main" \
  | sudo tee /etc/apt/sources.list.d/ubuntugis-unstable.list > /dev/null

    # Grab the signing key.
    if ! sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 089EBE08314DF160; then
      sudo rm /etc/apt/sources.list.d/ubuntugis-unstable.list
      echo "Could not retrieve package signing key for UbuntuGIS repo.  Aborting."
      exit 1
    fi
  fi
fi

# make sure everything's fresh; then get the build-essentials and dependencies
sudo apt-get update || exit 1
sudo apt-get install ${packages:?} || exit 1

if $needfont; then
  xset +fp /usr/share/fonts/X11/100dpi,/usr/share/fonts/X11/75dpi
fi

# make a source dir to work in
mkdir -p ~/src ; cd ~/src || exit 1

# check out the xastir sources
 git clone https://github.com/Xastir/Xastir.git || exit 1

# Do some initial housekeeping
cd Xastir
./bootstrap.sh

# build config files and makefile
mkdir -p build; cd build || exit 1
../configure CPPFLAGS="-I/usr/include/geotiff" || exit 1

# make it (-j = use SMP, if available), then install it (in /usr/local, by default)
make clean && make -j && sudo make install


