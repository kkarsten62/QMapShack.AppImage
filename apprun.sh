#! /usr/bin/env bash

set -e

export GDAL_DATA=$APPDIR/usr/share/gdal

# Temp link to use to bypass hard-coded ROUTINO_XML_PATH
link=${OWD}/rout

echo ${link}

# If a link already exist delete it first
[ -L ${link} ] && rm ${link}

# Set bypass link
ln -s $APPDIR ${link}

# Start QMapShack with -d for debug mode
${APPDIR}/usr/bin/qmapshack $*

# Remove link when QMapShack finished
[ -L ${link} ] && rm ${link}
