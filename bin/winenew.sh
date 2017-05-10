#! /usr/bin/env bash
# This script creates new wine prefix at specified path.
# Winetricks required. apt-get install -y winetricks

# Exit immediately if there's an error
set -e

DIR=`pwd`

if [ "$1" = "" ]
  then
    PREFIX=$DIR
else
  case $1 in
    -h | --help )
      echo "winenew.sh - Create new Wine prefix."
      echo "Usage: winenew.sh [Path]"
      echo "       The default path is the current directory."
      exit
      ;;
    * )
    PREFIX=$1
  esac
fi

echo -e "\
________________________________________
Prefix Path: $PREFIX
________________________________________
"

echo -e "Select architecture: \n"

select ARCH in x86 x64; do
  case $ARCH in
    x86) ARCH="win32"; break;;
    x64) ARCH="win64"; break;;
  esac
done

echo -e "\nCreating new prefix...\n"

# Create FixFonts.reg file for latter import. This fixes ugly fonts in Wine.
cat <<EOT >> FixFonts.reg
[HKEY_CURRENT_USER\Software\Wine\X11 Driver]
"ClientSideWithRender"="N"
EOT

WINEPREFIX=$PREFIX WINEARCH=$ARCH winetricks fontsmooth=rgb
WINEPREFIX=$PREFIX wine regedit FixFonts.reg

rm FixFonts.reg

echo -e "\nDone! New prefix is created at: $PREFIX\n"