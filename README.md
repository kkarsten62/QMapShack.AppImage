 # !!Work In Progress!!
---
# QMapShack.AppImage
Feasibility study to build **one single QMapShack executable file** based on **QMapShack** latest development commits by using **Docker** and **AppImage**.

* You are using a Linux distribution like Ubuntu, Fedora, Mint, ... ?
* And you are not coding by your self?
* And you would like not to set up the complex build ennvironment on your computer?
* But you would like to review and test the latest development commits?

Then, may be you could use a ready to go QMapshack AppImage file.
# Requirements
* Computer with 64-bit architecture
* A Linux distribution - able to run Docker Software
* About 10 GB free disk space
* 1-2 hour for the initial base build
* 5 minutes on each development update
* Some Linux skills to handle a terminal
# Installation
## Install Docker
Details about Docker and the installation steps for the wide range of Linux distribution can be found here:
<https://docs.docker.com/engine/install/>

Verify that Docker Engine is installed correctly by running the `hello-world` image.

	sudo docker run hello-world
	
## Download QMapShack.AppImage Git Repository
Create a folder of your choice, example `GPS` or choose an existing one:

	mkdir GPS
	cd ~/GPS

Download git repository from GitHub:

	git clone https://github.com/kkarsten62/qmapshack-AppImage.git
	cd qmapshack-AppImage
## Build BASE Docker image
The Docker image includes the following software components:

* Ubuntu 18.04
* plus all needed and updated packages
* plus PROJ 8.0.0
* plus GDAL 3.2.2
* plus QUAZIP 1.1
* plus Routino 3.3.3
* plus QMapshack development branch, with latest commits from 2021-03-27

Build the image:

	sudo docker build -t qmapshack-AppImage:0.0.0 .
*Be pateint and take a coffee, build process will take some time - about 1-2 hours.*

Check for last information in terminal:

***QMapShack.AppImage BASE image successfully created!***

## Run Docker image
With `docker run` a Docker container will be created based on the Docker image.

Steps on Docker Run:

* Check for new commits in QMapShack development branch
* Build new QMapShack version
* Run AppImage build process
* Copy final QMapShack.AppImage to `out` folder

Start building new QMapShack version with:

	sudo docker run -it --privileged --rm -v $(pwd)/out:/out -e USER_ID=$(id -u):$(id -g) qmapshack-AppImage:0.0.0 /build_AppImage.sh

*Note: Run again when new commits are in the QMapShack development branch. **And** think about to backup an existing `QMapShack-x86_64.AppImage` in `out` folder prior to the rerun.*

# Start QMapShack-AppImage
	./out/QMapShack-x86_64.AppImage

## Tested on
* Ubuntu 18.04
* Ubuntu 20.04
* Fedora 33
# Known issues and topics
## Unknown Routino Qt translation files
When starting a message box appears stating that a language file is missing.
Right now there is no solution to fix.
## Docker Ubuntu images are disk space consuming
Room for Improvement could be to change from Ubuntu to a more lightweight distribution (Alpine Linux?) to reduce the needed disk space.

# Credits
Many thanks to `harenber` for the base idea and approach.
<https://hub.docker.com/r/harenber/qmapshack-appimage>

Thanks to Docker - To make DevOps life easier.
<https://www.docker.com/>

Thanks to AppImage  -To bring it to the point.
<https://appimage.org/>

Big thanks to the QMapShack community for the stable and continuous development.
<https://github.com/Maproom/qmapshack/wiki>
