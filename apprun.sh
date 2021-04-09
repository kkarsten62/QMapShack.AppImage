#! /usr/bin/env bash

set -x
set -e

echo -e "\n\n--- QMapShack.AppImage starting\n\n"

# Temp link to use to bypass hard-coded ROUTINO_XML_PATH
link=${OWD}/rout
trap cleanup EXIT
# Remove link when script finished
cleanup() {
	[ -L ${link} ] && rm ${link}
echo -e "\n\n--- QMapShack.AppImage  finished\n\n"
}

# If a link already exist, delete it first
[ -L ${link} ] && rm ${link}

# Set bypass link
ln -s $APPDIR ${link}

# Start QMapShack with options
${APPDIR}/usr/bin/qmapshack "$@"
