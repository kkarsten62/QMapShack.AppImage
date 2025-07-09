# 1. QMapShack.AppImage

---
*Note:*

Status of `2025-07-06`

QMapShack version 1.18.0 is available. QMapShack.AppImages are still referring to QMapShack version 1.17.1. New QMapShack.AppImages will be build as soon there is progress in new development based on version 1.18.0.

---

Build **ONE single QMapShack executable file** based on **QMapShack** latest development commits by using **Docker** and **AppImage**.

* You are using a Linux distribution like Ubuntu, Fedora, openSUSE, Manjaro, ... ?
* And you are not coding by your self?
* So you would like not to set up a complex build environment on your computer?
* But you would like to review and test the latest development commits?

Then, may be you could use a ready to go one-click QMapshack.AppImage executable file.

## 1.1. QMapShack.AppImage Dockerfiles in service

Not all QMapshack.AppImage builds will support all actual Linux desktop distributions. So therefore different QMapShack.AppImage Docker build files are available to support different Linux distributions. Reasons and details behind can be found [here](https://docs.appimage.org/introduction/concepts.html).

The following table shows the different available QMapShack.AppImage Docker build files with the different used software components versions.

|Dockerfile_|CMake|Qt|PROJ|GDAL|QuaZIP|Routino|GLIBC|Desktop|
|:-|:-|:-|:-|:-|:-|:-|:-|:-|
|Ubuntu-22.04|3.22.1|5.15.3|9.4.1|3.9.0|1.4|3.4.1|2.35|GNOME/X|
|Fedora-40|3.28.2|5.15.13|9.4.1|3.9.0|1.4|3.4.1|2.39|GNOME/X|
|openSUSE-15.5|3.20.4|5.15.8|9.3.1|3.8.1|1.4|3.4.1|2.31|KDE|
|Manjaro-20240602|3.29.3|5.15.13|9.4.1|3.9.0|1.4|3.4.1|2.39|GNOME/X|

### 1.1.1. Compatible matrix

The following table will shows the different tested Linux desktop distributions for the available QMapShack.AppImage Docker build files.

|Linux Distribution/Dockerfile_|Ubuntu-22.04|Fedora-40|openSUSE-15.5|Manjaro-20240602|
|:-|:-:|:-:|:-:|:-:|
|Ubuntu 22.04|Yes|No|Yes|No|
|Ubuntu 24.04|Yes|Yes|Yes|Yes|
|Fedora 40|Yes|Yes|Yes|No|
|openSUSE Leap 15.5|No|No|Yes|No|
|Manjaro 2024-06-02|Yes|Yes|Yes|Yes|

## 1.2. Requirements

* Computer with 64-bit architecture (x86_64)
* A Linux distribution - able to run Docker Software
* At least ~5 GB free disk space
* 1-2 hour for the initial Docker image build
* 5 minutes for each development update
* Some Linux skills to handle a terminal

## 1.3. Be aware

* You are using software from a development branch. QMapShack is most of time quite stable during development process - but there is no guarantee!
* This setup is valid as long as there are no changes in the prerequisites to build QMapShack (ex. CMakefile.txt, PROJ, GDAL, CMake, etc.). Then the Dockerfile needs to be updated according 
to the changes of the new prerequisites.
* When already using a stable QMapShack version it is advice to **backup** your existing personal QMapShack data (Tracks, Routes, DBs, Maps, etc.) prior for using QMapShack.AppImage. Do not forget to save your setting files also, for example in a Ubuntu and Fedora environment:

`cp -r ~/.config/QLandkarte ~/.config/QLandkarte.bak`
	
* The Docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user `root` and other users can only access it using `sudo`. The Docker daemon always runs as the `root` user. So please be carefull in using with root access rights (sudo). See [here](https://docs.docker.com/engine/install/linux-postinstall/) for more details.

## 1.4. Using a ready to go one-click QMapShack.AppImage

If you prefer to use an already build QMapshack.AppImage executable file based on one of the latest development commits you can download it from the Wiki page. In addition you will find older QMapShackAppImage which are out of service.

### 1.4.1. [Download from Wiki page](https://github.com/kkarsten62/QMapShack.AppImage/wiki)

Choose one of the existing executable downloads which fits best to your Linux distribution. No further installation is required. One click and QMapShack should start.
*Have fun with QMapshack.AppImage.*

# 2. Installation

## 2.1. Install Docker

Details about Docker and the installation steps for the wide range of Linux distribution can be found [here](https://docs.docker.com/engine/install/). An external installation guide for openSUSE can be found [here](https://www.osradar.com/install-docker-opensuse-15-2-15-1/), and for Manjaro [here](https://linuxconfig.org/manjaro-linux-docker-installation).

Verify that Docker Engine is installed correctly by running the `hello-world` image.

`sudo docker run hello-world`

## 2.2. Download QMapShack.AppImage Git repository

Create a folder of your choice, example `GPS` or choose an existing one:

`mkdir GPS`

`cd ~/GPS`

Download repository from GitHub:

`git clone https://github.com/kkarsten62/QMapShack.AppImage.git`

`cd QMapShack.AppImage`

## 2.3. Build Docker image

Build the image:
`sudo docker build -t qms-appimage:0.0.0 --no-cache --file <dockerfile> .`

For example:
`sudo docker build -t qms-appimage:0.0.0 --no-cache --file Dockerfile_Ubuntu-22.04 .`

*Note:*
* Be patient and take a coffee, build process will take some time - about 1-2 hours.
* To save time, the `--no-cache` option can be omitted during testing, but should be set on final build run.
* In newer Docker versions you can use option `--progress=plain` to obtain classical plain terminal output during build process.

Check for latest information in terminal:
```
=====================================================
QMapShack.AppImage Docker image successfully created
=====================================================
```

## 2.4. Run Docker image
With `docker run` a Docker container will be created based on the Docker image.

Steps on Docker Run:

* Download (pull) latest development commits from QMapShack development branch
* Build new QMapShack version
* Run AppImage build process to build one executable file
* Copy final QMapShack.AppImage  executable file to `out` folder

Start building new QMapShack version with:

`cd ~/GPS/qmapshack-AppImage`

`sudo docker run -it --privileged --rm -v $(pwd)/out:/out -e USER_ID=$(id -u):$(id -g) qms-appimage:0.0.0 /build_AppImage.sh`

Check for latest information in terminal:
```
===================================================
QMapShack.AppImage file successfully created!
Check 'out' folder for new QMapShack.AppImage file
===================================================
```
*Note:*
* Run again when new development commits are in the QMapShack development branch, check [here](https://github.com/Maproom/qmapshack/commits/dev).
* And think about to **backup** an existing `QMapShack-x86_64.AppImage` in `out` folder prior to the rerun.

Additionally you can enter into the Docker container by using a bash shell to inspect the content:

`cd ~/GPS/qmapshack-AppImage`

`sudo docker run -it --privileged --rm -v $(pwd)/out:/out -e USER_ID=$(id -u):$(id -g) qms-appimage:0.0.0`

Use `exit` to step out.

# 3. Start QMapShack.AppImage

`cd ~/GPS/qmapshack-AppImage/out`

`./QMapShack-x86_64.AppImage [options]`
	
The `[options]` can be set according to QMapShack commandline options, see [here](https://github.com/Maproom/qmapshack/wiki/DocCmdOptions/) for more details.

# 4. Mount or extract QMapShack.AppImage

See [here](https://docs.appimage.org/user-guide/run-appimages.html#mount-an-appimage/) for detailed information.

## 4.1. Mount

`cd ~/GPS/qmapshack-AppImage/out`

`./QMapShack-x86_64.AppImage --appimage-mount`

Now, use another terminal or file manager to inspect the content of QMapShack.AppImage in the folder printed by `--appimage-mount`.

## 4.2. Extract

`cd ~/GPS/qmapshack-AppImage/out`

`./QMapShack-x86_64.AppImage --appimage-extract`

A new folder called `squashfs-root` is created, containing the content of QMapShack.AppImage.

# 5. Known issues

## 5.1. Hard coded pathes in QMapShack

Seen from AppImage the pathes `/usr/share/routino (ROUTINO_XML_PATH)` and `/usr/share/doc/HTML` are hard-coded pathes in QMapShack binary file.
See [here](https://docs.appimage.org/packaging-guide/manual.html#no-hard-coded-paths) for more information. Current bypass is to copy at start of QMapShack.Appimage the routino profiles and help files to a /tmp folder.  The /tmp folder will be removed when QMapShack finished.

# 6. Troubleshooting

## 6.1. Mixing up different versions of QMapShack

In a case of a strange behaviour in handling of QMapShack, it may help to delete the configuration. **Be aware:** All your personal settings for the GUI will be lost. Finish QMapShack first. Before doing so, however, back up the existing configuration. QMapShack will then start with the default configuration. 

`cp -r ~/.config/QLandkarte ~/.config/QLandkarte.bak`

`rm -rf ~/.config/QLandkarte`

A good practices could be also to start QMapShack.AppImage with a dedicated configration file using `-c` option to avoid conflicts with an existing QMapShack installation, like:

`./QMapShack.AppImage -c myConfigFile.conf`

---

# 7. Credits

Many thanks to `harenber` for the base idea and approach.
<https://hub.docker.com/r/harenber/qmapshack-appimage>

Thanks to Docker - To make DevOps life easier.
<https://www.docker.com/>

Thanks to AppImage  -To bring it to the point.
<https://appimage.org/>

And a big thanks to the QMapShack community for the stable and continuous development.
<https://github.com/Maproom/qmapshack/wiki>

