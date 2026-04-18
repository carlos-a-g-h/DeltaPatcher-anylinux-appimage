#!/bin/bash

set -eux

ARCH=$(uname -m)

VERSION="$(sed -n 1p sources.txt)"

# [Source] Upstream
URL_UPSTREAM=$(awk "/DeltaPatcher/ && /$VERSION/ && /$ARCH/" sources.txt)

# [Source] Icon
URL_ICON=$(awk "/DeltaPatcher/ && /graphics/" sources.txt)

if [ -z "$URL_UPSTREAM" ]
then
	echo "[!] URL_UPSTREAM not detected in the sources.txt file"
	exit 1
fi

# Debloated packages script
URL="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"
FILENAME="get-debloated-pkgs"
wget "$URL" -O "$FILENAME"
chmod +x "$FILENAME"

# Quick Sharun script
URL="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
FILENAME="quick-sharun"
wget "$URL" -O "$FILENAME"
chmod +x "$FILENAME"

# The Icon
mkdir -p "upstream"
FILENAME="upstream/DeltaPatcher.png"
wget "$URL_ICON" -O "$FILENAME"

# The release from upstream
FILENAME="DeltaPatcher.zip"
wget "$URL_UPSTREAM" -O "$FILENAME"


# Install unzip if it's not installed
pacman -Sy --noconfirm \
unzip

mkdir -p upstream
unzip "$FILENAME" -d upstream

bash get-debloated-pkgs mesa-mini gtk3-mini gdk-pixbuf2-mini

pacman -Sy --noconfirm \
zsync zstd patchelf base-devel xorg-server-xvfb \
systemd-libs libepoxy freetype2 fribidi

