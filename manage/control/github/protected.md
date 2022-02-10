---
permalink: /manage/control/github/protected/
title: Protected branches on GitHub
breadcrumb: protected
---

[return to collaborative project management on GitHub](../../../script/codegraf/042/)

## Protected branches

The instructions above assume that all collaborators have unrestricted push access to the repository. In order to add a degree of protection to the `main` branch (or any other branch), it can be *protected* by adding additional requirements that make it more difficult to change. For more details, go to [this page](../protected/).

There are a number of [rules that can be put into place](https://docs.github.com/en/github/administering-a-repository/about-protected-branches) to protect a branch. One of the simplest and easiest to implement is [requiring a review](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/approving-a-pull-request-with-required-reviews) before merging. 

<img src="../images-branch/protect-rules.png" style="border:1px solid black">

To set up a branch protection rule, click the `settings` tab, then the `Add rule` button.

<img src="../images-branch/rule-setup.png" style="border:1px solid black">

To require a review to merge a pull request into the `main` branch, enter `main` as the Branch name pattern. (Other more complicated patterns are possible to require reviews on multiple branches.) Check the `Require pull request reviews before merging` checkbox and select a number of required reviews using the dropdown. 

The review requirement does not apply to users with administrative privileges. For repositories in accounts owned by individuals, the individual owner is the only user with admin privileges and they cannot assign administrative privileges to other users. Organizational accounts allow designation of collaborators as Owners with full administrative access to the organziation. (See the [next lesson](../projects/) for more information about organizations and teams.) However, as of 2021-01-26, only paid organizational accounts can set up protected branches. So individual account owners and paid organizational account collaborators who have been granted admin status can commit directly to `main` or merge their own branches without review. Other collaborators must request a review.

<img src="../images-branch/required-review.png" style="border:1px solid black">

When non-administrator users want to commit to the `main` branch, they are required to use a branch with a reviewed pull request. 

<img src="../images-branch/review-required.png" style="border:1px solid black">

When they create the pull request, it will be flagged as requiring a review. In the example above, the account owner was suggested as a reviewer, although any collaborator with write access can be the reviewer.

<img src="../images-branch/reviewer-view.png" style="border:1px solid black">

The person from whom the review has been requested will receive a notification. When they go to the pull request, they will see an `Add your review` button that will allow them to generate a review. Alternatively, if they are an administrator they can simply merge the pull request directly without reviewing.

<img src="../images-branch/review-form.png" style="border:1px solid black">

When they write their review, they will have three options. If they approve the review, either they or anyone else with write access (including the person requesting the review) can do the merge. If they comment or request changes, the merge cannot take place without another review or the merge being done by an adminstrator.

<img src="../images-branch/re-request-review.png" style="border:1px solid black">

If the reviewer requested revisions, the creator of the pull request can re-request a review using the `...` dropdown by the change request notification.

## Protected branches and the Desktop client

In the previous examples, editing was done using the web editor. If editing is done locally on a protected branch by a non-administrator, the user will be informed that the branch is protected.

<img src="../images-branch/desktop-protected-notification.png" style="border:1px solid black">

This does not prevent the user from trying to make commits to the protected branch (`main` in this example). 

<img src="../images-branch/desktop-protected-error.png" style="border:1px solid black">

However, if the user tries to push, an error will be generated. In that case, the best option is to undo the commit.

<img src="../images-branch/desktop-protected-new-branch.png" style="border:1px solid black">

Instead of pushing to the `main` branch, create a new branch. 

<img src="../images-branch/desktop-error-create-branch.png" style="border:1px solid black">

Enter a name, then click `Create Branch`.

<img src="../images-branch/new-branch-pull-request.png" style="border:1px solid black">

Now the user can create a pull request for the new branch. Clicking the `Create Pull Request` button will go to the GitHub website, where the pull request will proceed as in the examples above.

## Protected branches and code owners

<img src="../images-branch/code-owners-option.png" style="border:1px solid black">

To make the review process more restrictive, the branch protection rule review requirement can be made more restrictive by designating a code owner review requirement.

<img src="../images-branch/codeowner-file.png" style="border:1px solid black">

The code owner is designated in a file called `CODEOWNERS` that can be placed in the root directory of the repository or several other places. File ownership can be designated by name or by pattern matching. In the example above, user `baskaufs` (who is not the repository owner), has been designated as the owner of all files in the repository (using the `*` wildcard). See [this page](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners) for more details on setting up a CODEOWNERS file.

<img src="../images-branch/code-owner-review-required.png" style="border:1px solid black">

When code owner reviews are required, pull requests are flagged as requiring code owner review. The code owner is automatically selected as the reviewer. However, administrators can bypass the code owner review requirement (other users cannot).

[return to collaborative project management on GitHub](../../../script/codegraf/042/)

----
Revised 2022-02-10
