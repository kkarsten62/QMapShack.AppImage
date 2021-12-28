#! /usr/bin/env bash

# set -x
set -e

echo -e "\n\n--- QMapShack.AppImage starting\n"

# Extend PATH to find planetsplitter and gdalbuildvrt
export PATH=${PATH}:${APPDIR}/usr/bin

# Temp link to use to bypass hard-coded ROUTINO_XML_PATH
link=${OWD}/rout
trap cleanup EXIT

# Remove link when script finished
cleanup() {
	[ -L ${link} ] && rm ${link}
}

# If a link already exist, delete it first
[ -L ${link} ] && rm ${link}

# Set bypass link
ln -s $APPDIR ${link}

# Start QMapShack with options
${APPDIR}/usr/bin/qmapshack "$@"

echo -e "\n--- QMapShack.AppImage finished\n"

