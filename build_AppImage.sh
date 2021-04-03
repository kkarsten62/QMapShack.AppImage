#!/bin/bash

# Run make for QMapShack
cd /QMapShack
git pull
cd /build_QMapShack
make qmapshack -j2
make install DESTDIR=/AppDir
cd /

# Run AppImage
./linuxdeploy-x86_64.AppImage \
	-l/usr/lib/x86_64-linux-gnu/nss/libsoftokn3.so \
	-l/usr/lib/x86_64-linux-gnu/nss/libnssckbi.so \
	--appdir AppDir --plugin qt --custom-apprun=/apprun.sh \
	--output appimage

# Copy to host volume folder
mv QMapShack-x86_64.AppImage /out

# And finally change to user and group id
if [[ -v USER_ID ]];
then
	chown $USER_ID /out/QMapShack-x86_64.AppImage
fi

echo -e "\n\n===================================================" \
	"\nQMapShack.AppImage file successfully created!" \
	"\nCheck 'out' folder for new QMapShack.AppImage file." \
	"\n===================================================\n\n"
