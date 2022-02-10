---
permalink: /manage/control/github/patch/
title: Creating a patch branch online
breadcrumb: patch
---

[return to collaborative project management on GitHub](../../../../script/codegraf/042/)

# Creating and merging a patch branch

The following example shows how a branch can be created to make a minor change to the master using the online editor.  More extensive changes are typically done offline using a text editor and the desktop client.  

In this example, my alter ego Tomy the Cat and I will collaboratively make a change to some code we are writing for a project.  

## Creating a patch branch

Tomy changed the code in the file using the online text editor. He clicked the `Preview changes` tab to highlight the changes he made to the code.  Instead of committing directly to the master branch, he chose to create a new branch containing the change.  By default a "patch" branch name is suggested.  For more extensive sets of changes, a more descriptive name is better.

<img src="../images-branch/create-branch-change.png" style="border:1px solid black">

After the "patch" branch is created, a new page opens to create a *pull request*. A pull request is a way to open dialog about a proposed change.  It does NOT necessarily mean that the creator of the pull requests wants the change to immediately be pulled into the master branch.  In this case, since the change is minor, it will probably be merged immediately.  But often pull requests hang around for months as the collaborators "get things right" in the working branch before the final changes are pulled in to the master.   

<img src="../images-branch/create-pull-request.png" style="border:1px solid black">

Notice that the pull request included an "@mention" with my username.  That generates an email to the collaborator (me) since my account is set to send emails for @mentions.

<img src="../images-branch/pull-request-email.png" style="border:1px solid black">

Clicking on the link to view the diff shows how the two branches differ:

<img src="../images-branch/online-diff.png" style="border:1px solid black">

The collaborator can follow the link in the email to the pull request dialog and approve the change if they want.

<img src="../images-branch/branch-pull-request.png" style="border:1px solid black">

After clicking Merge pull request, there's a confirmation and opportunity to comment.

<img src="../images-branch/confirm-merge.png" style="border:1px solid black">

A happy ending! The change was made without conflicts!  Since this was a minor change and there is little likelihood that we will want to look at the branch again, it's probably safe to just delete the patch branch.

<img src="../images-branch/successful-merge.png" style="border:1px solid black">

## Resolving a merge conflict

Let's imagine a less happy ending. Perhaps I didn't see Tomy's email about the pull request and I had gone ahead and made a different change directly to the master branch before seeing his pull request to merge his patch branch.  That's generated a conflict that now shows up in the pull request dialog.

<img src="../images-branch/pull-request-merge-conflict.png" style="border:1px solid black">

Clicking on the Resolve conflicts button brings up the online editor showing where the conflicts lie:

<img src="../images-branch/online-conflict-resolution.png" style="border:1px solid black">

After editing the document so that the conflict is gone, click the Mark as resolved button, then click Commit merge.

<img src="../images-branch/online-conflict-resolved.png" style="border:1px solid black">

This merges the modified, unconflicted branch into the patch branch.  You'll then go back to the pull request screen and have an opportunity to merge the patch branch into the master branch. The pull request can then be merged and the patch branch deleted.

In this example, the conflict arose because I had made edits directly to the master branch.  However, if a team is working on several working branches, it's possible that merging one of the branches into the master will generate a conflict later on when another working branch is ready to be merged.  Although these sorts of conflicts are nearly impossible to avoid altogether, they can be minimized if the features that are being worked on in one branch primarily involve different sets of files than features being developed in a different branch.


[return to collaborative project management on GitHub](../../../../script/codegraf/042/)

----
Revised 2022-02-10
