#!/usr/bin/env bash

# set -x
set -e

echo -e "\n--- QMapShack.AppImage starting\n"

# Identify OS (ubuntu, fedora, manajaro, ...)
OS_VERSION=$(cat /etc/os-release | sed -n '/^ID=/s/ID=//p')
OS_VERSION_ID=$(cat /etc/os-release | sed -n '/^VERSION_ID=/s/VERSION_ID=//p')

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

# Start QMapShack with prestart setting and QMapShack options
# KKA, 2024-06-03: Workaround for following error:
# "MESA: error: ZINK: vkCreateInstance failed (VK_ERROR_INCOMPATIBLE_DRIVER)"
# "glx: failed to create drisw screen"
# See https://github.com/yuk7/ArchWSL/issues/341
# First seen on Fedora 40, Ubuntu 24.04 and Manjaro 20240602
if [[ ($OS_VERSION == "fedora" && $OS_VERSION_ID == "40") || \
	($OS_VERSION == "ubuntu" && $OS_VERSION_ID == '"24.04"') || \
	($OS_VERSION == "manjaro" ) ]]; then
	LIBGL_ALWAYS_INDIRECT=1 ${APPDIR}/usr/bin/qmapshack "$@"
else
	${APPDIR}/usr/bin/qmapshack "$@"
fi

echo -e "\n--- QMapShack.AppImage finished\n"

