#!/bin/bash

set -eu

GH_SHA="$1"
GH_SHA_SHORT="${GH_SHA:0:8}"

ARCH=$(uname -m)
VERSION="$(sed -n 1p sources.txt)"
NAME="DeltaPatcher"

APPIMAGE_STEM="$NAME"_v"$VERSION"_"$GH_SHA_SHORT"_anylinux_"$ARCH"

export ARCH VERSION
export OUTPATH=./dist
# export ADD_HOOKS="self-updater.bg.hook"
# export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON="upstream/DeltaPatcher.png"
export DESKTOP="DeltaPatcher.desktop"
export DEPLOY_GTK=1
export DEPLOY_GDK=1
export DEPLOY_LOCALES=1

export OUTNAME="$APPIMAGE_STEM".AppImage

# Deploy dependencies
quick-sharun upstream/DeltaPatcher

# Prepare the .desktop file
sed -i \
-e "s/VERSION_GOES_HERE/$VERSION/" \
-e "s/ARCH_GOES_HERE/$ARCH/" \
"$DESKTOP"

# Fill in the details
echo "$GH_SHA" > AppDir/_details/commit.txt
echo "$(date)" > AppDir/_details/date.txt
pacman -Q > AppDir/_details/packages.txt

# Copy Internal scripts
mkdir -vp AppDir/bin
cp -v is_details AppDir/bin/details
cp -v is_setup.1.sh AppDir/bin/setup
cat is_setup.2.sh >> AppDir/bin/setup
chmod +x AppDir/bin/details
chmod +x AppDir/bin/setup

# Turn AppDir into AppImage
quick-sharun --make-appimage
