#! /usr/bin/env bash

# set -x
set -e

echo -e "\n--- QMapShack.AppImage starting\n"

# Extend PATH to find planetsplitter and gdalbuildvrt
export PATH=${PATH}:${APPDIR}/usr/bin

# Clean up on exit in any case
trap cleanup EXIT

# Remove tmp files on exit
cleanup() {
	[ -d /tmp/qmsappimg ] && rm -rf /tmp/qmsappimg
}

# Copy data to /tmp to bypass hard coded pathes
[ -d /tmp/qmsappimg ] && rm -rf /tmp/qmsappimg
mkdir -p /tmp/qmsappimg
cp -r ${APPDIR}/usr/share/doc/HTML /tmp/qmsappimg/HTML
cp -r ${APPDIR}/usr/share/routino /tmp/qmsappimg/rto

# Start QMapShack with options
${APPDIR}/usr/bin/qmapshack "$@"

echo -e "\n--- QMapShack.AppImage finished\n"

