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
# KKA, 2025-12-03: Workaround for following error:
# "MESA: error: ZINK: vkCreateInstance failed (VK_ERROR_INCOMPATIBLE_DRIVER)"
# "glx: failed to create drisw screen"
# See https://github.com/yuk7/ArchWSL/issues/341
# Currently seen on OPENsuse Leap 15.6 and Fedora 43
export LD_LIBRARY_PATH=${APPDIR}/Qt/6.8.3/gcc_64/lib
if [[ ($OS_VERSION == "\"opensuse-leap\"" && $OS_VERSION_ID == "\"15.6\"") ||
	($OS_VERSION == "fedora" && $OS_VERSION_ID == "43") ]]; then
	export LIBGL_ALWAYS_SOFTWARE=1
	${APPDIR}/usr/bin/qmapshack "$@"
else
	${APPDIR}/usr/bin/qmapshack "$@"
fi

echo -e "\n--- QMapShack.AppImage finished\n"

