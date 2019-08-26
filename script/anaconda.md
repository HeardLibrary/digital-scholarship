---
permalink: /script/anaconda/
title: Anaconda
breadcrumb: Anaconda
---

<img src="../images/conda-navigator.png" style="border:1px solid black">

# What is Anaconda?

Anaconda is an umbrella system for data science that includes many of the most important tools used in data science. It is also free.  It includes both the Python and R programming languages, most of the common Python libraries used in science and engineering (including NumPy, SciPy, Matplotlib, and pandas), and many commonly used R packages. Anaconda also includes the popular Jupyter notebook system, RStudio, the Spyder Python development environment, and has its own custom package management system. The Anaconda Navigator provides access to the system through a desktop GUI (shown in the screenshot above).

Technically, there are two different pieces in play.  *Anaconda* itself is a software distribution - it includes a number of pre-configured programs and packages.  *Conda* is a *package manager* that is installed automatically when Anaconda is installed.  Conda is used to install, remove, and update the packages associated with the software that is a part of the Anaconda distribution.  Conda can actually be used as a package management system independently of Anaconda.  [This blog post](https://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/) contains more details.

# Is Anaconda for me?

Using Anaconda is appealing because it allows you to have access to many data science tools with a single install.  However, there are several things to consider before installing Anaconda.

1. **It's big.** Because Anaconda automatically installs a lot of packages, it can get big (can be up to 3 GB).  You might also have problems if your computer is using an outdated operating system.  So Anaconda could be a problem on old computers with limited drive space.  

2. **Potential conflicts.** There could be potential conflicts between the Conda package managing system and other systems you are using.  In particular, if you are using a Mac with Homebrew, you should do some further research before installing Anaconda.  [Here's a place to start.](https://medium.com/@anyuhang/setting-up-python-environment-with-anaconda-and-homebrew-8c4963604df0)

3. **Virtual environments.** The Conda package manager has its own [built-in environment manager](https://conda.io/projects/conda/en/latest/user-guide/concepts/environments.html). (That's why a Mac [Terminal prompt starts including `(base)`](https://askubuntu.com/questions/1026383/why-does-base-appear-in-front-of-my-terminal-prompt) after Anaconda is installed.)  There may be some complications if you need to use Conda-managed packages within your `virtualenv` or `venv` virtual environment.  See [this page](https://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/) for more details.

If you are a newby user with a reasonably new computer, you are probably not going to know or care about any of these things and can probably safely just install Anaconda and get on with your life.  If you are an advanced user and completely understand all of these things, then you will understand the implacations and be able to deal with any problems that may arise.  Things might be complicated if you are an intermediate user and are using the tools mentioned above (e.g. Homebrew or virtual environments), but aren't expert enough to figure out how to fix things if they go wrong.

# Installing Anaconda

If you decide that Anaconda is for you, go to the [Anaconda Installation page](https://docs.anaconda.com/anaconda/install/) and folow the links for your operating system.

To start using Anaconda, go to the Anaconda Navigator.  It will show up in your Windows Start menu or Launchpad on Mac.  Not every application included in Anaconda will be pre-installed, so the first time you want to use one of the applications in the Anaconda Navigator, you may need to click the `Install` button.  After the first time, the button will change to `Launch`.  The [Getting started page](https://docs.anaconda.com/anaconda/user-guide/getting-started/) has more details.

----
Revised 2019-08-26
