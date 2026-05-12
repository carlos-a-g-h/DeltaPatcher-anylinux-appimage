#!/bin/bash

# Installs the software inside the compressed AppDir

set -eux

NAME="DeltaPatcher"
FILEPATH="$1"

echo "[RUN] $NAME : $FILEPATH"

FILE_ICON="DeltaPatcher.png"
FILE_DESKTOP="DeltaPatcher.desktop"
BIN_APPDIR="bin/DeltaPatcher"
BIN_ABS="/usr/bin/DeltaPatcher"

# Decompress the AppDIr
unsquashfs -f -d "$NAME" "$FILEPATH"

# Move contents of the AppDir to the appimages directory
APPIMAGE_DIR="/usr/appimages/""$NAME"
if [ -d "$APPIMAGE_DIR" ]
then
	rm -vrf "$APPIMAGE_DIR"
	echo "[NOTICE] WIPED OUT: $APPIMAGE_DIR"
else
	mkdir -vp /usr/appimages/
fi
mv -vf "$NAME" /usr/appimages/

# Symlink the main binary
ln -vsrf /usr/appimages/"$NAME"/"$BIN_APPDIR" "$BIN_ABS"

# Copy desktop file
cp -va /usr/appimages/"$NAME"/"$FILE_DESKTOP" /usr/share/applications/

# Copy icon file
cp -va /usr/appimages/"$NAME"/"$FILE_ICON" /usr/share/icons/

# Destroy the file
rm -v "$FILEPATH"

# ALl good
echo "[OK] Installed: $NAME"
