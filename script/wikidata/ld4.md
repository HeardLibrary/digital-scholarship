---
permalink: /script/wikidata/ld4/
title: VanderBot tutorial (revised)
breadcrumb: LD4 vanderbot
---

# LD4 VanderBot tutorial

## Links

[First blog post](http://baskauf.blogspot.com/2021/03/writing-your-own-data-to-wikidata-using.html)

[VanderBot landing page](http://vanderbi.lt/vanderbot)

## Before starting

This session will focus on the Wikidata side of things and not on programming, command line, etc. As is the case with many "follow-along" workshops, the biggest hazard is running into technical issues at the start and not being able to "keep up" because of getting stuck with installation issues, getting lost, etc. Therefore, if you don't already have Python 3 installed on your computer, don't know how to get to the command line, don't know where your home directory is, etc., you can do some up-front legwork to avoid these hazards.

1\. **Accessing the command line**. To get to the command line, you need to open a console program that is appropriate for your operating system. For Macs and Linux that is typically the **Terminal** application. On Windows, it is typically the **Command Prompt** application. (Some Windows users know how to launch the Linux shell -- if you know how to do that, it's fine.) If you need more information about accessing the command line, see [this page for Windows](https://heardlibrary.github.io/digital-scholarship/computer/command-windows/) or [this page for Mac](https://heardlibrary.github.io/digital-scholarship/computer/command-unix/).

2\. **Checking whether you already have Python 3**. It is possible that your computer already has Python 3 installed on it -- for example if you've installed Anaconda for other purposes. You should be aware that many Macs have Python 2 pre-installed as part of the operating system. **Python 2 is deprecated and will NOT work for these exercises.** Starting with the Big Sur operating system, Python 3 is included, so the Python version you have probably will depend on what OS you are using.

To find out whether Python 3 is installed on your computer, open your console (see #1 above) and enter

`python`

If the console responds with something like `Python 3.7.2`... or some other number starting with "3", then you are good to go (usually the case for Windows users). If it says something like Python `2.7.16` or some other number starting with "2" (usually the case for Mac users), then try the next thing. If you get an error message, also try the next thing.

If you didn't get a message like `Python 3.7.2`, then try entering

`python3`

If the console responds with something like `Python 3.7.2`... or some other number starting with "3", then you are good to go, but you need to remember that in the future, any time the instructions tell you type `python`..., you need to instead type `python3`... (usually the case for Mac users who haven't installed Anaconda). If you get an error message after trying both of these things, then you don't have Python 3 and need to install it.

If you got into either Python 2 or Python 3, you can get out of it by holding down on the `Ctrl` key and pressing the `Z` key (or just close the console window).

3\. **Installing Python 3** (if you don't already have it). There are [instructions for installing Python 3 on both Mac and Windows on this page](https://heardlibrary.github.io/digital-scholarship/script/python/install/). **Note to Windows users:** one of the most common problems is not having Python 3 added to your system path! Note carefully in step 4 that there is a checkbox during the installation to do this. If you forget to check this box, it is possible (but difficult) to fix and you will probably need to ask for help from an advanced user.

To enable secure communications through Python, Python will need a security certificate. On Macs, the last step of the installation may include a message about downloading and installing SSL root certificates. If so, run the "Install Certificates" script as instructed in the final window.

Once you have installed Python 3, you can go back to the last step and verify that you can get Python 3 to start up in your console program.

4\. **Installing the requests package.** I believe that the scripts we will be using need only one module that isn't in the Standard Library for Python. That is the package called `requests`. The `requests` package is used to communicate between your computer and servers somewhere else using HTTP, the communications language of the Internet. If you are not an Anaconda user, to install the requests package, open your terminal program and type the following (substituting `pip3` instead of `pip` if you have to type `python3` instead of `python` on your computer):

```
pip install requests
```

5\. **Figuring out where your downloaded files are**. If you don't typically navigate around your computer using the command line, it is possible to get lost. I recommend that you create a folder that is a subfolder of your Documents folder in which to put the files that we will be using (for example a folder called `vanderbot` or something else that is simple and doesn't have spaces in its name). Most people can easily get to such a folder, although Windows is particularly bad about making people confused about where files are. If you want to run a test ahead of time, try creating a subfolder of your `Documents` folder, download a file into it, then try the following commands in the console:

```
cd Documents
```

then

`ls` for Mac, or `dir` for Windows

You should see the directory you created. Now change to the new folder and look for the file you downloaded by entering these commands:

`cd vanderbot` (or whatever you called the folder)

then

`ls` for Mac, or `dir` for Windows

You should see the file you downloaded in the listing. Sometimes in Windows weird things happen with different user folders, so if you can't find the file you downloaded, ask a more experienced user for help.

6\. **Using a text editor**. At several points in the session, we will need to edit plain text files. Those are files that don't have all of the extra "invisible" information that is saved in word processing documents. Both Macs and Windows computers have built-in text editors that you can use: TextEdit on Macs and Notepad on Windows. If you have installed a code editor like Atom or Visual Studio Code on your computer, you can use that instead, but that's overkill. If you don't know about text editors or don't know how to find one on your computer, there are [some videos on the topic you can watch here](https://heardlibrary.github.io/digital-scholarship/script/codegraf/020/#text-editors-and-code-editors-2m13s). NOTE: If this is the first time you have used TextEdit on a Mac to edit plain text, make sure that you have set it to default to plain text rather than rich text. See [these instructions](https://heardlibrary.github.io/digital-scholarship/script/codegraf/020/#textedit-text-editor-for-mac-2m08s) for more details. 

## Introduction

<iframe width="1120" height="630" src="https://www.youtube.com/embed/xMvEBgpjJt0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

# Preparation

-----

## Creating a bot password

<iframe width="1120" height="630" src="https://www.youtube.com/embed/NZP6lB7l8c8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[bot password page](https://www.wikidata.org/wiki/Special:BotPasswords)



-----

## Creating a credentials file

<iframe width="1120" height="630" src="https://www.youtube.com/embed/dHBv5IzBsQU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


Use `TextEdit` for Mac or `Notepad` for Windows. **Note**: In the video, the example shows the `test.wikidata.org` URL. But we will be using `www.wikidata.org` as shown in the template below.

Credentials file template:

```
endpointUrl=https://www.wikidata.org
username=User@bot
password=465jli90dslhgoiuhsaoi9s0sj5ki3lo
```

Save the credentials file in your home directory under the name `wikibase_credentials.txt`



-----

## What are sandbox items?

<iframe width="1120" height="630" src="https://www.youtube.com/embed/nvWkaCcEEHA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


Test items in the "real" Wikidata:

- [Sandbox page 1](https://www.wikidata.org/wiki/Q4115189)
- [Sandbox page 2](https://www.wikidata.org/wiki/Q13406268)
- [Sandbox page 3](https://www.wikidata.org/wiki/Q15397819)



-----

## Create folders prior to preparing data for upload

<iframe width="1120" height="630" src="https://www.youtube.com/embed/X_uO-OmrJqM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

# Writing to Wikidata sandbox items

-----

## What is a metadata description file?

<iframe width="1120" height="630" src="https://www.youtube.com/embed/YStUeWbrzoM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


The default name for metadata description files used by VanderBot is `csv-metadata.json`.



-----

## Downloading and examining a simple configuration file

<iframe width="1120" height="630" src="https://www.youtube.com/embed/XG_JbEri8ns" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[Practice configuration file for sandbox pages](https://gist.github.com/baskaufs/25a19cbb0edf9fcd16423bf231645939)

The default name for configuration files used by VanderBot is `config.json`.



-----

## Transforming a configuration file to a metadata description file

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4DdDzjVx6no" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[Script to convert simplified configuration file into a schema](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/convert_json_to_metadata_schema.py). The script is named `convert_json_to_metadata_schema.py`.

To prevent overwriting any existing CSV files, the generated ones have `h` prepended to their name. This `h` needs to be removed before the spreadsheets are used.



-----

## Adding data to the spreadsheet prior to upload

<iframe width="1120" height="630" src="https://www.youtube.com/embed/BWQOyd1M0So" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

## Downloading the VanderBot script

<iframe width="1120" height="630" src="https://www.youtube.com/embed/yKC2evfxfE8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[VanderBot Python script (for downloading)](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/vanderbot.py)



-----

## Writing new claims to a sandbox item

<iframe width="1120" height="630" src="https://www.youtube.com/embed/9fC3oXvQfqI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

## Adding a reference to an existing claim

<iframe width="1120" height="630" src="https://www.youtube.com/embed/lXgMKHdyY6k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

## Adding multiple values for a property

<iframe width="1120" height="630" src="https://www.youtube.com/embed/y-FB7rSW2Ks" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

## Cleaning up the sandbox

<iframe width="1120" height="630" src="https://www.youtube.com/embed/7GypaiRI1Uo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

# Creating real Wikidata items

-----

## Setting up a configuration file for university faculty

<iframe width="1120" height="630" src="https://www.youtube.com/embed/iHHQfJKl4OE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[Simple configuration file for university faculty](https://gist.github.com/baskaufs/6a37c39f70a228d38d5ebda28651ffca)

[Bluffton University faculty information webpage](https://www.bluffton.edu/catalog/officers/faculty.aspx)

Graph pattern for employees of Bluffton University (Q886141).

```
?qid wdt:P108 wd:Q886141.
```



-----

## Download and clean existing data from Wikidata about faculty

<iframe width="1120" height="630" src="https://www.youtube.com/embed/ophQmKE0Ksc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[Script to acquire existing metadata from Wikidata](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/acquire_wikidata_metadata.py). The script is named `acquire_wikidata_metadata.py`.




-----

## Adding statements about existing faculty items

<iframe width="1120" height="630" src="https://www.youtube.com/embed/zxIDeFjM0R4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

## Creating a new faculty item

<iframe width="1120" height="630" src="https://www.youtube.com/embed/fu68LM5NicM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----



For more information, [email Steve Baskauf](mailto:steve.baskauf@vanderbilt.edu)

Revised 2021-06-24
