#! /usr/bin/env bash

set -e

# Temp link to use to bypass hard-coded ROUTINO_XML_PATH
link=${OWD}/rout

echo ${link}

# If a link already exist, delete it first
[ -L ${link} ] && rm ${link}

# Set bypass link
ln -s $APPDIR ${link}

# Start QMapShack
${APPDIR}/usr/bin/qmapshack "$@"

# Remove link when QMapShack finished
[ -L ${link} ] && rm ${link}
