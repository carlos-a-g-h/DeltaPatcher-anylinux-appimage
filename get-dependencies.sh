#!/bin/bash

set -eux

ARCH=$(uname -m)

VERSION="$(sed -n 1p sources.txt)"

# [source.txt] Upstream release
URL_UPSTREAM=$(awk "/DeltaPatcher/ && /$VERSION/ && /$ARCH/" sources.txt)

# [source.txt] Icon
URL_ICON=$(awk "/DeltaPatcher/ && /graphics/" sources.txt)

# [Anylinux] Debloated packages script
URL_DPKG="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

# [Anylinux] Quick sharun script
URL_SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

if [ -z "$URL_UPSTREAM" ]
then
	echo "[!] URL_UPSTREAM not detected in the sources.txt file"
	exit 1
fi

# Debloated packages script
FILENAME="get-debloated-pkgs"
wget "$URL_DPKG" -O "$FILENAME"
chmod +x "$FILENAME"

# Quick Sharun script
FILENAME="quick-sharun"
wget "$URL_SHARUN" -O "$FILENAME"
chmod +x "$FILENAME"

# Create the Details directory
mkdir -p AppDir/_details
echo "" > AppDir/_details/chk.md5.txt

# The Icon from the repo
mkdir -p "upstream"
FILENAME="upstream/DeltaPatcher.png"
wget "$URL_ICON" -O "$FILENAME"
md5sum "$FILENAME" >> AppDir/_details/chk.md5.txt

# The release from upstream
FILENAME="DeltaPatcher.zip"
wget "$URL_UPSTREAM" -O "$FILENAME"
md5sum "$FILENAME" >> AppDir/_details/chk.md5.txt

# Install unzip if it's not installed
pacman -Sy --noconfirm \
unzip

# Extract the contents from upstream
mkdir -p upstream
unzip "$FILENAME" -d upstream

# Move the official changelog to AppDir/_details
mv -v upstream/CHANGELOG.txt AppDir/_details/

# Install basic pacakges
pacman -Sy --noconfirm \
gcc \
zsync zstd patchelf base-devel xorg-server-xvfb \
systemd-libs libepoxy freetype2 fribidi

# Install debloated packages
bash get-debloated-pkgs mesa-mini gtk3-mini gdk-pixbuf2-mini
