---
permalink: /script/jupyter/
title: Jupyter notebooks
breadcrumb: Jupyter
---

<img src="../images/conda-navigator.png" style="border:1px solid black">

# Jupyter notebooks

Jupyter notebooks are a system that facilitates *literate programming* - a paradigm that documents computer programs by interspersing explanation with executable code.  A Jupyter notebook alternates explanatory text and images with code cells that can be executed indivually or in a sequence.

## Pros and cons

Jupyter notebooks are excellent when code is relatively linear and the code blocks can be executed sequentially.  The result of a code block's execution is shown below the cell, so the user can verify that the script is behaving properly before moving on to the next block.

Jupyter notebooks are less useful when the code involves a lot of functions or looping.  The cells can include function references or loops, but it is not possible for those structures to span multiple cells.  Thus Jupyter notebooks can't easily be used to track what's going on within an executed function or with each iteration of a loop.  In these cases, it's probably better to run the code in an integrated development environment (IDE) that allows for the creation of breakpoints and monitoring of the state of variables as the program runs.

## Installing

There are several ways that you can install and access Jupyter notebooks.  You can perform a stand-alone installation by following the [instructions at the Jupyter website](https://jupyter.org/install.html).  However, it is simpler if you install Jupyter notebooks as part of a larger installation of the [Anaconda distribution](../anaconda/).  Installing via Anaconda also installs Python 3 and R, necessary prerequisites for using the notebooks, as well as most packages you will ever need to use.

If you are at Vanderbilt University, there is also an option to use Jupyter notebooks that are hosted at the ACCRE JupyterHub without installing Jupyter notebooks on your own computer.  Sign in to [Jupyter at ACCRE](https://jupyter.accre.vanderbilt.edu/hub/login) and select Vanderbilt University as the identity provider.

## Running

Regardless of the installation method, you can launch Jupyter notebooks from a console window (Command prompt on Windows or Terminal on Mac).  

<img src="../images/terminal-jupyter-start.png" style="border:1px solid black">

Simply enter `jupyter-notebook` at the prompt.

If you have Anaconda installed, you can launch Jupyter notebooks at a console prompt, or via the Anaconda Navigator.  

<img src="../images/anaconda-jupyter-start.png" style="border:1px solid black">

Click on the `Launch` button under the Jupyter Notebook icon on the navigator screen.  This will open a console window and start Jupyter notebooks just as if you had given the `jupyter-notebook` command in the console.  

<img src="../images/jupyter-tree-screen.png" style="border:1px solid black">

When you launch Jupyter notebooks, two things happen: a local web server will start running on your computer, and your browser will open a new tab showing the Jupyter file tree.  **Important:** closing the browser tab will not shut down the server.  See the `Quitting` section below for how to gracefully shut down the Jupyter server.

If you want to know more about `localhost` web servers, see [this lesson](https://heardlibrary.github.io/digital-scholarship/computer/command-windows/#localhost-web-servers), which illustrates using Jupyter notebooks as an example.   

## Opening a notebook

If you've downloaded a notebook made by someone else, use the Jupyter file tree page to navigate to the place where it was saved.  Often this will default to the Downloads folder.  If your computer has file extensions turned on, you can identify Jupyter notebooks by the file extension `.ipynb`.  (See [this for Mac](https://heardlibrary.github.io/digital-scholarship/computer/files-mac/#unhiding-file-extensions) or [this for Windows](https://heardlibrary.github.io/digital-scholarship/computer/files-windows/#unhiding-file-extensions) for info on unhiding file extensions.)  Clicking on the link for the notebook will open it in another tab.  

If you want to start a new notebook, click on the `New` button, then select the type of notebook you want to start (e.g. Python 3).  

Do not close the Jupyter tree tab on your web browser because you'll need it later to gracefully quit.

## Using Jupyter notebooks

There are many tutorials on the web for using Jupyter notebooks, so we won't repeat that information here.  Here's [one tutorial for beginners](https://www.dataquest.io/blog/jupyter-notebook-tutorial/) and [more detailed documentation](https://jupyter-notebook.readthedocs.io/en/stable/examples/Notebook/Notebook%20Basics.html).  

## Quitting Jupyter notebooks

When you are done with the notebook itself, save it by clicking on the save button (if desired) before closing the notebook's tab in the browser.  

![](../../computer/images-6-mac/jupyter-shutdown.png)

On the Jupyter tree tab, click on the Quit button to shut down the server.  After you get the message saying that the server has stopped, you can close the tab.  You'll also see evidence in the console window that the server has shutdown and the console returns to the normal prompt.  

If you forget to shut down the server before closing the Jupyter tree tab, you can still kill the server from the console window.  With the window selected, hold on the `Ctrl` (or `Control`) key, then press the C key.  Enter `y` in response to the prompt and the shutdown should proceed.  When it's finished and the prompt returns, you can close the console window.  

If you forget to follow this procedure, nothing will probably be "broken" but you may have some data loss if you close things in the middle of editing a notebook.



----
Revised 2019-08-26
