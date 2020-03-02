---
permalink: /computer/cloud-mac/
title: Cloud Storage (Mac)
breadcrumb: Cloud (Mac)
---

# Understanding my computer - Lesson 7: Cloud storage

This is the Mac version of this page, which covers the cloud file storage.  [Click for the Windows version of this page](../cloud-windows/)

[go back to Lesson 5: Backup](../command-linux/)

Note: this lesson assumes that you have completed and understand lessons [1 (files)](../files-mac/) and [2 (directories)](../directories-mac/). 

## What is cloud storage?

Cloud storage is a system that allows you to store files on a remote server that can be accessed from anywhere through the Internet. Some well-known cloud storage systems are Dropbox, Box, Microsoft OneDrive/SharePoint, Google Drive, iCloud, AWS buckets, and GitHub. Many of these systems share similarities, which will be discussed first, but also have their own idiosyncrasies, which will be discussed later.

# General features of cloud storage

## Web access

Generally, cloud storage services allow you to have access to your files on the remote server directly through a web interface. In most cases, file access is private and controlled through a login, although it is usually possible to share individual files or folders, or to make them available to the general public. Sharing can be read-only or with editing rights.

## Synch to local drive

Most cloud storage systems have a mechanism for synchronizing the files on the remote server with files on your local computer drive. This synching is done by an application that starts up when the computer is booted and runs all the time in the background. In most systems, the application is constantly checking for changes to the local and remote file system and when a change occurs, the application takes some kind of action to keep the files at both locations in synch. 

Usually, the action that the application takes depends on how you've set up the affected folder. In some cases, changes on the remote system will automatically result in the file being downloaded locally and in other cases, changed files will only be downloaded when you try to access them. The difference between these settings doesn't matter much there are a few small files and the network speed is fast, but if there are many large files, or if the network speed is slow (such as on a mobile network) the difference could be important. Usually there is some kind of symbol by the folder or file name that indicates whether the file has been synched and whether it's been downloaded locally or not.

# Web interface

In general, the cloud file services web interfaces allow you to navigate through folders and download and view files. The ability to actually edit the files will depend on the file type and whether a particular interface supports online editing of that type. Microsoft Office Online makes it possible to edit Word, Excel, and PowerPoint documents online. Changes are made real-time and multiple people can edit the documents at the same time, in a manner similar to Google Docs and Sheets. This is true regardless of the cloud service and changes are saved automatically.

## Dropbox

In order to make money, Dropbox is pushing its paid business plans. To get to the free Basic service, you have to find and click on the "get Dropbox Basic" on the home page, which links to <https://www.dropbox.com/basic>. The free plan gives you 2 GB of space, but now limits you to installing the synch app on only 3 devices. So if you are using more than two computers and you phone, Dropbox is pretty limiting.  Click on the "Try Dropbox Free" button, then either create an account or log in.

<img src="../images-7-mac/dropbox-cloud.png" alt="dropbox web interface" style="border:1px solid black">

The web interface has a number of self-explanatory dropdowns for sharing and viewing. Depending on the type of file, you may be able to view and even edit it using the web interface. The `...` button gives you access to other opetions like downloading, copying, moving, etc. Dropbox now supports opening some documents in the browser using tools like Google Docs and Microsoft Word Online. For other file types, you will need to download them before opening them.

## Box

Vanderbilt has a contract with Box to provide cloud storage for people associated with the university. So if you log in through Single Sign On at <https://vanderbilt.app.box.com/>, you have access to 50 GB of space with more available on request. 

<img src="../images-7-mac/box-cloud.png" alt="box web interface" style="border:1px solid black">

You can share, move, download, etc. files and folders using the various buttons and dropdowns. There are also built-in viewers for many kinds of files and from the viewing screen you can open Office files using Microsoft online. 

----
Revised 2020-03-02
