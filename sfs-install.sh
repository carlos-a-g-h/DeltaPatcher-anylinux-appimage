#!/bin/bash

# Installation script that uses the SQUASHFS variant

set -eux

NAME="$1"
FILEPATH="$2"

echo "Installing: $NAME : $FILEPATH"

FILE_ICON="DeltaPatcher.png"
FILE_DESKTOP="DeltaPatcher.desktop"
BIN_APPDIR="bin/DeltaPatcher"
BIN_ABS="/usr/bin/DeltaPatcher"

# Decompress the AppDIr
unsquashfs -f -d "$NAME" "$FILEPATH"

# Move contents of the AppImage to the directory
mkdir -p /usr/appimages/
mv -v "$NAME" /usr/appimages/

# Link the main binary to the system
ln -s -r -f /usr/appimages/"$NAME"/"$BIN_APPDIR" "$BIN_ABS"

# Copy desktop file
cp -v /usr/appimages/"$NAME"/"$FILE_DESKTOP" /usr/share/applications/

# Copy icon file
cp -v /usr/appimages/"$NAME"/"$FILE_ICON" /usr/share/icons/

# Destroy the file
rm -v "$FILEPATH"

echo "DONE"
