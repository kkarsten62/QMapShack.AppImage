# qmapshack-AppImage
Dockerfile to create an AppImage of [QMapShack](https://github.com/Maproom/qmapshack)

This is an approach to build an AppImage of qmapshack using Docker. I used it as the QMapShack version that ships with Ubuntu 18 is terribly old, but I did not want to install all development packages on my laptop.

It's based on Ubuntu 18, hence the AppImage will not run on Ubuntu 16 anymore. But as Ubuntu 16 lacks one Qt library, I wasn't able to use it as a basis.

QMapShack will be created during **build** time of the container, the AppImage wil be created during **run time** into the directory /out, you need to copy the resulting image then out of the container.

The build can take a *significant* amount of time!

Exmaple to build from source:

```bash
git clone https://github.com/harenber/qmapshack-AppImage
cd qmapshack-AppImage
docker build -t local:qms .
docker run -it --privileged --rm local:qms
```

Or download from docker hub

```
docker run -it --privileged --rm harenber/qmapshack-appimage

```
then, inside the container:

```bash
./build_AppImage.sh 
```

after a couple of minutes, the AppImage is in /out:

```
root@0943fa3ec3cd:/out# ls
QMapShack-x86_64.AppImage
```

copy the image out of the container, use either scp or run the container with a bind-mount.

There is still a warning message when you start QMapShack on your maschine, you can ignore that.
