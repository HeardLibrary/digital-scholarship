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

<img src="../images-2b/branch-diagram.jpg" alt="branch" width="300"/>

There are several possible fates of a branch.  A common fate is for a branch is for it to be merged back into the master.  This can happen when the revision is complete, or if the feature has been debugged and is ready to be deployed.  You might also decide that development of the branch is hopeless and just delete it and return to the master.  In some cases, a branch may remain as a separate entity from the master, with no intention of ever merging it (this is common when using GitHub Pages to manage a website).  

## Deciding how to work

Although Github is designed for collaboration, it can be a useful tool even if you are working on something by yourself.  It provides a way to track your editing progress by versioning and makes it possible to revert to an earlier version if you really mess something up.  It's also a way to access your work on different computers.  Things get more complicated when you are working with others.

There are several ways you can work in your own repository or when collaborating in a shared repository.  There are additional options if you are working on an open source project where contributors don't have write access to the repository, but we'll talk about them in a later page.

If you are working by yourself creating a new document, or if you are making trivial changes, you may opt to edit the master branch directly.  However, if you are on a team and making substantial changes, or if you are working by yourself and are concerned that the changes you are making may not work out, it's better to create a separate branch and work on that.  Similarly, if changes are extensive and it will take a while to finish them, you will probably want to leave the master branch in a stable state until you've finished the changes.  You can then merge them into the master branch all at once to create a new version of it.  

In any case, before you can edit an existing document, you will need to decide on a branching strategy.   The number of branches also can influence the probability of creating merge conflicts when edits are made to a version that isn't the most recent one. When there are few branches with many people working on them, merge conflicts are more likely.  If there are more branches with fewer people working on each one, merge conflicts of this sort are less likely to arise.




[next page: cloning](../clone/)

----
Revised 2019-02-18
