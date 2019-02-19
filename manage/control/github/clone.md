---
permalink: /manage/control/github/clone/
title: Cloning a GitHub repository to your local computer
breadcrumb: cloning
---

[previous page: branching](../branch/)

# Cloning a GitHub Repository to Your Local Computer

(still under development)

In addition to cloning a repository from the website side, you can also clone from your local computer using the GitHub desktop client.  The process described here will work for cloning one of your own repositories, a repository that you've forked to your account from elsewhere, or another repository that you don't own, but to which you have been given write access.

Drop down the Current Repository menu in the upper left of the window.  Click on the Add dropdown and select "Clone Repository...".

![Select clone option](../images-branch/desktop-clone-option.png)

You'll be presented with a list of repositories at Github.com to which you have access.  Repos that you own or to which you have write access will show up with little book icons.  Repos that are clones of some other repo will have a little "fork" symbol.  Click on the name of the repo you want to clone and you'll have an opportunity to select where you want the local copy of the repo to live on your computer.  Once you've selected a location, the desktop client will default to that location the next time you clone.

![Select clone location](../images-branch/desktop-clone-location.png)

![Cloning process](../images-branch/clone.jpg)

## Working with cloned files

After you've finished the cloning process, in the left column of the client, you'll see either changed files or the commit history, depending on which tab you've selected.  

![Changed files](../images-branch/desktop-changed-files.png)

By dropping down the Current Repository list, you can switch to a different cloned repository, including one that you cloned from the GitHub website side. By default, the desktop client chooses the master branch of a newly cloned repo.  However, you can change from the master branch to another existing branch by dropping down the middle "Current Branch" menu at the top of the window.  

![Current branch](../images-branch/current-branch.png)

When you select a default branch in this dialog, we say that your are "checking out" that branch. Checking out a branch literally changes the files that are present on your local computer. For example, when I selected the master branch as my current branch, here's what several directories looked like:

![Master branch directory](../images-branch/master-branch-directory.png)

You can see that the pylesson directory has a lot of files in it and the lod directory doesn't.  If I change to the "gh-pages" branch:

![Change to gh-pages branch](../images-branch/change-to-gh-pages.png)

then I'm checking out a different set of files.  Here's what the directories look like now:

![gh-pages branch](../images-branch/gh-pages-branch.png)

Some files have disappeared, like the ones in the pylesson directory, and other files have appeared in the lod directory.  The content of the files themselves may also change.  So it's important before you start working on files that you are clear what branch you currently have checked out.  

![GitHub work cycle](../images-branch/work-cycle.png)

## Work cycle

When you are editing files using GitHub desktop, it is important to have a disciplined work cycle to make sure that your work gets saved to the hub without merge conflicts. After you've decided what branch you need to work on, it's very important to make sure at the start that you are working on the most recent version of it by pulling any changes from Github. Click on the Fetch origin button at the upper right of the window.  If there are changes that need to be downloaded, you'll see a small number by a downward pointing arrow.  Click the button (now labeled "Pull origin") again to download those changes.

![Download changes](../images-branch/download-changes.png)

If you forget to update your local copy of the branch, you risk creating a conflict, since you may be working on a copy that isn't the most recent one.

Let's open a text editor (Use Notepad today, but I recommend installing ATOM, [https://atom.io/](https://atom.io/), for your personal use).  Navigate to the location where you checked out the repo.  Make some changes to the _**TakeAways.md**_ file, then save it.  If you click on the Changes tab at the upper left of the window, you should see the files that changed since the last update and clicking on a filename will show the kind of changes at the right of the screen.  

![File changes](../images-branch/file-changes.png)

Commit your changes.  You'll then see the new commit in the history and as a change that's ready to push up to GitHub.

![Make commit](../images-branch/make-commit.png)

 Click on the **Push origin** button to push your changes from the desktop client to GitHub.com.



[next page: forking](../fork/)

----
Revised 2019-02-18
