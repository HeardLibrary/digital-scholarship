---
permalink: /script/twine/github/
title: Publishing a Twine story using GitHub Pages
breadcrumb: GitHub Pages
---

# Publishing the Twine to a GitHub Pages website

From within Twine, click on the popup menu by the story name and select `Publish to File`

<img src="../publish.png" style="border:1px solid black">

Replace the story name with `index.html` and save in the root directory of your website repository.

<img src="../save_as.png" style="border:1px solid black">

In GitHub Desktop, you should see the new HTML file added to your website repository. Write a commit message and commit. Then click on the `Fetch origin` tab twice to push the commit to GitHub.

Enter the URL of the landing page for your GitHub pages website and press `Enter`. The twine story should be loaded into the browser.

<img src="../web_homepage.png" style="border:1px solid black">

# Loading the published Twine HTML page into the Twine editor

If someone in your group has changed the Twine since you last worked on it, you will need to pull the most recent version from GitHub and load it into the Twine app. 

In the Desktop Client, click `Fetch origin` to update the local copy of the repository from GitHub. Click the `History` tab to see how the file has changed.

<img src="../fetch_changes.png" style="border:1px solid black">

If necessary, click the little house icon in the Twine editor to return to the home screen. On the home screen, click on the `Import From File` link.

<img src="../import_link.png" style="border:1px solid black">

In the popup window, click the `Choose File` button, then navigate to the `index.html` file, and click the `Open` button.

<img src="../navigate_to_index.png" style="border:1px solid black">

Twine should recognize that the story you are importing is the same as an existing one. Check the box by the name of the existing story, then click the `Replace 1 Story` button.

<img src="../replace_existing.png" style="border:1px solid black">

Now open the Twine and you should see the changes. 

<img src="../changes_present.png" style="border:1px solid black">

# Work cycle

It is critical that you strictly follow the work cycle when working with collaborators. Otherwise, you will create version conflicts by making changes without incorporating the previous changes of your collaborators first.

![the GitHub work cycle](../work-cycle.png)

----
Revised 2021-09-02
