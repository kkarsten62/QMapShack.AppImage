 ## Work In Progress!
---
# QMapShack.AppImage
Feasibility study to build **ONE single QMapShack executable file** based on **QMapShack** latest development commits by using **Docker** and **AppImage**.

* You are using a Linux distribution like Ubuntu, Fedora, Mint, ... ?
* And you are not coding by your self?
* So you would like not to set up a complex build environment on your computer?
* But you would like to review and test the latest development commits?

Then, may be you could use a ready to go one-click QMapshack.AppImage executable file.
## Requirements
* Computer with 64-bit architecture
* A Linux distribution - able to run Docker Software
* At least ~5 GB free disk space
* 1-2 hour for the initial Docker image build
* 5 minutes for each development update
* Some Linux skills to handle a terminal
## Be aware
* You are using software from a development branch. QMapShack is most of time quite stable during development process - but there is no guarantee!
* This setup is valid as long as there are no changes in the prerequisites to build QMakeShack (ex. CMakefile.txt, PROJ, GDAL, CMake, etc.). Then the Dockerfile needs to be updated according to the changes of the new prerequisites.
* When already using a stable QMapShack version it is advice to **backup** the existing personal QMapShack data (Tracks, Routes, DBs, etc.) prior for using QMapShack.AppImage. Do not forget to save your setting files also:

		cp -r ~/.config/QLandkarte ~/.config/QLandkarte.bak
	
* The Docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user `root` and other users can only access it using `sudo`. The Docker daemon always runs as the `root` user. So please be carefull in using with root access rights (sudo). See <https://docs.docker.com/engine/install/linux-postinstall/> for more details.
## Using a ready to go one-click QMapshack.AppImage
If you prefer to use an already build QMapshack.AppImage executable file based on one of the latest development commits you can download it from here.
No further installation is required then - *have fun with QMapshack.AppImage*.

#### [Download on Wiki](https://github.com/kkarsten62/QMapShack.AppImage/wiki)

# Installation
## Install Docker
Details about Docker and the installation steps for the wide range of Linux distribution can be found here:
<https://docs.docker.com/engine/install/>

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
The Docker image based on the following software components:

* Ubuntu 18.04
	* plus all needed and updated Ubuntu packages
	* plus Qt 5.9.5
	* plus CMake 3.20.0
	* plus PROJ 8.0.0
	* plus GDAL 3.2.2
	* plus QUAZIP 1.1
	* plus Routino 3.3.3
	* plus QMapshack development branch

Build the image:

	sudo docker build -t qms-appimage:0.0.0 .

*Be patient and take a coffee, build process will take some time - about 1-2 hours.*

Check for latest information in terminal:

	=====================================================
	QMapShack.AppImage Docker image successfully created
	=====================================================

## Run Docker image
With `docker run` a Docker container will be created based on the Docker image.

Steps on Docker Run:

* Download (pull) new commits from QMapShack development branch
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

*Note: Run again when new commits are in the QMapShack development branch. **And** think about to backup an existing `QMapShack-x86_64.AppImage` in `out` folder prior to the rerun.*

Additionally you can enter into the container using a bash run:

	cd ~/GPS/qmapshack-AppImage
	sudo docker run -it --privileged --rm -v $(pwd)/out:/out -e USER_ID=$(id -u):$(id -g) qms-appimage:0.0.0

Use `exit` to step out.

# Start QMapShack.AppImage
	cd ~/GPS/qmapshack-AppImage/out
	./QMapShack-x86_64.AppImage [options]
	
The `[options]` can be set according to QMapShack commandline options, see <https://github.com/Maproom/qmapshack/wiki/DocCmdOptions> for more details.

# Mount or extract QMapShack.AppImage
See <https://docs.appimage.org/user-guide/run-appimages.html#mount-an-appimage>
## Mount
	cd ~/GPS/qmapshack-AppImage/out
	./QMapShack-x86_64.AppImage --appimage-mount

Now, use another terminal or file manager to inspect the content of QMapShack.AppImage in the folder printed by `--appimage-mount`.

## Extract
	cd ~/GPS/qmapshack-AppImage/out
	./QMapShack-x86_64.AppImage --appimage-extract

A new folder called `squashfs-root` is created, containing the content of QMapShack.AppImage.

# Known issues and topics
## Build tested on:
* Ubuntu 18.04
* Ubuntu 20.04
* Fedora 33

Only some build test performed so far. **Deep functional tests with tracks, routes, waypoints, maps, DEMS, Routino, DB, etc. needs still to be done.**
## ROUTINO_XML_PATH
Seen from AppImage the path `ROUTINO_XML_PATH` is a hard-coded path in QMapShack.
Current bypass solution according to <https://docs.appimage.org/packaging-guide/manual.html> is by setting a temp link during QMapShack run time.
## Docker Ubuntu images are disk space consuming
Room for Improvement could be to change from Ubuntu to a more lightweight distribution (Alpine Linux?) to reduce the needed disk space.
## Troubleshooting
### Mixing up different versions of QMapShack
In a case of a strange behaviour in handling of QMapShack, it may help to delete the configuration. **Be aware:** All your personal settings for the GUI will be lost. Finish QMapShack first. Before doing so, however, back up the existing configuration. QMapShack will then start with the default configuration. 

	cp -r ~/.config/QLandkarte ~/.config/QLandkarte.bak
	rm -rf ~/.config/QLandkarte

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
