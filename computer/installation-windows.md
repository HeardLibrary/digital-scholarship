---
permalink: /computer/installation-windows/
title: Installing software (Windows)
breadcrumb: Installation (Windows)
---

# Understanding my computer - Lesson 3: Installing software

This is the Windows version of this page.  [Click for the Mac version of this page](../installation-mac/)

[go back to Lesson 2: Directories](../directories-windows/)

# What is an installed application?

In the olden days, a computer program would often consist of a single file containing executable code.  All you had to do to run the program was to copy that file somewhere on your hard drive and run it.

The situation today is much more complicated.  There is still at least one executable file associated with each application, but there are nearly always many other files associated with that one that are necessary for that application to run.  So installing an application requires not only copying an executable file to your hard drive, but also copying all of the other files and making necessary changes to the computer's configuration in order for the executable file to run properly.  This whole process is called *installing* the application.

## Files associated with an application

Bulk Rename Utility is an application that can be used to change the name of many files at once.  After it has been installed, the files associated with it are located in a directory not surprisingly called `Bulk Rename Utility` that is a subdirecctory of the `Program Files` directory. (Although there is no requirement that software be installed in any particular place, most installed software is either located in the `Program Files` directory, or the `Program Files (x86)` directory.)  

<img src="../images-3-windows/simple-executable.jpg" style="border:1px solid black">

We can see that there is one executable file in the `Bulk Rename Utility`, again not surprisingly named `Bulk Rename Utility.exe`.  This is the file that must be executed to make the application run, and if we double-click on it, the application will start up.  There are other files that contain documentation, configuration informtion, etc., but the overall number of files (11) are few because it isn't very complicated software.  

Let's compare this with a more complacated application.  There is also a directory in `Program Files` called `RStudio` and it contains the files associated with the RStudio application.  However, if we look in that folder, there isn't any obvious executable file that can be used to start up the application.  

<img src="../images-3-windows/complex-executable1.jpg" style="border:1px solid black">

In fact, there are 5 folders containing 1608 files.  We can avoid using trial and error to find the primary executable file by knowing that if it isn't in the main directory, it is often kept in a subdirectory called `bin` (for "binary", other possible names are "program", or "application").  

<img src="../images-3-windows/complex-executable2.jpg" style="border:1px solid black">

If we look in the `bin` subdirectory, we can see that there is a file there called `rstudio.exe`.  If we double-click on it, the RStudio application will launch. 

There are also a number of files that have the file extension `.dll`.  These also contain executable code that can be called by the main application or other related applications, but they can't be run by themselves.

## The registry

Windows maintains a centralized catalog of configuration information for the operating system in general and for all of the applications that are installed on the computer.  This catalog is called the *registry*.  When an application is installed, it may add entries to the registry, or modify existing entries.  

It is generally dangerous to edit the registry, so we won't talk about how find and edit it.  But the point is that the process of installing software can make changes to the computer beyond just copying files to it.  

## Shortcuts

Because most users would not like to (or be unable to) find the executable file that is used to launch an application, Windows has a feature called "shortcuts" that can be used to indirectly launch an application.  During installation, users might be asked whether they would like to put a shortcut on the desktop, in the Start menu, or on the task bar.  There is no limit to the number of places a shortcut can be placed -- all shortcuts point to the same executable file.

<img src="../images-3-windows/shortcut.jpg" style="border:1px solid black">

You can recognize a shortcut by the little arrow in the lower left corner of its icon.  Creating or deleting shortcuts have no effect on the application so simply deleting a desktop icon does nothing to get rid of the software.

<img src="../images-3-windows/shortcut-properties.jpg" style="border:1px solid black">

If you right-click on a shortcut and select `Properties`, the `Target:` field in the `Shortcut` tab will tell you the location of the executable file that starts up the application.  This is an easier way to find out where the executable file is than searching around blindly in the `Program Files` directory.  

You may be wondering why we care about the connection between shortcuts and the executable files they launch.  One reason is that if a file isn't correctly associated with the application that we want to open it with (see [lesson 1]() for more on this), Windows may not know that the application is the right type for using with that file.  In that case, when setting the default application, you may need to navigate to the executable file to tell Windows to use that application.  

<img src="../images-3-windows/open-with.jpg" style="border:1px solid black">

Similarly, if you right-click on a file and choose `Open with` and the application you want to use isn't there, you can select `Choose another app` followed by `Look for another app on this PC` to navigate to the executable.  If you check the `Always use this app to open ...` option, you can set the file association for that file type to the executable you choose.

Another reason is that if there isn't a shortcut on your desktop for an application, you can navigate to its executable, then right-click on it and select `Create shortcut` and agree to have it put on your desktop.

# Installing applications

Given the complexity of installed applications in Windows, the process of installing an application is also complicated.  Fortunately, applications generally come with an installer program that automates the process.  **Note:** if the user account you usually use on your computer is not an administrator account, you might not be allowed to install applications on your computer.  See [lesson 1](../files-windows/) for more about user accounts.

When you go to a website to download an appliction, the file that is downloaded is often one that has an `.msi` file extention (which stands for MicroSoft Installer).  If it doesn't have an `.msi` extension, then it usually has a `.exe` extension and a filename that includes "setup" or "installer" (for example: "GitHubDesktopSetup.exe" and "SWCarpentryInstaller.exe").

Because both `.msi` and `.exe` executable files can potentially contain viruses, you should always use caution when running them and only do the installation if you trust the source of the software.  You should only run installers that are from the official site of the organization producing the software and that website should support secure HTTP (https:// URLs).  

Generally, the installation process is fairly straightforward with perhaps a few questions about where to put files and whether you want to create shortcuts.  If the installer asks whether you want to add the path to your system PATH variable, you generally will want to answer "yes".

Once the installation is finished, the actual installer file is no longer needed and can be deleted from wherever it was saved (often your `Downloads` directory).  Deleting the installer will have no effect on the application itself.

## Java applications

In some cases, the application that you are installing is not run directly by the operating system, but instead is run by a Java virtual machine (VM).  A Java VM is a program that runs on the Windows system, but can itself run code that is platform-independent.  Typically that code is part of a file with a `.jar` file extension. 

The software that creates the VM is called the Java Runtime Environment (or JRE).  It is software that is downloaded and installed like any other software and the `.jar` file extension is then associated with it so that when you double-click on a file with that extension, it will automatically run in a Java VM.  Because Java is so common, someone may have already installed JRE on your computer when it was set up.  If you get a new computer, programs that you are used to running may fail to run because no one has yet installed JRE on it.  You can find the latest version of JRE [here](https://www.oracle.com/technetwork/java/javase/downloads/index.html).  Note that there are several flavors of Java available -- you probably just need the generic JRE.  The Java Development Kit (JDK) is for developers and the Server JRE is not needed by most typical users.

It is also possible that the program that you are using has an installer and creates a shortcut icon that runs a `.jar` file.  You may not even know that the application is running in a Java VM unless it fails and produces an error message telling you that you don't have JRE.  

## Applications that run on a localhost server

There are an increasing number of applications that involve setting up a web server on your local computer, then interact with it using a web browser.  These kind of applications are discussed in detail in [lesson 6](../command-windows/). 

# Software that runs in the background

Sometimes when you install an application, it will also install "helper" applications that run in the background all the time.  The helper applications are automatically launched when the computer boots up and continue to run all the time, mostly invisible to you.  The installer may or may not ask you whether you want the helpers to be installed.  

There are several categories of applications that run in the background. One category is launchers.  Large, frequently used software packages like Office components may take a long time to load, so parts of the software may be loaded when the computer boots so that it won't take as long to launch the application when the user wants to use it. Another common kind of background application is an updater.  It may run periodically to check whether there is a new version of the application that needs to be downloaded and installed.  A final category is applications that run in the background to maintain communication with web services that are critical to the operation of a user's system.  A good example of this is the Dropbox application that monitors the Dropbox folder locally and online to make sure that any changes in either location is immediately synchronized with the other location.  

<img src="../images-3-windows/open-with.jpg" style="border:1px solid black">

Often, these background applications have an icon in the system tray that show that they are running and allow you to monitor their status.  In the example above, the Dropbox icon is always visible and the Box icon is only visible when the up arrow to the left of the system tray is clicked.  You may have noticed the icons appearing in the system tray as the computer boots up.  That's an indication that these applications have started to run in the background.

In the past, a proliferation of applications running in the background was one of the main reasons why computers ran slower as they got older and more applications of this sort continued to accumulate.  Now most computers have enough memory that this isn't as much of a problem.  Nevertheless, you might want to check to see what applications are being launched automatically when your computer boots.  From the Start menu, select the Settings gear icon.

<img src="../images-3-windows/settings-uninstall.jpg" style="border:1px solid black">

Click on Apps, then the Startup item on the left bottom.  A list of applications that can run when the computer boots will appear on the right.  You can prevent any of these applications from launching at startup by turning their swith off.  The applications are rated by their impact on performance.  **Warning:** Be careful that you don't turn off any critical application.  For example, turning off Dropbox synchronization could be really bad if you depend on it to keep files synchronized among multiple computers, or if it serves as a first line system of backup.  

# Uninstalling software

By this point, you probably understand that installed software on Windows can be pretty complicated.  So it's not surprising that you can't just delete a file and get rid of it.  Even if you delete its entire subdirectory in `Program Files` or `Program Files (x86)`, there still may be registry entries, user files in the Users directory, helper applications running in the background, and shortcuts scattered around the computer.  Good software will have an uninstaller application that will cleanly remove every trace of the software and return system settings to what they were before the software was installed.  The uninstaller program is usually found somewhere in the program's installation directory.

However, in Windows 10 there is a built in system for uninstalling installed applications.  From the Start menu, select the Settings gear icon.

<img src="../images-3-windows/settings-uninstall.jpg" style="border:1px solid black">

Click on Apps.  It may take a while for the list of applications to populate.

<img src="../images-3-windows/uninstall-app.jpg" style="border:1px solid black">

Click on the application that you want to uninstall, then on the `Uninstall` button.  Follow the dialog until the application has been uninstalled. The application should then be removed from the application list.

