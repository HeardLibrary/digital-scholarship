---
permalink: /host/
title: Application hosting and management
breadcrumb: Host
---

# Application Hosting and Management

## AWS

coming later

## Code Ocean

coming later

## DigitalOcean

coming later

## Wikidata and Wikibase

[page with some resources](wikidata/)

## Docker

*Docker* is a system that allows you to containerize a deployed application along with all of its configuration settings and associated files.  When you deploy a Docker container image, it is ready to run.  If you mess up a container, you can destroy it and redeploy the image. 

*Docker Compose* is a feature of Docker that allows several containers to interact with each other in a pre-determined way.  It allows one to archive a complex setup of several applications in a way that others can easily deply them.

*Docker Machine* is a system for managing Docker containers on several servers.  This can include remote servers (such as those on Amazon Web Services or Digital Ocean), as well as a localhost server on your own computer.  You can switch between different servers, then interact with them in the same way (through Docker or Docker Compose commands) as you would with the default localhost server using generic Docker.

[Tutorial on installing and testing Docker](docker/)

[Notes from a workshop by Nick Stayer on building and running a Dockerfile](http://nickstrayer.me/docker_for_biostatisticians/) (2019-04-26)

[Introduction to Docker Compose](dockercompose/)

[Introduction to Docker Machine](dockermachine/)

----
Revised 2019-04-26
