---
permalink: /script/r/install/
title: Installing R and R Studio
breadcrumb: Install
---

# Installing R and R Studio

## How do I acquire R ?

R can be downloaded from one of many Comprehensive R Archive Network (CRAN) sites.  The closest one to Vanderbilt is at UT Knoxville: - <http://mirrors.nics.utk.edu/cran/> .  From the UTK CRAN site homepage, click on the "Download R for \[OS\]" link that is appropriate for your operating system. 

An alternative to downloading R and RStudio separately is to download [Anaconda](https://www.anaconda.com/). Anaconda is a comprehensive data science platform that installs and manages not only R and RStudio, but also downloads and installs Python and Jupyter notebooks along with all of the commonly used packages that go along with these programs.  So it does a lot in a single install, but it is also a bit intrusive and requires quite a bit of computing resources and drive space.  So it may not be appropriate for installation on old computers.  To install Anaconda go to [this page](https://www.anaconda.com/distribution/). 

# Downloading and installing R and RStudio for Windows

## Downloading and installing R

On the CRAN Windows download page, click on the "base" link, which will take you to the download page for the most recent base R distribution.  Then click on the "Download R X.X.X for Windows" link (where X.X.X is the version number).  This will initiate the download of an executable installation file to the default download directory for your browser.  After the download completes, click (or double-click) on the installer file to initiate the install.  Click the Next button repeatedly to accept all of the defaults.  After completing the install, you should see an R shortcut on your desktop.  Double-click on the icon to launch R.  You should see the R Console with a ">" prompt at the bottom.  Enter:

```
2+2
```

and you should see

```
[1] 4
```

as the answer.  Click the X in the upper right of the window to quit the console, and don't save.

## Downloading and installing RStudio

Go to <https://www.rstudio.com/products/rstudio/download/> and click on the installer link for Windows.  This will initiate the download of an executable installation file to the default download directory for your browser.  After the download completes, click (or double-click) on the installer file to initiate the install. Click the Next button repeatedly to accept all of the defaults.  By default, there is no shortcut on the desktop - if you want one there, click on the Start menu, find the RStudio icon in the list of programs and drag it to the desktop.  Run RStudio.  In the left side of the window, you should see a Console pane similar to what you saw before.  Try adding 2+2 as you did above and you should get the same result. 

# Downloading and installing R and RStudio for Mac OS X

## Downloading and installing R

The main CRAN download page for Mac contains the installers for OS X 10.6 and above.  For older operating systems, read the page and rummage around until you find what you need.  On the main download page, click on the link for the correct binary for your OS version.  When the download is complete, click on the installer file to launch the install.  Click the Next button repeatedly to accept all of the defaults, and Agree to the terms.  Click on Install as prompted and enter your password as necessary.  When complete, close the installation window. 

In Finder, click on Applications.  You should see R listed.  Double click on it to launch R. You should see the R Console with a ">" prompt at the bottom.  Enter:

```
2+2
```

and you should see

```
[1] 4
```

as the answer.  Click the red dot in the upper left of the window to quit the console, and don't save.

## Downloading and installing RStudio

Go to <https://www.rstudio.com/products/rstudio/download/> and scroll to the bottom of the page.  Click on the appropriate installer link for your computer's operating system.  This will initiate the download of an executable installation file to the default download directory for your browser.  After the download completes, click on the .dmg file to open it. Drag the RStudio icon into the Applications folder and close the window.  You should now be able to find RStudio in your Applications folder.  Run RStudio.  Allow the application to run.  In the left side of the window, you should see a Console pane similar to what you saw before.  Try adding 2+2 as you did above and you should get the same result.  

----
Revised 2019-08-14
