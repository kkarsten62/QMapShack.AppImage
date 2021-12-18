# QMapShack.AppImage
Build **ONE single QMapShack executable file** based on **QMapShack** latest development commits by using **Docker** and **AppImage**.

* You are using a Linux distribution like Ubuntu, Fedora, openSUSE, Manjaro, ... ?
* And you are not coding by your self?
* So you would like not to set up a complex build environment on your computer?
* But you would like to review and test the latest development commits?

Then, may be you could use a ready to go one-click QMapshack.AppImage executable file.
## Available QMapShack.AppImage Dockerfiles
Not all QMapshack.AppImage builds will support all actual Linux desktop distributions. So therefore different QMapShack.AppImage Docker build files are available to support different Linux distributions. Reasons and details behind can be found [here](https://docs.appimage.org/introduction/concepts.html).

The following table shows the different available QMapShack.AppImage Docker build files with the different used software components versions.

|Dockerfile_|CMake|Qt|PROJ|GDAL|Routino|GLIBC|Desktop|
|:-|:-:|:-:|:-:|-:|:-:|:-:|:-:|
|Ubuntu-18.04|3.20.0|5.9.5|8.2.0|3.2.2|3.3.3|2.27|GNOME/X|
|Fedora-33|3.19.7|5.15.2|8.2.0|3.2.2|3.3.3|2.32|GNOME/X|
|openSUSE-15.2|3.17.0|5.12.7|8.2.0|3.2.2|3.3.3|2.26|KDE|
|Manjaro-21.2rc1|3.22.1|5.15.2|8.2.0|3.2.2|3.3.3|2.33|GNOME/X|

### Compatible matrix
The following table will shows the different tested Linux desktop distributions for the available QMapShack.AppImage Docker build files.

|Linux Distribution/Dockerfile_|Ubuntu-18.04|Fedora-33|openSUSE-15.2|Manjaro-21.2rc1|
|:-|:-:|:-:|:-:|:-:|
|Ubuntu 18.04|Yes|No|No|No|
|Ubuntu 20.04|Yes|No|No|No|
|Fedora 33|No|Yes|No|No|
|Fedora 34|No|Yes|No|No|
|Fedora 35|No|Yes|No|Yes|
|openSUSE Leap 15.2|No|No|Yes|No|
|openSUSE Leap 15.3|No|No|Yes|No|
|Manjaro 21.2rc1|No|Yes|Yes|Yes|

## Requirements
* Computer with 64-bit architecture (x86_64)
* A Linux distribution - able to run Docker Software
* At least ~5 GB free disk space
* 1-2 hour for the initial Docker image build
* 5 minutes for each development update
* Some Linux skills to handle a terminal
## Be aware
* You are using software from a development branch. QMapShack is most of time quite stable during development process - but there is no guarantee!
* This setup is valid as long as there are no changes in the prerequisites to build QMakeShack (ex. CMakefile.txt, PROJ, GDAL, CMake, etc.). Then the Dockerfile needs to be updated according to the changes of the new prerequisites.
* When already using a stable QMapShack version it is advice to **backup** your existing personal QMapShack data (Tracks, Routes, DBs, Maps, etc.) prior for using QMapShack.AppImage. Do not forget to save your setting files also, for example in a Ubuntu and Fedora environment:

		cp -r ~/.config/QLandkarte ~/.config/QLandkarte.bak
	
* The Docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user `root` and other users can only access it using `sudo`. The Docker daemon always runs as the `root` user. So please be carefull in using with root access rights (sudo). See [here](https://docs.docker.com/engine/install/linux-postinstall/) for more details.
## Using a ready to go one-click QMapshack.AppImage
If you prefer to use an already build QMapshack.AppImage executable file based on one of the latest development commits you can download it from here.
### [Download on Wiki](https://github.com/kkarsten62/QMapShack.AppImage/wiki)
Choose one of the existing executable downloads which fits best to your Linux distribution. No further installation is required. One click and QMapShack should start.
*Have fun with QMapshack.AppImage.*
# Installation
## Install Docker
Details about Docker and the installation steps for the wide range of Linux distribution can be found [here](https://docs.docker.com/engine/install/). An external installation guide for openSUSE installation can be found [here](https://www.osradar.com/install-docker-opensuse-15-2-15-1/), and for Manjaro [here](https://linuxconfig.org/manjaro-linux-docker-installation).

Verify that Docker Engine is installed correctly by running the `hello-world` image.

	sudo docker run hello-world
	
## Download QMapShack.AppImage Git repository
Create a folder of your choice, example `GPS` or choose an existing one:

	mkdir GPS
	cd ~/GPS

Download repository from GitHub:

	git clone https://github.com/kkarsten62/QMapShack.AppImage.git
	cd QMapShack.AppImage

## Build Docker image
Build the image:

	sudo docker build -t qms-appimage:0.0.0 --no-cache --file <dockerfile> .

For example:

	sudo docker build -t qms-appimage:0.0.0 --no-cache --file Dockerfile_Ubuntu-18.04 .

*Note:*
* Be patient and take a coffee, build process will take some time - about 1-2 hours.
* To save time, the `--no-cache` option can be omitted during testing, but should be set on final build run.

Check for latest information in terminal:

	=====================================================
	QMapShack.AppImage Docker image successfully created
	=====================================================

## Run Docker image
With `docker run` a Docker container will be created based on the Docker image.

Steps on Docker Run:

* Download (pull) latest development commits from QMapShack development branch
* Build new QMapShack version
* Run AppImage build process to build one executable file
* Copy final QMapShack.AppImage  executable file to `out` folder

Start building new QMapShack version with:

	cd ~/GPS/qmapshack-AppImage
	sudo docker run -it --privileged --rm -v $(pwd)/out:/out -e USER_ID=$(id -u):$(id -g) qms-appimage:0.0.0 /build_AppImage.sh
Check for latest information in terminal:

	===================================================
	QMapShack.AppImage file successfully created!
	Check 'out' folder for new QMapShack.AppImage file
	===================================================

*Note:*
* Run again when new development commits are in the QMapShack development branch, check [here](https://github.com/Maproom/qmapshack/commits/dev).
* And think about to **backup** an existing `QMapShack-x86_64.AppImage` in `out` folder prior to the rerun.

Additionally you can enter into the Docker container by using a bash shell to inspect the content:

	cd ~/GPS/qmapshack-AppImage
	sudo docker run -it --privileged --rm -v $(pwd)/out:/out -e USER_ID=$(id -u):$(id -g) qms-appimage:0.0.0

Use `exit` to step out.

# Start QMapShack.AppImage
	cd ~/GPS/qmapshack-AppImage/out
	./QMapShack-x86_64.AppImage [options]
	
The `[options]` can be set according to QMapShack commandline options, see [here](https://github.com/Maproom/qmapshack/wiki/DocCmdOptions/) for more details.

# Mount or extract QMapShack.AppImage
See [here](https://docs.appimage.org/user-guide/run-appimages.html#mount-an-appimage/) for detailed information.
## Mount
	cd ~/GPS/qmapshack-AppImage/out
	./QMapShack-x86_64.AppImage --appimage-mount

Now, use another terminal or file manager to inspect the content of QMapShack.AppImage in the folder printed by `--appimage-mount`.

## Extract
	cd ~/GPS/qmapshack-AppImage/out
	./QMapShack-x86_64.AppImage --appimage-extract

A new folder called `squashfs-root` is created, containing the content of QMapShack.AppImage.

# Known issues
## ROUTINO_XML_PATH
Seen from AppImage the path `ROUTINO_XML_PATH` is a hard-coded path in QMapShack.
Current bypass solution according to this [information](https://docs.appimage.org/packaging-guide/manual.html/) is by setting a temp link named `rout` during QMapShack run time. The link will be removed when finishing QMapShack.
# Troubleshooting
## Mixing up different versions of QMapShack
In a case of a strange behaviour in handling of QMapShack, it may help to delete the configuration. **Be aware:** All your personal settings for the GUI will be lost. Finish QMapShack first. Before doing so, however, back up the existing configuration. QMapShack will then start with the default configuration. 

	cp -r ~/.config/QLandkarte ~/.config/QLandkarte.bak
	rm -rf ~/.config/QLandkarte

A good practices could be also to start QMapShack.AppImage with a dedicated configration file using `-c` option to avoid conflicts with an existing QMapShack installation, like:

	./QMapShack.AppImage -c myConfigFile.conf
---
# Credits
Many thanks to `harenber` for the base idea and approach.
<https://hub.docker.com/r/harenber/qmapshack-appimage>

Thanks to Docker - To make DevOps life easier.
<https://www.docker.com/>

Thanks to AppImage  -To bring it to the point.
<https://appimage.org/>

And a big thanks to the QMapShack community for the stable and continuous development.
<https://github.com/Maproom/qmapshack/wiki>
