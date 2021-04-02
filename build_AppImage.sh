#!/bin/bash

# Copy needed PROJ and GDAL data to AppImage
cp -R /usr/share/gdal /AppDir/usr/share
cp -R /usr/share/proj /AppDir/usr/share
cp -R /usr/share/routino /AppDir/usr/share

# Run AppImage
./linuxdeploy-x86_64.AppImage \
	-l/usr/lib/x86_64-linux-gnu/nss/libsoftokn3.so \
	-l/usr/lib/x86_64-linux-gnu/nss/libnssckbi.so \
	--appdir AppDir --plugin qt --custom-apprun=/apprun \
	--output appimage

mv QMapShack-x86_64.AppImage /out
