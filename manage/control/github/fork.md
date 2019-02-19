---
permalink: /manage/control/github/fork/
title: Forking a repo and the Open Source model
breadcrumb: forking
---

[previous page: cloning](../clone/)

# Forking a Repo and the Open Source Model

The last major concept in working with GitHub is *forking* a repository.  When you fork a repository, you are making your own personal copy of a repository that is part of a different organization or person's account.  Your fork (fork is both a noun and verb) of the repository is completely independent of the source repository, and changes you make to the fork have no effect on the original repository unless you use a pull request to merge your changes back into it.

<img src="../images-fork/forks.jpg" alt="branch" width="300"/>

There are two major reasons why you might want to fork someone else's repo.  One is to simply get a copy of the repo so that you can play with it.  In that case, you would fork the repo to your own account on the GitHub website, then use GitHub desktop to clone the repository to your local hard drive.  A simpler alternative would be to simply download the foreign repo as a zip file, then open the file somewhere on your hard drive.  The advantage of using the fork, then clone approach is that you can use the Git system to switch between branches in the forked repo and also potentially feed edits back to the original repo.  

The other major reason for forking is as a means to contribute to a project for which you do not have write (i.e. push) access.  This is a common situation for large open source projects, where there may be a large number of contributors, some of whom might not even be known to the repository owners.  In this model, you fork the project repository to your own account, edit the documents, then create pull requests asking the repository owners to consider pulling your recommended changes back into the original project. Because this process involves forking followed by pull requests, it's known as the ["fork and pull" model](https://help.github.com/articles/about-collaborative-development-models/) of collaboration.

## Fork and Pull Examples

Let's imagine a scenario involving me and my alter ego, Tomy the Cat.  I've started an open source collaborative project called the "Nashville Coding Cats" club and created a repo on my account called "code-cats-rock".  Tomy visits my site and is excited about participating.  Here's what he sees:

<img src="../images-fork/find-repo-to-fork.png" style="border:1px solid black">

After he clicks on the repository name, he clicks on the `Fork` button at the upper left of the repository summary page.  

<img src="../images-fork/click-to-fork.png" style="border:1px solid black">

If he has has push access to multiple accounts, he may need to choose which account to put the fork in.

The fork will now show up as a repository in his own account.  To prevent confusion, the name of forked repos is commonly displayed next to a little "fork" symbol to remind the user that the repo is from somewhere else.

<img src="../images-fork/forked-repo-summary.png" style="border:1px solid black">

At this point, the forked repo will show up on the list of repos that Tomy can clone in GitHub Desktop.  

[next page: managing projects](../projects/)

----
Revised 2019-02-18
