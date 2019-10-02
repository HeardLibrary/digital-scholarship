---
permalink: /manage/control/github/conflicts/
title: Resolving merge conflicts
breadcrumb: conflicts
---

[Cloning and the GitHub desktop client](../clone/)

[GitHub resources](../)

# Conflicts that occur when pushing

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

[Cloning and the GitHub desktop client](../clone/)

[GitHub resources](../)

----
Revised 2019-10-02
