---
permalink: /manage/control/github/intro/
title: Introduction to Git and GitHub
breadcrumb: Intro
---

# Introduction to Git and GitHub

On this page, we'll talk about opening a GitHub account, creating a repo, and committing edits.

## Opening a GitHub account

You can open a free GitHub account by going to <https://github.com/>. The process is relatively simple - for detailed instructions, see [this workshop handout](https://github.com/Ramona2020/learning-github/blob/master/Workshop%20I-III%20Handouts/Workshop-GitHubBasics.md).  With a GitHub account, you can create an unlimited number of public repositories.  You can also create private repositories, but they are limited to three collaborators.

There are a number of things you can explore in the settings, such as your profile picture, email address, etc. One setting of which you should be aware is the notifications.  Two common ways to communicate with collaborators in GitHub are through @mentions and watching repos.  If you want to receive email notifications through these two means, you should enable it here.  If you are getting an annoying number of emails, this is also where you can turn it off.

<img src="../images-intro/notification-settings.png" style="border:1px solid black">

## Creating a Repository

Once you have an account you can create a new repository through the "+ menu in the upper right of the screen.  "

<img src="../images-intro/new-repo.png" style="border:1px solid black">

In the create repository dialog, you have several choices.  The most important is whether you want the repo to be public or not.  There are also three special files that can live in the root directory of the repository.  One is the .gitignore file. A .gitignore file is not required, but if you are using a coding platform that generates a lot of annoying extraneous files that you don't want to archive in GitHub, you can select a template .gitignore file for that platform that will ignore typical annoying files.

<img src="../images-intro/choose-gitignore.png" style="border:1px solid black">

If your repository is public, you should add a license file that is appropriate for the kind of content you will create in the repository.  If you are creating code and you want it to be open, many people use the [MIT License](https://opensource.org/licenses/MIT).  You can pick it or any other license from the dropdown list.  If you are creating textual content that you want to be usable by anyone, but with attribution, a [Creative Commons Attribution](https://creativecommons.org/licenses/by/4.0/) (CC BY) license is commonly used. It is not on the dropdown list, but the license file can be copied from [here](https://github.com/tdwg/dwc/blob/master/LICENSE).

<img src="../images-intro/choose-license.png" style="border:1px solid black">

If you are a Mac user, after you have created the repository, you may want to add this line to the .gitignore file:

```
.DS_Store
```

It's an annoying hidden file that automatically is created in Mac folders and will be an annoyance to any non-Mac users who use your material.

<img src="../images-intro/create-repo.png" style="border:1px solid black">

The third special file is called `README.md`.  When a repository or directory within a repository has a README.md file, it will automatically display when the repository or directory is opened on the GitHub website.  So it's an important way to let potential users know the purpose of the files in that directory.  When you've set up everything, click on the `Create repository` button.

<img src="../images-intro/add-ds-store-to-gitignore.png" style="border:1px solid black">

After you have created the repository (or clicked on a repository name in the repository list for your account), you'll see the list of files in the repository.  If you created a README.md page, it will also be displayed at the bottom of the page.  To create a new file using the online file editor, click the `Create new file` button.  You'll be at the same screen if you click on a file name, then click on the pencil icon at the upper right.

<img src="../images-intro/file-list.png" style="border:1px solid black">



<img src="../images-2b/commits.jpg" alt="branch" width="300"/>

<img src="../images-intro/make-commit.png" style="border:1px solid black">

<img src="../images-intro/file-summary.png" style="border:1px solid black">

<img src="../images-intro/commit-history.png" style="border:1px solid black">

[next page: branching](../branch/)

----
Revised 2019-02-18
