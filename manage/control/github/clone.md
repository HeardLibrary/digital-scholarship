---
permalink: /manage/control/github/clone/
title: Cloning and the GitHub desktop client
breadcrumb: cloning
---

[previous page: Introduction GitHub](../intro/)

# Cloning a GitHub Repository to Your Local Computer

The *cloning* process involves creating a complete copy of a repository on your local computer.  That includes all of the branches in the repository and all of the commit histories of every branch.  

![Cloning process](../images-clone/clone.jpg)

Since your local copy of the repository contains every branch in the repository, how do you determine which branch you will actually be working with on your hard drive?  In Git, the process of switching branches is called "checking out" a branch.  When you check out one branch, you obtain a copy of it and you stop using another copy.  You can only have one copy checked out at a time.

## The GitHub desktop client

Although every Git operation can be carried out using the command line, many users prefer to use GitHub Desktop, a graphical interface for interacting with GitHub.  GitHub desktop is available for every major operating system at <https://desktop.github.com/>,  For detailed installation instructions, see [this handout](https://github.com/Ramona2020/learning-github/blob/master/Workshop%20I-III%20Handouts/Workshop-GitHubIntermediate.md).

## Cloning

You can initiate cloning of a repository from the website by clicking on the `Clone or download` button in the upper right of the repo page on the GitHub website. If you choose `Open in Desktop`, the repository will open in the GitHub Desktop software after it downloads.

<img src="../images-clone/clone-from-github.png" style="border:1px solid black">

You can also initiate the cloning process from your local computer from within the GitHub Desktop application.  The process described here will work for cloning one of your own repositories, a repository that you've forked to your account from elsewhere, or another repository that you don't own, but to which you have been given write access.

Drop down the Current Repository menu in the upper left of the window.  Click on the Add dropdown and select "Clone Repository...".

<img src="../images-clone/desktop-clone-option.png" style="border:1px solid black">

You'll be presented with a list of repositories at Github.com to which you have access.  Repos that you own or to which you have write access will show up with little book icons.  Repos that are clones of some other repo will have a little "fork" symbol.  Click on the name of the repo you want to clone and you'll have an opportunity to select where you want the local copy of the repo to live on your computer.  Once you've selected a location, the desktop client will default to that location the next time you clone.

<img src="../images-clone/desktop-clone-location.png" style="border:1px solid black">

## Working with cloned files

After you've finished the cloning process, in the left column of the client, you'll see either changed files or the commit history, depending on which tab you've selected.  

<img src="../images-clone/desktop-changed-files.png" style="border:1px solid black">

By dropping down the Current Repository list, you can switch to a different cloned repository. By default, the desktop client chooses the master branch of a newly cloned repo.  However, you can change from the master branch to another existing branch by dropping down the middle "Current Branch" menu at the top of the window.  GitHub desktop will remember what branch you were working on the next time you switch back to that repository.

<img src="../images-clone/current-branch.png" style="border:1px solid black">

When you select a branch in this dialog, you have checked out that branch.

Checking out a branch literally changes the files that are present on your local computer. For example, when I selected the master branch as my current branch, here's what several directories looked like:

<img src="../images-clone/master-branch-directory.png" style="border:1px solid black">

You can see that the pylesson directory has a lot of files in it and the lod directory doesn't.  If I change to the "gh-pages" branch:

<img src="../images-clone/change-to-gh-pages.png" style="border:1px solid black">

then I'm checking out a different set of files.  Here's what the directories look like now:

<img src="../images-clone/gh-pages-branch.png" style="border:1px solid black">

Some files have disappeared, like the ones in the pylesson directory, and other files have appeared in the lod directory.  The content of the files themselves may also change.  So it's important before you start working on files that you are clear what branch you currently have checked out.  It is also important to make sure that you've saved the files that you were working on before you check out a different branch in the same repository.  It is possible to lose unsaved changes if you don't.

## Work cycle

When you are editing files using GitHub desktop, it is important to have a disciplined work cycle to make sure that your work gets saved to the hub without merge conflicts.

![GitHub work cycle](../images-clone/work-cycle.png)

After you've decided what branch you need to work on, it's very important to make sure at the start that you are working on the most recent version of it by pulling any changes from Github. Click on the Fetch origin button at the upper right of the window.  If there are changes that need to be downloaded, you'll see a small number by a downward pointing arrow.  Click the button (now labeled "Pull origin") again to download those changes.

<img src="../images-clone/download-changes.png" style="border:1px solid black">

If you forget to update your local copy of the branch, you risk creating a conflict, since you may be working on a copy that isn't the most recent one.

Although you can use GitHub for version control on any type of file, the features of GitHub were designed with maintenance of text files in mind.  If you are editing a simple text file, there is no particularly compelling reason why you can't just do the editing in the browser using the built-in GitHub editor.  However, if you are editing a file that contains markup, such as Markdown or XML, or if you are editing code, it is probably easier to do the editing on your desktop using dedicated editing software.  Examples are [Oxygen](https://www.oxygenxml.com/) for XML and [Visual Studio Code](https://code.visualstudio.com/) (not actually part of Microsoft Visual Studio) for editing many kinds of code.  For working with GitHub, there are some advantages to using the Atom editor <https://atom.io/>.  Atom was developed by the GitHub team and has some useful features for working directly with GitHub.  There are a lot of plugins available for Atom that do syntax highlighting for different coding languages, and Atom also has a useful Markdown preview feature (available from the Packages menu).

To make an edit, navigate to the location where you checked out the repo.  Open a file, make some edits, then save it.  

If you click on the Changes tab at the upper left of the GitHub Desktop window, you should see the files that changed since the last update and clicking on a filename will show the kind of changes at the right of the screen (additions in red, deletions in green).  

<img src="../images-clone/file-changes.png" style="border:1px solid black">

Commit your changes.  You'll then see the new commit in the history and as a change that's ready to push up to GitHub.

<img src="../images-clone/make-commit.png" style="border:1px solid black">

Click on the `Push origin` button to push your changes from the desktop client to GitHub.

## Conflicts that occur when pushing

Sometimes when you attempt to push a commit, you have an unpleasant surprise: a warning saying that the repository has been updated since your last pull.

There are three common ways that this can happen. Sometimes you may be working on a document on one computer, then start working on it on a different computer having forgotten to pull the most recent commits from GitHub.

A second cause is to be working on one computer, forget to push changes at the end of the work cycle, then begin work on the document at another computer.  In this case, pulling the most recent commits doesn't help, because they never made it to GitHub.  If you then return to working on that other computer, you'll discover problems when the files on that computer are behind what's on GitHub

A third possibility is that you've been working on a document for a long time, and during that time, a collaborator made changes to the same document and pushed them to GitHub before you made your changes.  

In all three of these situations, version conflicts arise because work is being done on files that are not the most recent version. In many cases, the problem can be avoided by strict adherence to the work cycle outlined above.  Conflicts in edits carried out by different collaborators can be reduced by working on different branches, although those conflicts may still arise later when the branches are merged into the master.

## Resolving a conflict with Atom

Atom has a cool built-in feature for resolving version conflicts.  To illustrate, we'll use a scenario where my alter ego and collaborator, Tomy the Cat, has edited a Python script at the same time I was editing it.  Tomy made his edits using the online editor, changing the added number from 3 to 5:

<img src="../images-clone/first-conflicted-change.png" style="border:1px solid black">

However, I was working offline in a text editor and changed the added number to 1.  Here's what I see after I've saved the file and look at the Changes in GitHub Desktop:

<img src="../images-clone/second-conflicted-change.png" style="border:1px solid black">

Here's what happened when I tried to push my changes and discover that Tomy has changed something since I started working:

![Repo is outdated](../images-clone/repo-outdated.png)

The problem is pretty easy to fix if I've been using Atom as my text editor.  Here are the steps to fix the problem:

Go to the Repository menu and select Pull.

![Pull the repo](../images-clone/pull-repo.png)

I will then get a popup message like this:

![Conflict warning](../images-clone/conflict-detected.png)

If I click on the "Open in Atom" button, I'll get this screen in the Atom editor:

![Choose conflict](../images-clone/choose-conflict.png)

The editor presents me with a choice between my change and Tomy's change.  Of course I'm right, so I pick my change.  Now the popup has changed:

![Choose conflict](../images-clone/conflict-fixed.png)

and I can now commit the resolved file.

This process is a real lifesaver because it simplifies the otherwise complicated process of reconciling and merging conflicting files.  However, it's important to note that it is not graceful and is somewhat aggressive in that it bypasses the pull request process that is designed to resolve conflicts through dialog and consensus.  That's a compelling reason to create branches followed by pull requests rather than just having several collaborators working on the same file in the master branch.

[next page: branching](../branch/)

----
Revised 2019-10-02
