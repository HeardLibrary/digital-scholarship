---
permalink: /computer/backup-windows/
title: Backing up your computer (Windows)
breadcrumb: Backup (Windows)
---

# Understanding my computer - lesson 5: Backing up your computer

This is the Windows version of this page.  [Click for the Mac version of this page](../backup-mac/)

[go back to Lesson 4: Installing software](../connections-windows/)

# Risks and considerations

If you use a computer for any significant amount of time, you will potentially encounter some kind of disastrous loss of data.  A loss of data can result in a huge loss of time and money and it may not be possible to ever recover some of the data.  The trite response to this problem is to "always back up your work".  But what exactly does that mean?  It's helpful to think about the categories of ways that one can lose data, because those different categories can have different solutions.

The most obvious way to lose data is simply to lose the files that contain the data.  There are a number of ways this can happen:

- you accidentally delete the files
- someone steals your computer
- you get a bitlocker virus and your hard drive is encrypted
- your hard drive crashes

The obvious solution to this problem is to make copies of your files and put them somewhere else.  There are several ways you can do that:

- put copies on a flash drive or external drive
- burn copies onto a CD or DVD
- put copies on the cloud using Box, Dropbox, or some other cloud service.

## Time risk

One complicating factor is the frequency of backup.  If you manually copy files to some other device, then the longer you wait between backups, the greater the amount of data you could lose.  If you back up daily, you could lose up to a days worth of work.  If you back up weekly, you could lose up to a week's worth of work.  

A simple solution to this problem would be to do the backups as frequently as possible.  However, depending on how long it takes to do the backup process, you could waste a lot of time just running the backup if the process is slow.  The ultimate solution would be to use a cloud service like Dropbox or Box that automatically *synchronizes* ("synchs") files every time you save them.  

## Overwrite risk

Although automatic synch sounds great, that introduces another risk: the risk of overwrting a good file with a bad one.  Let's say that you've been working on a draft of a document for a week and you keep that document in your Dropbox folder.  For some reason, you don't notice that you deleted a large section of the document and you save the draft with the deleted section.  Since the synch happens immediately, the good copy in the cloud immediately gets overwritten by the bad copy and you've lost your data.  (Dropbox actually has a feature for recovering deleted files for some period of time, but that's beyond the scope of this lesson.)

A solution to this problem is *version control*.  In version control, you create distinct versions of your document as you work rather than always overwriting eariler versions with the latest version.  A simple version control system is to create a new version of a file each day that you work on it and append the [ISO 8601 date](https://en.wikipedia.org/wiki/ISO_8601) to the end of the file name.  Here's an example:

```
gis-project-2019-03-04.xlsx
```

With a system like this, you would not lose more than a day's worth of work if you made the mistake of saving a bad version with a big deletion or other kind of mess-up related to the working file.  Because of the format used for the date, when the files are sorted, they are ordered from oldest to newest, and it's extremely easy to see what the state of the file was at any particular time.  If the system were also combined with a cloud service, you would also be protected against hazards like a hard-drive crash or loss of your computer.  With the free Dropbox account, you can restore a previous version of a file within 30 days of the change, so if you were a victim of a bitlocker virus, you could recover the files as long as you discovered the attach 

There are much more sophisticated version control systems than this.  [This page](../../manage/control/) has links to more information on the topic of version control.

## Backup tradeoffs

The discussion so far assumes that you are working on a project that's limited to a single file.  Many projects involve multiple files that may be added or deleted over time.  It generally isn't practical to try to manage copying a large number of individual files to or deleting them from the backup media.  Instead, we need a system that automatically takes care of backing up all of the files in the system at once.

There are many varieties of backup systems, but the fall into two broad categories.  A *full backup* makes a copy of all of the files that are included in the scope of files to be backed up.  An *incremental backup* backs up only files that have changed (added or modified) since the last backup.  In an incremental backup system, you start with a full backup, then run additional incremental backups at intervals after that.

A full backup has the advantage that it's easy to restore.  All you need to do is copy all of the files back to your original system.  It has the disadvantages that it can take a long time to run if there are a lot of files involved and can take up a lot of space if you keep copies of multiple past backups.  

An incremental backup has the advantage that it runs much more quickly since only recently changed files need to be copied.  It also doesn't take much space since many of the files in the scope of the backup don't change from backup to backup.  It has the disadvantage that it takes longer to restore the system because you have to start by restoring the last full backup, then restore every incremental backup from then until the present time.  An additional problem arises if the incremental backup system only tracks files that have been changed or added and not files that were deleted.  Over time, the number of deleted files in the system will increase and if the system is restored by working through all of the incremental backups, the restored system may have many files present that were actually deleted when the original copy failed.

A good compromise is to carry out a new full backup after a certain number of incremental backups.  For example, you could run a full backup once a month and incremental backups twice a week.

## Scope

The simplest way to back up your system would be to simply copy your entire hard drive to the backup system with each full backup.  That idea has two problems.  The first is that your backup media would have to have a size that was a multiple of your entire hard drive for each full backup.  The second is that it would take a very long time to carry out the backup.

A better system would be to make sure that the files that you actually change over time are isolated into one particular part of the computer (your Documents directory, for example).  You could then limit the backups to that directory under the assumption that if you had a drive loss or computer theft that you could reinstall the software from its original source.  This strategy does require that you redo all of the software customization any time you have to restore the system.  

## Physical risks

One final thing to take into consideration is the risk of catastrophic destruction to the media itself.  For example, if your backup media are stored in the same building as the system that is being backed up, both could be lost in a fire, flood, or tornado.  You should also consider that any media (including DVDs and hard drives) could be degraded over time.  So for critical data, it's good to have more than one backup copy stored offsite from the system that's being backed up.  

Cloud storage systems provide good protection against this hazard, although they introduce their own hazards. For example, if a computer or phone that's linked to a Dropbox account is stolen, a malicious thief could delete all of the files in the account using the device.  A disgruntled or incompetent collaborator or employee who has access to a shared account could also delete all of the files.

# Windows 10 File History backup

Windows 10 has a built-in system for backups, called *File History*.  File History backs up the files in your user directory.  That includes whatever you have in Documents, Pictures, etc., plus many of the personalized settings that live in your user folder.  

Before you start your first backup using File History, make sure that the drive where you are going to do the backup has sufficient space for at least the initial full backup.  Navigate to your user folder, then right click on it and select Properties.  It may take some time for the system to add up the size of all of the files.  You will actually want the media to have a capacity significantly larger than the total, since you will be adding files to it over time.

To access File History, click on the Start menu, then the Settings gear icon.

<img src="../images-5-pc/settings-update.jpg" style="border:1px solid black">

On the Settings page, select `Update & Security`.

<img src="../images-5-pc/backup-option.png" style="border:1px solid black">

Connect your removable media if you aren't using a drive connected through the network. 

Click on the plus (`+`) button to the left of `Add a drive`.  When the drive shows up, click on its name.

The process of archiving all of the files for the first time may take quite a bit of time.  When it's finished a slider labeled `Automatically back up my files` will appear.  By default, File History will back up the files once an hour.  If the drive is a removable drive, it obviously will need to be attached in order for the scheduled backup to take place.  For that reason, a network drive may be desirable for this purpose.  

To use different settings than the defaults, click on the `More Options` link under the drive list.  Click on the `See advanced settings` link.  A new window will open. 

<img src="../images-5-pc/file-history-settings.png" style="border:1px solid black">

At the left side of the screen, there are several links that can be used to change the default settings.  The `Advanced Settings` link allows you to change the backup interval to a time up to one day.  The `Exclude Folders` link lets you specify subdirectories within your home folder that should NOT be backed up.  The `Restore Files` link takes you to a screen that will allow you to recover files from the backup.

## Alternatives to File History

The requirement that the backup device be connected to your system is one drawback of the File History system.  There are a number of commercial products that provide alternatives.  

One product is Clickfree, an external hard drive that automatically launches a backup program when it is plugged into the USB port.  You control the backup interval by how often you plug it in.  An advantage of the system is that you can disconnect the drive and store it in a safe, fireproof box, or offsite to protect against physical damage or infection by a bitlocker virus.  A disadvantage is that it requires you to remember to plug it in regularly.

Another possible alternative is to attach a regular non-USB hard drive (magnetic media or solid state)  using an external drive dock that connects by USB.  If you have several large-capacity drives salvaged from old desktop systems, you can store a number of full backups on a single drive by simply dragging and dropping the entire folder to be backed up.  The drives can be undocked and stored in a safe location away from the computer. This shares the same disadvantage of the Clickfree in that you need to remember to plug in the drive and do the copy.

# Some suggestions

For individual files that are being edited, use the dated-version system with cloud storage (Box or Dropbox), or use a private repository in [Github](../../manage/control/github/). When the file revision is complete, a final copy can be stored in a permanent location and most or all of the dated versions can be deleted.

For most of the files you edit, keep them within your user directory and use File History to make regular copies to a network server (if one is available).  Use a frequent update interval (some time less than a day).

Once a week, use a removable drive to do a full backup of your user directory, and store the drive offsite or in a safe location.  If your backup drive is large and the size of your user directory is relatively small, you should be able to save a number of past versions of your user directory.  

Having three copies of your data, including copies offsite, should protect you against most risks.  Not only will it make restoring your data easier after a disaster, it also will position you for setting up a new, upgraded computer at some point in the future.

[go on to Lesson 6: Command line](../command-windows/)

----
Revised 2019-03-21

