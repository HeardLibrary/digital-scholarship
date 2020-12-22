---
permalink: /host/docker/dockercompose/
title: Docker Compose
breadcrumb: Docker Compose
---

# Docker Compose

Docker Compose is a feature of Docker that allows you to coordinate running multiple Docker containers.  It is installed automatically when you install docker.  To ensure that Docker Compose is installed and functional, open a console window (Command Prompt on Windows or Terminal on Mac) on your computer and enter:

```
docker-compose --help
```

If Docker Compose is running, you should see some help information.

## What is Compose?

Compose is a way to run a complex application that uses several individual Docker applications simultaneously in a coordinated way.  

The key feature is a file that defines all of the containers that are necessary, and the settings that are required in order for them to work together.  By default, this file is called `docker-compose.yml`.  Compose assumes that you have already pulled the images for the containers you need, although for some well-known images, it may be able to pull them automatically when you run the whole application.  

When you run a Compose application, Compose starts (or restarts) all of the individual containers.  When you stop a Compose application, Compose shuts them all down safely.

## Running Compose

It is relatively simple to invoke Compose.  Within your system's console (Command Prompt for Windows or Terminal for Mac), change to the directory that contains the `docker-compose.yml` file.  Then enter:

```
docker-compose up
```

You will see a series of commands being executed and status messages that result from the commands.  When the complex application is running, there should be some kind of stable situation in the console window.

To shut down the application, issue the command:

```
docker-compose down
```

Note: while the application is running, you may never get the system prompt back in the window that you used to initiate the application.  In that case, you can open a second console window in which you can issue the "down" command.

For more details see [the Docker Compose overview page](https://docs.docker.com/compose/overview/).

----
Revised 2019-02-26
