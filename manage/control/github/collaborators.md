---
permalink: /manage/control/github/collaborate/
title: Working with collaborators
breadcrumb: Collaborate
---

[previous page: cloning](../clone/)

# Collaborators

Collaborators are determined on a repository by repository level. Granting a user access to one repository in your account does not grant them access to all.

## Inviting a collaborator

Find out the username of the person you want to invite to collaborate with you. Either collaborator can set the repo up, but it can only be on one person's GitHub account. If you don't want the repo to belong to any particular person, you can set up an organization. See the lesson on [managing projects](../projects/) for more on that.

![alter ego image](../images-collaborate/alter_ego.png)

In this example, I'm going to invite Tomy, my alter ego who uses my test `baskauf` account, to share a repository on my real GitHub account `baskaufs` (with an "s"). Go to a repository you want to share and click on the `Settings` tab.

<img src="../images-collaborate/setting_menu.png" alt="menu location"/>

Click on the `Manage access` link.

<img src="../images-collaborate/access_link.png" alt="access link"/>

You may be asked to provide a password to confirm access.  Click on the `Invite a collaborator` button.

<img src="../images-collaborate/invite_button.png" alt="invite collaborator button"/>

In the popup, start typing the name of the collaborator you want to invite and select it from the list when it appears.

<img src="../images-collaborate/select_collaborator.png" alt="select collaborator dialog"/>

Click the `Add ...` button.

<img src="../images-collaborate/add_button.png" alt="add to repo button"/>

You should see them as a pending invitation in the list of collaborators.

<img src="../images-collaborate/pending.png" alt="pending on list"/>

When Tomy checks his email, he should see an invitation to collaborate and a link.

<img src="../images-collaborate/invite_email.png" alt="invitation email"/>

Sometimes the email takes too long to arrive, or gets sent to spam. If so, the invited collaborator can speed up the process by attaching `/invitations` to the end of the repository URL. If they are logged into GitHub, they should see their invitation at that link.

Here is what Tomy sees when he goes to that link. 

<img src="../images-collaborate/invitation_page.png" alt="invitation page"/>

When he clicks on the `Accept invitation` button, he will be taken to your repository, where he'll see a notification at the top of the screen saying he now has push access to the shared repo.

<img src="../images-collaborate/push_access.png" alt="push access notification"/>

## Accessing the shared repository

Once the collaborator has push access, they can clone it using GitHub Desktop and start using it just as they would one of their own repos.  

To clone the newly shared repository using Desktop, Tomy should drop down the arrow to the right of the current repository name, then drop down `Add`, followed by `Clone Repository...`.  

<img src="../images-collaborate/repos_to_clone.png" alt="list of shared repositories to clone"/>

On the GitHub.com tab, he will scroll down past his own repositories until he sees his collaborator's account name. Under that account, he should see the newly shared repository. After he selects it and chooses the location in the directory where he wants it to go, he clicks the `Clone` button and starts using it.

[next page: Branching](../branch/)

----
Revised 2021-09-23
