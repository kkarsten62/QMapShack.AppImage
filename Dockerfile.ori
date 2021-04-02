FROM ubuntu:18.04

RUN apt-get update && apt-get -y dist-upgrade && apt-get -y install software-properties-common && add-apt-repository -y  ppa:ubuntugis/ppa 
RUN apt-get -y install build-essential subversion mercurial qt5-default qttools5-dev qttools5-dev-tools libqt5webkit5-dev qtscript5-dev libgdal-dev gdal-bin libghc-bzlib-dev libquazip5-dev libalglib-dev libgdal-grass qtwebengine5-dev git sed wget libsqlite3-dev sqlite3 qtdeclarative5-dev-tools libgraphics-magick-perl swig libpython3-dev python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev fakeroot fuse python3-gdal libbz2-dev


RUN cd /tmp && wget https://github.com/Kitware/CMake/releases/download/v3.19.2/cmake-3.19.2-Linux-x86_64.tar.gz && tar xzf cmake-3.19.2-Linux-x86_64.tar.gz && cd cmake-3.19.2-Linux-x86_64 && tar cpf - * | (cd /usr; tar xpf -)
RUN pip3 install appimage-builder && wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /opt/appimagetool && cd /opt/; chmod +x appimagetool; sed -i 's|AI\x02|\x00\x00\x00|' appimagetool; ./appimagetool --appimage-extract && mv /opt/squashfs-root /opt/appimagetool.AppDir && ln -s /opt/appimagetool.AppDir/AppRun /usr/local/bin/appimagetool

RUN cd / && wget https://github.com/stachenov/quazip/archive/v0.9.1.tar.gz && tar xzf v0.9.1.tar.gz && cd quazip-0.9.1 && mkdir /quazip_build && cmake -DCMAKE_INSTALL_PREFIX=/usr -S . -B /quazip_build && cd /quazip_build && make -j 6 && make install && cd / && rm -rf /quazip_build /quazip-0.9.1 v0.9.1.tar.gz		       

RUN cd / && wget https://download.osgeo.org/proj/proj-7.2.1.tar.gz && tar xvzf proj-7.2.1.tar.gz && mkdir build_proj && cd build_proj && cmake -DCMAKE_INSTALL_PREFIX=/usr ../proj-7.2.1 && make -j 6 && make install && cd / && rm -rf build_proj proj-7.2.1.tar.gz
RUN svn co http://routino.org/svn/trunk routino && cd routino && sed -i.bak "s.prefix=/usr/local.prefix=/usr.g" Makefile.conf && make -j 6 && make install && cd .. && rm -rf routino
RUN git clone https://github.com/Maproom/qmapshack
RUN mkdir build_QMapShack  && cd build_QMapShack && cmake --DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ../qmapshack/ && make -j 6 install DESTDIR=/AppDir

# https://docs.appimage.org/packaging-guide/from-source/native-binaries.html#examples
COPY build_AppImage.sh /
COPY apprun /
RUN cd /; mkdir /out; chmod +x apprun;  wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage; wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage ; chmod +x linuxdeploy*.AppImage

CMD ["/bin/bash"]
