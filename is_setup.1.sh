#!/bin/bash

# NOTE: THIS IS AN INTERNAL SCRIPT AND IT CAN ONLY RUN INSIDE THE APPIMAGE AS
# A COMMAND LINE ARGUMENT

set -eu

MAIN_BIN="/usr/bin/DeltaPatcher"

# CONFIG_DIR="$HOME""/.config/peazip"

DESKTOP="DeltaPatcher.desktop"
DESKTOP_EXEC=$(basename "$MAIN_BIN")
PATH_ICON="/usr/share/icons/DeltaPatcher.png"
declare -a LBINARIES=(
	"$MAIN_BIN"
)

function additional_config_tasks() {
	# sed -i "s:HOME_DIRECTORY:$HOME:" "$CONFIG_DIR"/conf.txt
}
