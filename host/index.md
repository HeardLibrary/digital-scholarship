---
permalink: /host/
title: Application hosting and management
breadcrumb: Host
---

# Application Hosting and Management

## Amazon Web Services (AWS)

AWS offers [many services](https://aws.amazon.com/) for deploying applications in the cloud.  They include Simple Storage Service (S3), Elastic Compute Cloud (EC2) cloud servers, simple DynamoDB NoSQL databases, and Lambda serverless computing. You can open a small-scale personal account for one year for free.  [Vanderbilt IT](https://it.vanderbilt.edu/services/catalog/) provides some support for AWS cloud services.  

For more information about getting started with AWS, visit [this page](aws/).

## DigitalOcean

[DigitalOcean](https://www.digitalocean.com/) provides a number of cloud computing resources. Droplets are virtual machines in which you can deploy code in the cloud.  They also provide database and simple object storage services.  Although its services are less extensive than AWS, they may be simpler to use.

## Code Ocean

[Code Ocean](https://codeocean.com/) is a platform that allows you to create, collaborate on, and run code online.  The system allows you to not only make your code available openly, but allows others to actually execute that code to see how it works.  The service is free for individual researchers.

## Wikidata and Wikibase

[Wikidata](https://www.wikidata.org/) is a free and open knowledge base to which anyone can contribute.  It provides an easy-to-use graphical interface for entering data, but also allows machine-assisted uploading of data.  The data can be searched using the [Wikidata Query Service](https://query.wikidata.org/), a [SPARQL](https://heardlibrary.github.io/digital-scholarship/lod/sparql/)-based interface that is machine-accessible.  

[Wikibase](https://www.mediawiki.org/wiki/Wikibase) is the underlying platform that supports Wikidata. You can [install Wikibase](https://heardlibrary.github.io/digital-scholarship/lod/install/#using-docker-compose-to-create-an-instance-of-wikibase-on-your-local-computer) yourself to host your own Wikidata-like dataset that can be curated by your own organization.

[Some Wikidata resources](wikidata/) 

## Docker

*Docker* is a system that allows you to containerize a deployed application along with all of its configuration settings and associated files.  When you deploy a Docker container image, it is ready to run.  If you mess up a container, you can destroy it and redeploy the image. 

See [this page](docker/) for more information on Docker.

----
Revised 2020-01-07
