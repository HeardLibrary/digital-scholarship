---
permalink: /lod/install/
title: Installing Blazegraph and Wikibase
breadcrumb: Install
---

# Installing Blazegraph and Wikibase

This tutorial will help you use Docker to install two well-known linked data applications that will be interesting to experiment with: Blazegraph and Wikibase.  These instructions assume that you have Docker already installed on your computer.  If you don't, there are [installation instructions](../../host/docker/)elsewhere.

# Using Docker to create an instance of Blazegraph on your local computer

## Pulling and starting the Blazegraph container

Start by going to Docker Hub (<https://hub.docker.com/>).  Enter `blazegraph` in the search box at the top of the page. As you can see, there are a number of Blazegraph images that have been posted. We will chose `lyrasis/blazegraph` because it has a lot of downloads, a lot of starts, and instructions that are easy to follow.

Open a console window (Command Prompt in Windows or Terminal in Mac).  Enter the following command:
```
docker pull lyrasis/blazegraph:2.1.5
```

(When I left the version number off the command shown at Docker Hub, I got an error message.) You will see a number of status messages as the Docker client pulls all of the bits it needs. 

When the pull is finished, we will follow the [Quickstart instructions](https://hub.docker.com/r/lyrasis/blazegraph) to run Blazegraph. The run command shown in the instructions is more complicated than what is listed on the [Docker cheatsheet](../../host/docker/#cheat-sheet): 

```
docker run --name blazegraph -d -p 8889:8080 lyrasis/blazegraph:2.1.5
```

The `--name` option makes it possible to refer to the container in a more abbreviated way.  The `-d` option runs the container in [detached mode](https://docs.docker.com/engine/reference/run/#detached--d), a detail we will not worry about.  The `-p 8889:8080` port command maps the port number where the service is listening inside the container (8080 in this example) to the port number outside the container where clients connect.  The important thing here is that when we want to use Blazegraph via a web browser, we need to connect to port 8889.

## Using Blazegraph

Access to the Blazegraph graph database and query functions is done through a web browser.  


# Using Docker Compose to create an instance of Wikibase on your local computer

----
Revised 2019-01-29
