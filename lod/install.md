---
permalink: /lod/install/
title: Installing Blazegraph and Wikibase
breadcrumb: Install
---

# Installing Blazegraph and Wikibase

This tutorial will help you use Docker to install two well-known linked data applications that will be interesting to experiment with: Blazegraph and Wikibase.  These instructions assume that you have Docker already installed on your computer.  If you don't, there are [installation instructions](../../host/docker/) elsewhere.

# Using Docker to create an instance of Blazegraph on your local computer

## Pulling and starting the Blazegraph container

Start by going to Docker Hub (<https://hub.docker.com/>).  Enter `blazegraph` in the search box at the top of the page. As you can see, there are a number of Blazegraph images that have been posted. We will chose `lyrasis/blazegraph` because it has a lot of downloads, a lot of starts, and instructions that are easy to follow.

Open a console window (Command Prompt in Windows or Terminal in Mac).  Enter the following command:
```
docker pull lyrasis/blazegraph:2.1.5
```

(When I left the version number off the command shown at Docker Hub, I got an error message.) You will see a number of status messages as the Docker client pulls all of the bits it needs. 

When the pull is finished, we will follow the [Quickstart instructions](https://hub.docker.com/r/lyrasis/blazegraph) to run Blazegraph for the first time. The run command shown in the instructions is more complicated than what is listed on the [Docker cheatsheet](../../host/docker/#cheat-sheet): 

```
docker run --name blazegraph -d -p 8889:8080 lyrasis/blazegraph:2.1.5
```

The `--name` option makes it possible to refer to the container in a more abbreviated way.  The `-d` option runs the container in [detached mode](https://docs.docker.com/engine/reference/run/#detached--d), a detail we will not worry about.  The `-p 8889:8080` port command maps the port number where the service is listening inside the container (8080 in this example) to the port number outside the container where clients connect.  The important thing here is that when we want to use Blazegraph via a web browser, we need to connect to port 8889.

When Blazegraph is running on your computer locally, it is actually a localhost server that interacts through an IP address that you can access using a web browser.  Once the server is started using the docker run command listed above, it will continue to operate regardless of whether any web browser is connected to it or not.  

To stop the Blazegraph server, issue the following command (using the short name you assigned) in the console window:

```
docker container stop blazegraph
```

To restart the container, enter:

```
docker restart blazegraph
```

Note that stopping the container does not get rid of it.  It is still present in an inactive form at the state when it was stopped.  To actually remove the container, list the containers using:

```
docker container ls --all
```

and find the ID of the lyrasis/blazegraph:2.1.5 container.  Then issue the command

```
docker container rm {containerId}
```

where `{containerId}` is the ID you found in the list.  For example, if the ID were `3413cbe0f296`, the command would be 

```
docker container rm 3413cbe0f296
```

Note that this removes the container, but doesn't delete the generic Docker image that you downloaded and used to set up the container.  To delete the image as well, list the images using

```
docker image ls
```

then give the command 
```
docker image rm {containerId}
```

where {containerId} is the ID you found in the image listing.

## Starting Blazegraph

Access to the Blazegraph graph database and query functions is done through a web browser via the port that you set when you initiated the Blazegraph server using `docker run` (port 8889).  To access the database, open your favorite web browser and enter the following in the browser URL bar:

```
localhost:8889/bigdata/
```

You should see the following screen:

<img src="../images/blazegraph.png" style="border:1px solid black">

## Loading data

You can load files by direct upload using the UPDATE tab and carry out SPARQL queries using the QUERY tab.

To upload a file from your hard drive, use the Choose file button.  When the file is selected, the serialization will be detected based on the file extension.  If the file is small, it will be shown on the screen.  If it is big, it will say the file is to big to display.  Click the Update button.  After the file loads, a message will appear at the bottom of the screen something like "Modified: 444" where the number indicates the triples loaded.  It will look like this:

<img src="../images/upload-file.png" style="border:1px solid black">

To upload a file through the Internet, change the Type to SPARQL Update.  (You may need to refresh the browser in order to be able to type the command.)  Then enter a SPARQL Update command in the window, of the form:

```
LOAD <http://bioimages.vanderbilt.edu/baskauf/12255> INTO GRAPH <http://test>
```

The first URL must be a valid URL that dereferences to a file in some RDF serialization.  Note that the server must provide a `Content-type` header appropriate for the file type (Github raw files do NOT do this). The graph URI can be any valid URI and it does not matter whether it actually dereferences to anything.  Click the Update button.  If the update is successful, there will be a message at the bottom of the screen with a "mutation count" showing the number of triples loaded.  It will look like this:

<img src="../images/sparql-update.png" style="border:1px solid black">

## Querying

Click on the QUERY tab.  Enter any query, for example:

```
SELECT *
WHERE {
    ?s ?p ?o.
}
LIMIT 10
```

The query results will appear below the box like this:

<img src="../images/sparql-query.png" style="border:1px solid black">

# Using Docker Compose to create an instance of Wikibase on your local computer

----
Revised 2019-01-29
