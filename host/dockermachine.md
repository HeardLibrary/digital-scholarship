---
permalink: /host/dockermachine/
title: Docker Machine
breadcrumb: Docker Machine
---

# Docker Machine

Docker machine is a component of Docker that can be used to switch between Dockerized hosts, including those on remote services such as Amazon Web Services (AWS) and Digital Ocean.  Docker Machine is now installed as a part of the overall Docker install, so if you have not yet installed Docker, or if you are unfamiliar with Docker, you should first go through the [Docker tutorial](../docker/).

## A deeper understanding of how Docker works

In order to work with Docker Machine without getting confused, you need to have an understanding of some details of how the Docker system works.

![Docker daemon](../images/docker-daemon-small.jpg)

On the largest scale, the Docker system involves communication between a client (software on your local computer) and a server (a separate software system that might be on your local computer or on a remote computer somewhere else).   Communication between the client and the server takes place using the Internet protocol called *TCP/IP*.  

On the local computer, the software is run through the Docker *command line interface* (CLI) -- software that you invoke by typing commands in the console (Terminal on Mac or Command Prompt on Windows).  

In the Docker system, the server is known as a "Dockerized host", colloquially referred to as a *machine*.  The machine has several components.  An important one is the *daemon*, a system in the machine that manages the docker containers that exist on that machine.  The daemon does things like downloading Docker images, running new containers, and starting and stopping existing containers.  The containers themselves are part of the machine, and when they are started, they are what actually make the machine "run".  Communication between the daemon and the CLI takes place through the machine's *REST API*, a system that is able to send and receive TCP/IP commands from the CLI.  

When you are running generic Docker out of the box, you are actually using a machine that is operating on your local computer.  In this case, the TCP/IP commands don't actually go through the Internet, they simply loop back from the CLI to the local machine using the *localhost* address -- a special IP address that allows communication to a server within your computer.  

![Docker machine](../images/docker-machine-small.jpg)

----
Revised 2019-02-25
