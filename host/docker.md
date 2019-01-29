---
permalink: /host/docker/
title: Setting up Docker
breadcrumb: Docker
---

# Setting up and testing Docker

Note: these instructions cover installing and testing Docker using preexisting container images.  They do NOT cover creating your own Docker container images.

# Docker concepts

This minimal non-technical introduction is designed for casual users.  For a more complete introduction, see the [Docker Overview](https://docs.docker.com/engine/docker-overview/) from the Docker online documentation.  There are also [Get Started](https://docs.docker.com/get-started/) pages, although they go into detail about creating containers.

A *container* is a self-contained system that includes everthing necessary to run an application on your computer.  It's similar to a *virtual machine*, except that it is not generic and includes only the components necessary to run the application.  Once you have deployed a container on your computer, you can start and stop it.  When it runs, it can change as you interact with it.  When you stop it, its state is "frozen" until the next time you start it up again.  It is possible to move the container elsewhere with its state preserved, or to delete it.  You can also deploy several containers of the same application at the same time, and use them for different purposes. 

An *image* as like a frozen, read-only image of a container that includes all of the information necessary to set it up as a running container.  It is possible to create your own container images, but most users will start with a container set up by someone else.  The most common place to get Docker images is [*Docker Hub*](https://hub.docker.com/).  Docker Hub is sort of like GitHub, but specifically for Docker images.  

The *Docker client application* is software that you install on your computer that enables you to pull images from Docker Hub and install them as containers, and to manage (start, stop, track, and delete) the containers that you've deployed on your computer.  

[*Docker Compose*](https://docs.docker.com/compose/) is a Docker tool for running applications that consist of multiple containers.  It makes use of information that tells how the containers should interact with each other.

# Installing and testing docker

## Installing the Docker client application

If you are just getting started with Docker, you will probably want to install the free Community Edition.  Go to the [Docker CE page](https://docs.docker.com/install/#supported-platforms) and find the version for your operating system.  The install instructions are fairly straightforward and won't be repeated here. 

Once you've installed the Docker client, it will start up automatically when you boot your computer and run in the background.  You can know it's there by looking in the system tray in the lower right of your screen on PC, or the menu bar in the upper right of your screen on Mac.  You should see the little whale icon there.  Clicking on it brings up options for managing the application.  

If you go to <https://cloud.docker.com/>, you can create a Docker ID.  A Docker ID is not required to pull public images from Docker Hub, but you would need one if you want to upload your own images.

## Testing the Docker client

In order to use the Docker client, you need to issue commands using your computers command line console. If you haven't used the console before, here are instructions for getting to it on PC and Mac:

**Windows** In Windows, the application for the command line is called "Command Prompt".  The easiest way to get to the command prompt is to start typing "command" in the search box next to the start button.  When Command Prompt shows up in the results, click on it to open a Command Prompt window.  

<img src="../../script/python/images/install5pc.png" style="border:1px solid black">

When you enter the Command Prompt window, you should see a line with the path to your user directory, followed by a ">" character.  This is the system prompt.  It means that you can issue any kind of command line command that Windows will understand.  

**Mac** On a Mac, the application for the command line is called "Terminal".  The easiest way to get to the command line via Terminal is to click on the Spotlight Search icon (small magnifying glass in the upper right of the screen) and start typing "terminal" in the search box.  When terminal.app shows up in the results, click on it to open a Terminal window.  

<img src="../../script/python/images/install6mac.png" style="border:1px solid black">

When you enter the Terminal window, you should see a line with the your computer name, a tilde (`~`) followed by your username, and finally a "$" character.  This is the system prompt.  It means that you can issue any kind of command line command that the Mac operating system will understand.  

*Note: The Mac operating system is build on the Linux operating system.  So the commands that you give in this window are sometimes called "bash commands" (a type of Linux commands).  Hence you see "bash" listed in the header of the terminal window.*

**Running some tests**

At the command line, enter

```
docker info
```

If Docker is running, you should get some information.  If you get a message like "Command not found" or "'docker' is not recognized as an internal or external command, operable program or batch file.", then either the installation failed or Docker is not running.  In this case, you will need to get troubleshooting help from someone.

To see what images have been downloaded to your computer, enter

```
docker image ls
```

and to see what containers have been deployed on your computer, enter

```
docker container ls -all
```

This command will show containers that are currently running as well as ones that have been run in the past, but have been stopped.  If you run these two commands now, you may not see anything listed.  

To try actually running an image, enter

```
docker run hello-world
```

The Docker client will pull the "hello-world" image from Docker Hub to your computer, then create a "hello-world" container from that image and run it.  All that this particular application does is to print some text on your screen, which you can read after it runs.  Now if you repeat the image list command shown above (easily retrieved at the command line by pressing the up arrow several times, then pressing Enter/Return), you will see the hello-world image listed.  Listing the containers will show that the hello-world container is no longer running.  

# Cheat sheet

Here are some of the most important Docker commands:

```
# pull image from Docker Hub; "repo" is repository name, "image" is image name:
docker pull repo/image

# to run the container named "image" from the "repo" repository, version 2.1.5:
docker run repo/image:2.1.5

# to list Docker images that have been pulled:
docker image ls

# to list all Docker containers:
cocker container ls -all
# leave the "-all" off to see only containers that are currently running

```

# Next steps

[Example using Docker to install Blazegraph locally](../../lod/install/#using-docker-to-create-an-instance-of-blazegraph-on-your-local-computer)

[Example using Docker Compose to install the components of Wikibase locally](../../lod/install/#using-docker-compose-to-create-an-instance-of-wikibase-on-your-local-computer)

----
Revised 2019-01-29
