---
permalink: /manage/control/github/branch/
title: Branching and the Shared Repository model
breadcrumb: branching
---

[previous page: introduction to GitHub](../intro/)

# Branching and the Shared Repository Model

## Branches

On the previous page, we defined a *branch* as a set of files that changes over time.  A repository can have several branches at the same time and each one is maintained with its own record of commits over time.  

The main branch of a repository is called the *master* branch.  In a very simple repository, the master branch may be the only one.  But more commonly, there are several branches that have been created by *branching* them off of the master.  ("Branch" is both a noun and a verb in Git.)  When you create a branch from the master (or some other branch), it begins with exactly the same files as its source.  It also carries the commit record of its "parent" branch as well.  

The purpose of a branch is to allow for the development of documents independently of the master.  You might choose to create a branch if you want to develop a new feature of software you are developing, or you may create a branch if you are creating a significant revision of a document.  Working in a branch allows you to "take risks" without having to risk messing up the master.  

<img src="../../images-branch/branch-diagram.jpg" alt="branch" width="400"/>

There are several possible fates of a branch.  A common fate is for a branch is for it to be merged back into the master.  This can happen when the revision is complete, or if the feature has been debugged and is ready to be deployed.  You might also decide that development of the branch is hopeless and just delete it and return to the master.  In some cases, a branch may remain as a separate entity from the master, with no intention of ever merging it (this is common when using GitHub Pages to manage a website).  

## The Shared Repository model

The *[Shared Repository model](https://help.github.com/articles/about-collaborative-development-models/)*, is one of the two major ways that development is coordinated in a project.  In the shared repository model, all collaborators have write access to the repo.  This model is common when teams are small, and especially when development is not open to the public.  The other model, *Fork and Pull*, is common in large, open source projects where features may be created by contributors who aren't on the core team, and therefore don't have write access to the repository.  This model will be discussed in more detail later.

## Deciding how to work

Although Github is designed for collaboration, it can be a useful tool even if you are working on something by yourself.  It provides a way to track your editing progress by versioning and makes it possible to revert to an earlier version if you really mess something up.  It's also a way to access your work on different computers.  Things get more complicated when you are working with others because the probability of creating version conflicts is much greater.

There are several ways you can work in your own repository or when collaborating in a shared repository.  If you are working by yourself creating a new document, or if you are making trivial changes, you may opt to edit the **master branch** directly.  However, if you are on a team and making substantial changes, or if you are working by yourself and are concerned that the changes you are making may not work out, it's better to create a **separate branch** and work on that.  Similarly, if changes are extensive and it will take a while to finish them, you will probably want to leave the master branch in a stable state until you've finished the changes in another branch.  You can then merge the other branch into the master branch all at once to create a new version of the master.  In any case, before you can edit an existing document, you will need to decide on a branching strategy.  When in doubt, it is usually best to work in a separate branch.

The number of branches also can influence the probability of creating merge conflicts when edits are made to a version that isn't the most recent one. When there are few branches with many people working on them, merge conflicts are more likely.  If there are more branches with fewer people working on each one, merge conflicts of this sort are less likely to arise.

## Branching and merging with pull requests

When Tomy wanted to change the code, instead of committing his change directly to the master branch, he could have created a new branch.

<img src="../images-branch/create-branch-change.png" style="border:1px solid black">

After the "patch" branch is created, a new page opens to create a pull request:

<img src="../images-branch/create-pull-request.png" style="border:1px solid black">

Notice that the pull request includes an "@mention" with the my username.  That generates an email to the collaborator:

<img src="../images-branch/pull-request-email.png" style="border:1px solid black">

Clicking on the link to view the diff shows how the two branches differ:

<img src="../images-branch/online-diff.png" style="border:1px solid black">

The collaborator can follow the link in the email to the pull request dialog and approve the change if they want.

<img src="../images-branch/branch-pull-request.png" style="border:1px solid black">

After clicking Merge pull request, there's a confirmation and opportunity to comment.

<img src="../images-branch/confirm-merge.png" style="border:1px solid black">

A happy ending! The change was made without conflicts!

<img src="../images-branch/successful-merge.png" style="border:1px solid black">

Let's imagine a less happy ending. Perhaps I didn't see Tomy's email about the pull request and had gone ahead and made my change directly to the master branch before merging his patch branch.  That's generated a conflict that now shows up in the pull request dialog.

<img src="../images-branch/pull-request-merge-conflict.png" style="border:1px solid black">

Clicking on the Resolve conflicts button brings up the online editor showing where the conflicts lie:

<img src="../images-branch/online-conflict-resolution.png" style="border:1px solid black">

After editing the document so that the conflict is gone, click the Mark as resolved button, then click Commit merge.

<img src="../images-branch/online-conflict-resolved.png" style="border:1px solid black">

This merges the modified, unconflicted branch into the patch branch.  You'll then go back to the pull request screen and have an opportunity to merge the patch branch into the master branch. The pull request can then be merged and the patch branch deleted.

The creation of pull requests and resolving conflicts between branches can also be done offline, but the nice, linear record of the pull request history is best seen online.



[next page: cloning](../clone/)

----
Revised 2019-02-18
