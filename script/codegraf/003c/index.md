---
permalink: /script/codegraf/003c/
title: CodeGraf - Installing Jupyter notebooks with VS Code and GitHub Copilot
breadcrumb: OO3c
---

Previous lesson: [Programming environments](../002)

# Installing Jupyter notebooks with VS Code and GitHub Copilot

[GitHub Copilot](https://github.com/features/copilot) is an artificial intelligence autocompletion code suggestion tool. It is based on an OpenAI system similar to ChatGPT, but trained on code that has been submitted to GitHub. In this lesson, we will install Visual Studio Code (VS Code) and enable GitHub Copilot for use within the VS Code environment. Copilot is free for students and teachers. For others, it has a 30-day trial followed by a paid subscription.

**Learning objectives** At the end of this lesson, the learner will:
- describe the Anaconda distribution.
- install VS Code.
- set up a GitHub account.
- enable the GitHub Copilot plugin.

Total video time: m s

## Links

[Example Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/003/example.ipynb)

[Lesson slides](../slides/lesson003.pdf)

# Introduction

There are various ways to install VS Code and run Jupyter notebooks in its environment. You can find them by searching the web and reading about them. I believe that the method that I describe below is the least complicated, so unless you have one of the problems associated with installing Anaconda, you probably will want to follow these instructions. If you can't use Anaconda, you'll need to use one of the other methods. 

## What is Anaconda? (6m30s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/T19e_Idg2WY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Anaconda is an umbrella system for data science that includes many of the most important tools used in data science. It is also free.  It includes both the Python and R programming languages, most of the common Python libraries used in science and engineering (including NumPy, SciPy, Matplotlib, and pandas), and many commonly used R packages. Anaconda also includes the popular Jupyter notebook system, RStudio, the Spyder Python development environment, and has its own custom package management system. The Anaconda Navigator provides access to the system through a desktop GUI (shown in the screenshot above).

Technically, there are two different pieces in play.  *Anaconda* itself is a software distribution - it includes a number of pre-configured programs and packages.  *Conda* is a *package manager* that is installed automatically when Anaconda is installed.  Conda is used to install, remove, and update the packages associated with the software that is a part of the Anaconda distribution.  Conda can actually be used as a package management system independently of Anaconda.  [This blog post](https://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/) contains more details.

## Is Anaconda for me?

Using Anaconda is appealing because it allows you to have access to many data science tools with a single install.  However, there are several things to consider before installing Anaconda.

1. **It's big.** Because Anaconda automatically installs a lot of packages, it can get big (can be up to 3 GB).  You might also have problems if your computer is using an outdated operating system.  So Anaconda could be a problem on old computers with limited drive space.  

2. **Potential conflicts.** There could be potential conflicts between the Conda package managing system and other systems you are using.  In particular, if you are using a Mac with Homebrew, you should do some further research before installing Anaconda.  [Here's a place to start.](https://medium.com/@anyuhang/setting-up-python-environment-with-anaconda-and-homebrew-8c4963604df0)

3. **Virtual environments.** The Conda package manager has its own [built-in environment manager](https://conda.io/projects/conda/en/latest/user-guide/concepts/environments.html). (That's why a Mac [Terminal prompt starts including `(base)`](https://askubuntu.com/questions/1026383/why-does-base-appear-in-front-of-my-terminal-prompt) after Anaconda is installed.)  There may be some complications if you need to use Conda-managed packages within your `virtualenv` or `venv` virtual environment.  See [this page](https://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/) for more details.

If you are a newby user with a reasonably new computer, you are probably not going to know or care about any of these things and can probably safely just install Anaconda and get on with your life.  If you are an advanced user and completely understand all of these things, then you will understand the implacations and be able to deal with any problems that may arise.  Things might be complicated if you are an intermediate user and are using the tools mentioned above (e.g. Homebrew or virtual environments), but aren't expert enough to figure out how to fix things if they go wrong.

# Setup and installation of Jupyter notebooks in VS Code

## Installing Anaconda and VS Code

If you decide that Anaconda is for you, go to the [Anaconda Installation page](https://docs.anaconda.com/anaconda/install/) and folow the links for your operating system.

To start using Anaconda, go to the Anaconda Navigator.  It will show up in your Windows Start menu or Launchpad on Mac.  Not every application included in Anaconda will be pre-installed, so the first time you want to use one of the applications in the Anaconda Navigator, you may need to click the `Install` button.  After the first time, the button will change to `Launch`.  The [Getting started page](https://docs.anaconda.com/anaconda/user-guide/getting-started/) has more details.

Installing VS Code is fairly straightforward. In the Anaconda Navigator, just find the VS Code panel and click on the `Install` button as described above.

--------
install VS code, had to unzip and drag to applications folder
Skip this. pip3 install jupyter (with Python)

no kernal shows up anywhere by default
installed the Python extension and the Jupyter extension


## Activating an environment in a Jupyter notebook

There are two aspects to running a Jupiter notebook in VS Code. One is manipulating the notebook cells and writing code in them, and the other is getting the notebook to actually run in an environment. In theory, you should activate an Anaconda environment before you run the notebook, but you can get away with just editing the notebook and the first time you try to run a cell, you will be prompted to activate an environment. 

To activate the environment first, open the Command Pallette by pressing the `shift` and `command` then `P` keys on a Mac. On Windows, press `Shift` and `Ctrl` then `P`. From the menu, select `Python: Select Interpreter`. This will bring up a popup from which you can select the installation of Python you want to use. Generally, there will be a Recommended one and it is usually safe to just select that. The main reason this makes a difference is that you may have different packages installed in different environments. For example, if you select the Anaconda installation, it will probably have many of the typical libraries you would want to use already installed. If you pick a generic installation, you may need to install some packages from the command line using PIP. 

no choices from select kernal at first

If you already have a notebook open, you'll see a `Select Kernal` option in the upper right. Clicking on that will bring up the same options that you'll see in the `Python: Select Interpreter` dialog. Similarly, if you run a cell without setting an environment, the selection dialog will pop up at the top of the screen.


----

## Downloading and running a Jupyter notebook from GitHub (1m54s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/FsMZ40jL4uQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Example Jupyter notebook to download from GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/003/example.ipynb)


----

## Workspace Trust

If you work with a new notebook that you've downloaded from somewhere else, you can look at the code but you can't run it without indicating that you trust it. There will be a popup dialog at the top of the screen for you to do this. If this annoys you, you can set a particular folder to be trusted by default. All notebooks run from that folder will be trusted and you won't have to go through the dialog each time.

## Running cells

To run a cell, click on the "play" button at the left of the cell. Any output will appear below the cell. There are buttons at the top of the screen to `Clear All Outputs` and `Restart` (which clears the values of all variables in the environment). These two functions are independent -- clearing the output does not clear the environment and vice versa. 

# Activating GitHub Copilot

The first step in activating GitHub Copilot is to create a GitHub account if you don't already have one. They are free and you can sign up at <https://github.com/>. Sign into your account and make note of the username you chose. Complete your Public Profile and make sure that you give your name exactly like it will appear on your academic ID. Also, complete the Bio section.

NOTE: when you sign up, if you do not use your school email you will need to add it as an additional email and verify it. You can do this under the settings, email. After adding the email, verify using the email that is generated.

## Obtaining free educational access

Once you have the account you need to sign up for free access if you have a school email address. Go to <https://education.github.com/>. 

If you are a student:

1. Under the `Student` menu, select `Student Developer Pack`.
2. Click the `Yes, I'm a student` button. 
3. Select "Student" radio button if it isn't already selected.
4. Select school address. If it is not already there, go to github account settings, email, (click the button on the page) and verify. 
5. How you will use github (fill in)
6. On next page, you need to submit a photo of your student ID.
7. If all goes well and your application processes successfully, you will either get an email within an hour or within 10 days. 

If you are a teacher, follow the instructions on the [Apply to GitHub Global Campus as a teacher](https://docs.github.com/en/education/explore-the-benefits-of-teaching-and-learning-with-github-education/github-global-campus-for-teachers/apply-to-github-global-campus-as-a-teacher) page:

Note that you have to submit a photo of your academic ID. You may have to wait a few days for your application to be processed. 

## Enabling Copilot

Instructions from [this page](https://docs.github.com/en/copilot/getting-started-with-github-copilot)

1. Go to <https://github.com/github-copilot/free_signup>. You should see "Congratulations! You are eligible to use GitHub Copilot for free." Click on the `Get access to GitHub Copilot` button.
2. On the "Select your preferences" page, select "Allow". Chose whether you want to allow GitHub to use your code for training (optional). Click the `Save and get started button`. 

3. In the Visual Studio Code Marketplace, go to the [GitHub Copilot extension page](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) and click Install.
4. A popup will appear, asking to open Visual Studio Code. Click Open Visual Studio Code.
4. When VS Code opens, you will be in a "Extension: GitHub Copilot" tab. There should be an `Install` button. Click it to complete the install. 
5. You should get a prompt to authorize GitHub for VS Code. Click the `Authorize Visual-Studio-Code` button. If you don't see this prompt, close and reopen VS Code. Allow it to open the link. 
6. In the lower right corner you should see the Copilot icon. If not, restart VS Code.


Next Python lesson: [Python programming basics](../004)

----
Revised 2023-09-15
