#!/usr/bin/env bash

set -e

# Make and install QMapShack
# Use "git pull <commit|tag|branch>" when compiling for a specific commit
cd /qmapshack
git pull
cd /build
make qmapshack -j$(nproc)
make install DESTDIR=/AppDir
cd /

# Identify OS (ubuntu, fedora, manajaro, ...)
OS_VERSION=$(cat /etc/os-release | sed -n '/^ID=/s/ID=//p')
OS_VERSION_ID=$(cat /etc/os-release | sed -n '/^VERSION_ID=/s/VERSION_ID=//p')

# Bypass hard-coded QMapshack pathes, used to copy data to /tmp
# for pathes: "/usr/share/routino", "/usr/share/doc/HTML"
# According to https://docs.appimage.org/packaging-guide/manual.html
sed -i -e 's|/usr/share/routino|/tmp/qmsappimg/rto|g' /AppDir/usr/bin/qmapshack
sed -i -e 's|/usr/share/doc/HTML|/tmp/qmsappimg/HTML|g' /AppDir/usr/bin/qmapshack

export LD_LIBRARY_PATH="/AppDir/Qt/6.8.3/gcc_64/lib"
export PATH=${PATH}:"/AppDir/Qt/6.8.3/gcc_64/bin"

# Build deploy command
	# --plugin qt \
DEPLOY_CMD="./linuxdeploy-x86_64.AppImage \
	--desktop-file /AppDir/usr/share/applications/qmapshack.desktop \
	--icon-file /AppDir/usr/share/icons/hicolor/128x128/apps/QMapShack.png \
	--appdir AppDir \
	--custom-apprun=/apprun.sh \
	--output appimage"

# Check for OS Ubuntu and add needed libs for Ubuntu
if [[ $OS_VERSION == "ubuntu" && $OS_VERSION_ID == "22.04" ]]; then
    DEPLOY_CMD="$DEPLOY_CMD \
	--library /usr/lib/x86_64-linux-gnu/nss/libsoftokn3.so \
	--library /usr/lib/x86_64-linux-gnu/nss/libnssckbi.so"
fi

# Workaround for glibc = 2.36 (ldd) update causes dynamic dependency failure
# See https://github.com/linuxdeploy/linuxdeploy/issues/210
# GLIBC_VERSION=$(ldd --version | sed 1q | sed "s/ldd (GNU libc) // g")
# if [[ $GLIBC_VERSION == "2.36" ]]; then
#	mv /usr/bin/ldd{,.ori}
#	printf '#!/usr/bin/env bash\nldd.ori "$@" | grep -v linux-vdso | grep -v ld-linux\n' > /usr/bin/ldd
#	chmod 777 /usr/bin/ldd
# fi

# KKA, 2024-06-03: Workaround for "Strip call error" in linuxdeploy
# First seen on Fedora 40 and Manjaro 20240602
# See https://github.com/linuxdeploy/linuxdeploy/issues/272
if [[ ($OS_VERSION == "fedora" && $OS_VERSION_ID == "40") || \
	($OS_VERSION == "manjaro") ]]; then
	export NO_STRIP=true
fi

# Run deploy
$DEPLOY_CMD

# Run deploy for Qt
# For missing libqsqlmimer, see https://forum.qt.io/topic/154845/libmimerapi-so-not-found
#./linuxdeployqt-continuous-x86_64.AppImage /AppDir/usr/bin/qmapshack -unsupported-allow-new-glibc -exclude-libs=libqsqlmimer
./linuxdeployqt-continuous-x86_64.AppImage /AppDir/usr/bin/qmapshack -exclude-libs=libqsqlmimer

# Change back workaround for glibc = 2.36
# if [[ $GLIBC_VERSION == "2.36" ]]; then
#	mv /usr/bin/ldd{.ori,}
# fi

# Copy AppImage to host file system folder
mv QMapShack-x86_64.AppImage /out

# And finally change AppImage to user and group id
if [[ -v USER_ID ]]; then
	chown $USER_ID /out
	chown $USER_ID /out/QMapShack-x86_64.AppImage
fi

echo -e "\n\n===================================================" \
	"\nQMapShack.AppImage file successfully created!" \
	"\nCheck 'out' folder for new QMapShack.AppImage file." \
	"\n===================================================\n\n"
