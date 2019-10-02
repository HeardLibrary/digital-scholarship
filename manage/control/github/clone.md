---
permalink: /manage/control/github/clone/
title: Cloning and the GitHub desktop client
breadcrumb: cloning
---

[previous page: Introduction to GitHub](../intro/)

# The GitHub desktop client

Although every Git operation can be carried out using the command line, many users prefer to use GitHub Desktop, a graphical interface for interacting with GitHub.  GitHub desktop is available for every major operating system at <https://desktop.github.com/>.  

# Cloning

The *cloning* process involves creating a complete copy of a repository on your local computer.  That includes all of the branches in the repository and all of the commit histories of every branch.  

![Cloning process](../images-clone/clone.jpg)

Since your local copy of the repository contains every branch in the repository, how do you determine which branch you will actually be working with on your hard drive?  In Git, the process of switching branches is called "checking out" a branch.  When you check out one branch, you obtain a copy of it and you stop using another copy.  You can only have one copy checked out at a time.

## Cloning a GitHub Repository to Your Local Computer

You can initiate cloning of a repository from the website by clicking on the `Clone or download` button in the upper right of the repo page on the GitHub website. If you choose `Open in Desktop`, the repository will open in the GitHub Desktop software after it downloads.

<img src="../images-clone/clone-from-github.png" style="border:1px solid black">

You can also initiate the cloning process from your local computer from within the GitHub Desktop application.  The process described here will work for cloning one of your own repositories, a repository that you've forked to your account from elsewhere, or another repository that you don't own, but to which you have been given write access.

Drop down the Current Repository menu in the upper left of the window.  Click on the Add dropdown and select "Clone Repository...".

<img src="../images-clone/desktop-clone-option.png" style="border:1px solid black">

You'll be presented with a list of repositories at Github.com to which you have access.  Repos that you own or to which you have write access will show up with little book icons.  Repos that are forks you've made of some other user's repo will have a little "fork" symbol.  Click on the name of the repo you want to clone and you'll have an opportunity to select the directory where you want the local copy of the repo to live on your computer.  Once you've selected a location, the desktop client will default to that location the next time you clone.

<img src="../images-clone/desktop-clone-location.png" style="border:1px solid black">

After you've finished the cloning process, in the left column of the client, you'll see either changed files or the commit history, depending on which tab you've selected.  The second column ("Current Branch") will normally be set at "master" unless you have created another branch.  More on this in the next lesson...

<img src="../images-clone/desktop-changed-files.png" style="border:1px solid black">

# Simple models for using GitHub

The simplest way to use GitHub is simply as a way to archive the history of your own work on files in a project.

<img src="../images-ways/personal-model.png" alt="personal version control diagram"/>

In this model, you just simply work as usual on your local computer using your preferred text or code editor.  Create commits after each stage in the work, then push the changes to GitHub.  

If you are only working on one computer, the changes will generally only flow in one direction.  However, if you are working on more than one computer, or if you are working with a collaborator, it's important to pull changes from GitHub each time you start working in order to avoid missing changes that were made on another computer or by a collaborator.

## Work cycle

When you are editing files using GitHub desktop, it is important to have a disciplined work cycle to make sure that your work gets saved to the hub without merge conflicts.

![GitHub work cycle](../images-clone/work-cycle.png)

After you've decided what branch you need to work on, it's very important to make sure at the start that you are working on the most recent version of it by pulling any changes from Github. Click on the Fetch origin button at the upper right of the window.  If there are changes that need to be downloaded, you'll see a small number by a downward pointing arrow.  Click the button (now labeled "Pull origin") again to download those changes.

<img src="../images-clone/download-changes.png" style="border:1px solid black">

If you forget to update your local copy of the branch, you risk creating a conflict, since you may be working on a copy that isn't the most recent one.

Although you can use GitHub for version control on any type of file, the features of GitHub were designed with maintenance of text files in mind.  If you are editing a simple text file, there is no particularly compelling reason why you can't just do the editing in the browser using the built-in GitHub editor.  However, if you are editing a file that contains markup, such as Markdown or XML, or if you are editing code, it is probably easier to do the editing on your desktop using dedicated editing software.  Examples are [Oxygen](https://www.oxygenxml.com/) for XML and [Visual Studio Code](https://code.visualstudio.com/) (not actually part of Microsoft Visual Studio) for editing many kinds of code.  For working with GitHub, there are some advantages to using the Atom editor <https://atom.io/>.  Atom was developed by the GitHub team and has some useful features for working directly with GitHub.  There are a lot of plugins available for Atom that do syntax highlighting for different coding languages, and Atom also has a useful Markdown preview feature (available from the Packages menu).

## Editing and committing

To make an edit, navigate to the directory where you checked out the repo.  Open a file, make some edits, then save the file.  

If you click on the Changes tab at the upper left of the GitHub Desktop window, you should see the files that changed since the last update and clicking on a filename will show the kind of changes at the right of the screen (additions in red, deletions in green).  

<img src="../images-clone/file-changes.png" style="border:1px solid black">

Commit your changes.  You'll then see the new commit in the history and as a change that's ready to push up to GitHub.

<img src="../images-clone/make-commit.png" style="border:1px solid black">

Click on the `Push origin` button to push your changes from the desktop client to GitHub.

[next page: branching](../branch/)

----
Revised 2019-10-02
