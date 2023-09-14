#! /usr/bin/env bash

set -e

# Make and install QMapShack
# Comment  "git pull" when compiling a specific version by using git checkout TAG/VERSION
cd /QMapShack
# git pull
cd /build_QMapShack
make qmapshack -j$(nproc)
make install DESTDIR=/AppDir
cd /

# Identify OS (ubuntu, fedora, manajaro, ...)
OS=$(cat /etc/os-release | sed -n '/^ID=/s/ID=//p')

# Bypass hard-coded QMapshack pathes, used to copy data to /tmp
# /usr/share/routino, /usr/share/doc/HTML
# According to https://docs.appimage.org/packaging-guide/manual.html
sed -i -e 's|/usr/share/routino|/tmp/qmsappimg/rto|g' /AppDir/usr/bin/qmapshack
sed -i -e 's|/usr/share/doc/HTML|/tmp/qmsappimg/HTML|g' /AppDir/usr/bin/qmapshack

# Deploy AppImage
DEPLOY_CMD="./linuxdeploy-x86_64.AppImage \
	--desktop-file /AppDir/usr/share/applications/qmapshack.desktop \
	--icon-file /AppDir/usr/share/icons/hicolor/128x128/apps/QMapShack.png \
	--appdir AppDir \
	--plugin qt \
	--custom-apprun=/apprun.sh \
	--output appimage"

# Check for OS Ubuntu and add needed libs for Ubuntu
if [ $OS = "ubuntu" ]; then
    DEPLOY_CMD="$DEPLOY_CMD \
        --library /usr/lib/x86_64-linux-gnu/nss/libsoftokn3.so \
        --library /usr/lib/x86_64-linux-gnu/nss/libnssckbi.so"
fi

# Workaround for glibc = 2.36 (ldd) update causes dynamic dependency failure
# See https://github.com/linuxdeploy/linuxdeploy/issues/210
# GLIBC_VERSION=$(ldd --version | sed 1q | sed "s/ldd (GNU libc) // g")
# if [ $GLIBC_VERSION = "2.36" ]; then
#	mv /usr/bin/ldd{,.ori}
#	printf '#!/usr/bin/env bash\nldd.ori "$@" | grep -v linux-vdso | grep -v ld-linux\n' > /usr/bin/ldd
#	chmod 777 /usr/bin/ldd
# fi

# Run deploy
$DEPLOY_CMD

# Change back workaround for glibc = 2.36
# if [ $GLIBC_VERSION = "2.36" ]; then
#	mv /usr/bin/ldd{.ori,}
# fi

# Copy AppImage to host file system folder
mv QMapShack-x86_64.AppImage /out

# And finally change AppImage to user and group id
if [[ -v USER_ID ]]; then
	chown $USER_ID /out/QMapShack-x86_64.AppImage
fi

echo -e "\n\n===================================================" \
	"\nQMapShack.AppImage file successfully created!" \
	"\nCheck 'out' folder for new QMapShack.AppImage file." \
	"\n===================================================\n\n"
