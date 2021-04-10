#! /usr/bin/env bash

# Make and install QMapShack
cd /QMapShack
git pull
cd /build_QMapShack
make qmapshack -j$(nproc)
make install DESTDIR=/AppDir
cd /

# Bypass hard-coded ROUTINO_XML_PATH
# used to link in the mounted squashfs
# According to https://docs.appimage.org/packaging-guide/manual.html
sed -i -e 's|/usr/share/routino|rout/share/routino|g' /AppDir/usr/bin/qmapshack

# Build AppImage
./linuxdeploy-x86_64.AppImage \
	--desktop-file /AppDir/usr/share/applications/qmapshack.desktop \
	--icon-file /AppDir/usr/share/icons/hicolor/128x128/apps/QMapShack.png \
	--appdir AppDir \
	--plugin qt \
	--custom-apprun=/apprun.sh \
	--output appimage

# Copy AppImage to host file system folder
mv QMapShack-x86_64.AppImage /out

# And finally change AppImage to user and group id
if [[ -v USER_ID ]];
then
	chown $USER_ID /out/QMapShack-x86_64.AppImage
fi

echo -e "\n\n===================================================" \
	"\nQMapShack.AppImage file successfully created!" \
	"\nCheck 'out' folder for new QMapShack.AppImage file." \
	"\n===================================================\n\n"
