---
permalink: /host/wikidata/bot/
title: Building a bot to inteact with Wikibase
breadcrumb: bot
---

# Building A Bot to Interact with Wikibase

[Wikibase](http://wikiba.se/) is the underlying system upon which [Wikidata](https://www.wikidata.org/) is built.  If you are already familiar with Wikidata, Wikibase is essentially a blank copy of Wikidata into which you can enter your own items and properties.  Wikidata and Wikibase share the same [data model](../../lod/wikibase/), so Wikibase provides a means to test tools and data structures that might eventually find their way to Wikidata.

Because Wikibase is so empty, it would take a lot of work to enter any meaningful amount of data by hand using the wiki GUI interface. Therefore, it is likely that Wikibase users will want to use tools to automate the process.  Unfortunately, Quickstatements, one of the most useful tools for populating Wikidata with data from spreadsheets, does not work in the [Docker image](https://hub.docker.com/r/wikibase/wikibase) of Wikibase that is easiest to install (as of 2019-03-31, see [this](https://stuff.coffeecode.net/2018/wikibase-workshop-swib18.html#_quickstatements) for more information).  

In order to successfully complete this exercise, you should meet the following requirements:

- Have access to an instance of Wikibase, either as a localhost installation on your own computer (see [these instructions](../../lod/install/#using-docker-compose-to-create-an-instance-of-wikibase-on-your-local-computer) to set one up), or as a remote instance running by [Docker machine](../../host/dockermachine/) on a remote service like Amazon Web Services (AWS).
- Have Python 3 installed on your computer. (See [these instructions]() if you don't.)
- Have access to a spreadsheet program that can edit CSV files.  [Libre Office](https://www.libreoffice.org/) or [Open Office](https://www.openoffice.org/) is recommended, but Microsoft Excel is probably OK if you have it.  (Microsoft Excel has the bad habit of sometimes messing up CSV files, but that usually doesn't happen if the CSV is uncomplicated and contains only Latin characters and no dates.)
- Have a basic understanding of the Wikibase/Wikidata [data model](../../lod/wikibase/).  At a minimum, you should understand what items and properties are.
- Have played around with the Wikidata graphical interface for editing items.  Practice on the [Wikidata Sandbox](https://www.wikidata.org/wiki/Q4115189) if you haven't already done this.
- Understand what a file path is.  If you don't, read the Directories section [here for Mac](../../computer/directories-mac/) or [here for Windows](../../computer/directories-windows/).
- Know how to run a program using the command line.  If you don't read [this page for Mac](../../computer/command-unix/) or [this page for Windows](../..//computer/command-windows/).  



----
Revised 2019-03-31
