#!/bin/bash

set -eux

# System architecture
ARCH=$(uname -m)

# [DeltaPatcher] Select version
VERSION="$(sed -n 1p sources.txt)"

# [DeltaPatcher] Upstream release
URL_UPSTREAM=$(awk "/https/ && /DeltaPatcher/ && /$VERSION/ && /$ARCH/" sources.txt)

# [DeltaPatcher] Icon
URL_ICON=$(awk "/https/ && /DeltaPatcher/ && /graphics/" sources.txt)

# [Anylinux] Debloated packages script
URL_DPKG=$(awk "/https/ && /get-debloated-pkgs.sh/" sources.txt)

# [Anylinux] Quick sharun script
URL_SHARUN=$(awk "/https/ && /quick-sharun.sh/" sources.txt)

# Check all URLs
if [ -z "$URL_UPSTREAM" ] || [ -z "$URL_ICON" ] || [ -z "$URL_DPKG" ] || [ -z "$URL_SHARUN" ]
then
	echo "[!] Some URLs were not detected in the sources.txt file"
	exit 1
fi

# Debloated packages script
FILENAME="get-debloated-pkgs.sh"
wget "$URL_DPKG" -O "$FILENAME"
chmod +x "$FILENAME"

# Quick Sharun script
FILENAME="quick-sharun.sh"
wget "$URL_SHARUN" -O "$FILENAME"
chmod +x "$FILENAME"

# Create the Details directory
mkdir -p AppDir/_details
touch AppDir/_details/checksums.md5.txt
touch AppDir/_details/checksums.sha256.txt

# The Icon from the repo + Checksums
mkdir -p "upstream"
FILENAME="upstream/DeltaPatcher.png"
wget "$URL_ICON" -O "$FILENAME"
md5sum "$FILENAME" >> AppDir/_details/checksums.md5.txt
sha256sum "$FILENAME" >> AppDir/_details/checksums.sha256.txt

# The release from upstream + Checksums
FILENAME="DeltaPatcher.zip"
wget "$URL_UPSTREAM" -O "$FILENAME"
md5sum "$FILENAME" >> AppDir/_details/checksums.md5.txt
sha256sum "$FILENAME" >> AppDir/_details/checksums.sha256.txt

# Install unzip if it's not installed
pacman -Sy --noconfirm unzip

# Extract the contents from upstream + Checksums
mkdir -p upstream
FILENAME="DeltaPatcher.zip"
unzip "$FILENAME" -d upstream
FILENAME="upstream/DeltaPatcher"
md5sum "$FILENAME" >> AppDir/_details/checksums.md5.txt
sha256sum "$FILENAME" >> AppDir/_details/checksums.sha256.txt

# Move the official changelog to AppDir/_details
mv -v upstream/CHANGELOG.txt AppDir/_details/

# Install basic pacakges
pacman -Sy --noconfirm \
	gcc squashfs-tools \
	zsync zstd patchelf base-devel xorg-server-xvfb \
	systemd-libs libepoxy freetype2 fribidi

# Install debloated packages
bash get-debloated-pkgs.sh mesa-mini gtk3-mini gdk-pixbuf2-mini
