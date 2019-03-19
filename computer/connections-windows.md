---
permalink: /computer/connections-windows/
title: Connected devices (Windows)
breadcrumb: Connections (Windows)
---

# Understanding my computer - Lesson 4: Connected devices

This is the Windows version of this page.  [Click for the Mac version of this page](../connections-mac/)

[go back to Lesson 3: Installing software](../installation-windows/)

# Physical ports

A computer can have a confusing array of physical ports where cables can be connected to the computer.  Over time, the number and kind of ports has been reduced and we will only be covering ports typically found on more recent models of computers.

## Display ports

Although laptops have built-in displays, most have a place where an external display can be connected - either to provide more screen space for the user, or to connect to a projection system like an LCD projector.  Let's look at some of the connectors from oldest to newest.

<img src="../images-4-pc/ports1.jpg" style="border:1px solid black">

One of the most longstanding types of display connection is *VGA* (vector graphics array), having been an option since the 1980's. For that reason, there are still many older PCs that have a VGA display output.  Many LCD projectors also have VGA as in input option.

<img src="../images-4-pc/ports7.jpg" style="border:1px solid black">

Since the early 2000's, HDMI (high-definition multimedia interface) has been an extremely popular way to connect to monitors.  Because it's the default for high definition television, it is now the most widespread system.  Most new desktops and many laptops now come equipped with HDMI ports.

<img src="../images-4-pc/ports4.jpg" style="border:1px solid black">

Recently, USB-C has been developed as an "everything" port that can connect to external displays as well as power supplies and peripherals.  Over time, it is likely to become more common as a way to connect to external displays.

<img src="../images-4-pc/usb-c-to-hdmi.jpg" style="border:1px solid black">

Since many external monitors (including LCD projectors) may not have any means to connect to a laptop that has only USB-C ports, an inexpensive converter can be purchased to allow the laptop to connect via an HDMI cable.

## USB ports

Since the 1990's USB (universal serial bus) connectors have been replacing the wide variety of connectors that were used previously.

<img src="../images-4-pc/ports3.jpg" style="border:1px solid black">

USB cords can have many different connectors.  The most common type for plugging into computers is the "type A" connector and it has been present on most computers since the 1990s.  

Over the years, USB technology has improved, with each of the versions 1.0, 2.0, and 3.0 greatly increasing the transmission speed from the previous version.  Fortunately, the versions are backwards compatable, so a USB 1.0 device can be plugged into a USB 2.0 or 3.0 port and a USB 2.0 device can be plugged into a USB 3.0 port as long as the connector type is the same.  The faster devices can also generally be plugged into an older port, although their performance will be limited by the speed supported by the older version.

<img src="../images-4-pc/ports4.jpg" style="border:1px solid black">

Very recently, USB-C has been introduced.  It is also backwards compatable with versions 1.0 through 3.0, but it uses the "type C" connector, so many devices cannot be plugged directly into a USB-C port.  One nice feature of the type C connector is that unlike the old type A connector, the type C connector can be inserted either way.

<img src="../images-4-pc/usb-c-to-usb-3.jpg" style="border:1px solid black">

For users with very new computers that have only USB-C ports, relatively inexpensive converters are available that will allow older devices with type A cords to be plugged into the new ports.

## Other connectors

<img src="../images-4-pc/ports4.jpg" style="border:1px solid black">

The most common other connection that is present on most computers is an audio out jack (more commonly known as the "headphone jack").  It is simply a small round hole.  

<img src="../images-4-pc/ports3.jpg" style="border:1px solid black">

If a computer has only a single jack, it is nearly always an audio out jack.  However, some computers have separate jacks for audio in (microphone) and audio out.  In that case, it is common for the headphone jack to be colored blue or green and the microphone jack to be colored red.

<img src="../images-4-pc/ports2.jpg" style="border:1px solid black">

There is a wide variety of connector types for power input.  The one shown above is typical for laptops.  

<img src="../images-4-pc/ports1.jpg" style="border:1px solid black">

On older laptops, it was common to provide an Ethernet port to enable a wired connection to the network.  With the widespread availability of WiFi, including Ethernet ports on laptops is increasingly uncommon.  (On this old laptop notice the difference between the Ethernet port, which has about 8 metal connectors and the largely useless modem phone jack in the previous picture, which has only 2 metal connectors).

# Device drivers and firmware updates

Because manufacturers build peripheral devices to work with a wide variety of computers and operating systems, a computer needs specific software that helps the computer to "talk" to the device.  This software is known as a *driver*.  Drivers for many devices are routinely included as part of the files associated with the operating system (OS).  When a newly acquired device (printer, monitor, external hard drive, etc.) is plugged into the computer for the first time, the *plug and play* system kicks in.  The device identifies itself to the system, and plug and play searches through the drivers that are available to try to find the best available one for the device.  

If the device is new and the OS is old, it's possible that the OS will use a more generic driver that will allow the device to work, but which might not support all of the features of the device.  In that situation, a user might be frustrated that fancy features of the new device don't work.  There probably isn't anything wrong with the device, it may simply be the case that a more recent driver needs to be installed after downloading it from the Internet.  Teaching you how to install new drivers is beyond the scope of this lesson, but it is realtively easy if you can get help from a more advanced user.

There may also be driver updates that fix bugs or patch security risks.  In some cases, the OS is able to learn that a newer driver is available and inform the user about it.  If that happens, it is usually a good idea to install the new driver.  

Drivers are software that resides on the computer.  But the device itself probably has its own software that it uses to communicate with the computer.  That software is often called *firmware*.  Sometimes there will be an update to a device's firmware that is intended to solve bugs or security problems.  Such firmware updates are usually downloaded from the Internet through the computer, but since the change needs to be made on the device, the new updated software has to be transferred from the computer to the device through a cable or WiFi.  

During the firmware update, erasable programable memory in the device (similar to the memory on a flash drive) has to be rewritten by transferring the new software from the computer to the device.  It's important that this process doesn't get interrupted since a disruption might cause the device to become non-functional.  A firmware update is something like a "brain transplant" for the device -- disrupting something during the "transplant" could cause the device to only have half a brain.

Once the firmware update is finished, any downloaded files on the computer aren't needed any more and can be deleted.

# Reinstalling a printer

**Note:** These instructions are intended to help solve problems related to printers directly attached to a computer or through a home network.  Printers connected through the Vanderbilt network are more complicate and you'll probaby need help with them.

If all goes well when you first connect a printer, plug and play will install the drivers and create a printer connection automatically.  However, sometimes a computer refuses to connect to a printer that is turned on and otherwise ready to go.  It is unlikely that you'll ever be able to figure out what the problem is, but fortunately, you can just create a new connection to the computer.

<img src="../images-4-pc/devices-option.png" style="border:1px solid black">

Click on the Start menu, then the gear icon (Settings). This will take you to the Settings screen.  Click on the`Devices` item.  

<img src="../images-4-pc/printer-options.png" style="border:1px solid black">

Click on the `Printers` item in the list at the left.  On the right you'll see a list of all of the printers that have connections.  The offending printer (ET0021B73840FD) says it's offline, even though it's turned on, connected and running.  Click on the printer name.

<img src="../images-4-pc/remove-printer.png" style="border:1px solid black">

Click on the `Remove device` button that shows up below the printer name.  Don't worry -- we aren't actually doing anything to the device.  You also don't need to physically "remove" or unplug the printer.  

After the printer has disappeared, click on the `Add a printer or scanner` plus (`+`) button.  

<img src="../images-4-pc/searching.png" style="border:1px solid black">

The computer will search for computers connected (directly or through the local network) for any printers.  

<img src="../images-4-pc/found-printer.png" style="border:1px solid black">

The computer has found the printer (ET0021B73840FD) again.  

<img src="../images-4-pc/add-device.png" style="border:1px solid black">

Click on `Add device`.

<img src="../images-4-pc/add-printer-options.png" style="border:1px solid black">


<img src="../images-4-pc/printer-ready.png" style="border:1px solid black">

After the computer has recreated the printer connection, it will appear on the list of available printers -- this time without any "Offline" message.

# Using multiple monitors

<img src="../images-4-pc/right-click-desktop.jpg" style="border:1px solid black">

Right-click on the desktop.  Select `Display Settings`.

<img src="../images-4-pc/display1.png" style="border:1px solid black">

If necessary, click on `Display` in the left column. You'll see a diagram of your displays on the right.  In this example, display 1 is the built-in laptop display and display 2 is a large external monitor.  You can drag the two displays around until they match the physical configuration of the displays on your desk.  For example, if the external monitor is to the left of the laptop, drag display 2 to the left of display 1.  If the displays are different sizes, you can also move them up and down so that the tops or bottoms line up.  

<img src="../images-4-pc/display2.png" style="border:1px solid black">

Scroll down 

----
Revised 2019-03-18
