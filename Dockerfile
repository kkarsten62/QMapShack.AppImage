FROM ubuntu:18.04

LABEL description="QMapShack.AppImage development build - Base"

# Update packages and install UbuntuGIS repository
RUN apt-get -y update \
	&& apt-get -y install software-properties-common \
	&& add-apt-repository -y ppa:ubuntugis/ppa \
	&& apt-get -y update \
	&& apt-get -y dist-upgrade
	
# Install needed packages
RUN apt-get -y install build-essential subversion git kmod fuse sqlite3 \
		qt5-default qttools5-dev libqt5webkit5-dev qtscript5-dev qttools5-dev-tools \
		libqt5sql5-mysql qtwebengine5-dev qtdeclarative5-dev-tools \
		libghc-bzlib-dev libgraphics-magick-perl default-libmysqlclient-dev libgdal-dev \
		libpython3-dev

# Install CMake latest version, needed for QUAZIP
# See https://apt.kitware.com/
RUN apt-get -y install apt-transport-https ca-certificates gnupg software-properties-common wget \
	&& wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
	&& apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ bionic main' \
	&& apt-get update \
	&& apt-get -y install cmake

# Reinstall kernel to load fuse module
RUN apt-get -y install --reinstall linux-image-5.4.0-70-generic

# Install PROJ 8.0.0
# See https://proj.org/
RUN wget https://download.osgeo.org/proj/proj-8.0.0.tar.gz \
	&& tar xzvf proj-8.0.0.tar.gz \
	&& cd proj-8.0.0 \
	&& mkdir build \
	&& cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
	&& cmake --build . -j2 \
	&& cmake --build . --target install \
	&& cd / \
	&& rm -rf proj-8.0.0.tar.gz proj-8.0.0

# Install GDAL 3.2.2
# See https://gdal.org/
RUN wget https://github.com/OSGeo/gdal/releases/download/v3.2.2/gdal-3.2.2.tar.gz \
	&& tar xvzf gdal-3.2.2.tar.gz \
	&& cd gdal-3.2.2 \
	&& ./configure --prefix=/usr \
	&& make -j2 \
	&& make install \
	&& cd / \
	&& rm -rf gdal-3.2.2.tar.gz gdal-3.2.2

# Install QUAZIP 1.1
# See https://stachenov.github.io/quazip/
RUN wget https://github.com/stachenov/quazip/archive/refs/tags/v1.1.tar.gz \
	&& tar xvzf v1.1.tar.gz \
	&& cd quazip-1.1 \
	&& mkdir build \
	&& cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
	&& cmake --build . -j2 \
	&& cmake --build . --target install \
	&& cd / \
	&& rm -rf xvzf v1.1.tar.gz quazip-1.1

# Install Routino 3.3.3
# See http://www.routino.org/
RUN svn co http://routino.org/svn/trunk routino \
	&& cd routino \
	&& sed -i '48 s|/usr/local|/usr|' Makefile.conf \
	&& make -j2 \
	&& make install	\
	&& cd / \
	&& rm -rf routino

# Install QMapShack, latest development commit
# See https://github.com/Maproom/qmapshack
RUN git clone https://github.com/Maproom/qmapshack.git QMapShack \
	&& mkdir build_QMapShack \
	&& cd build_QMapShack \
	&& cmake ../QMapShack \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DBUILD_QMAPTOOL=OFF \
	&& make qmapshack -j2 \
	&& make install DESTDIR=/AppDir \
	&& cd /

# Copy needed PROJ, GDAL, routino data to AppImage folder
RUN cp -R /usr/share/gdal /AppDir/usr/share \
	&& cp -R /usr/share/proj /AppDir/usr/share \
	&& cp -R /usr/share/routino /AppDir/usr/share

# Copy the needed scripts from host to root used by docker run
COPY --chown=root:root build_AppImage.sh apprun.sh /

# Create folder to store image file to export to host
RUN mkdir /out

# Prepare AppImage
# See https://docs.appimage.org/packaging-guide/from-source/linuxdeploy-user-guide.html
RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage \
	&& wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage \
	&& chmod +x linuxdeploy*.AppImage

# Cleansing to reduce space
RUN apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/*

# Docker run will open a bash as default
CMD ["/bin/bash"]

RUN echo "\n\n=====================================================" \
	&& echo "QMapShack.AppImage Docker image successfully created!" \
	&& echo "=====================================================\n\n"
