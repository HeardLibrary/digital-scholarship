---
permalink: /script/r/navigate/
title: Navigating RStudio
breadcrumb: Navigate
---

# Navigating around in RStudio


## The R console

It is quite possible to use R without ever using RStudio.  To do so, just open Terminal (on Mac) or Command Prompt (on Windows) and enter

```
r
```

This will launch a text-only interface called the *console* that looks like this:

![](../images/console-r.png)

In the console you can type commands and the result may be shown below what you have typed.  For example, entering

```
2+2
```

will immediately display the answer to that mathematical calculation.  

The second command that was entered:

```
vec <- c(2,4,7)
```

assigns three numbers to an R data structure called a *vector*.  In this case the vector is given the name `vec`.  Assinging the numbers to the vector `vec` does not produce any visible result.  Instead, the vector is stored in a part of the computer's memory called the *workspace*.  To display the contents of `vec`, enter its name.

Data stored in the workspace will persist during the session.  When the session is closed using the `q()` command, the workspace can be saved to the hard drive and will be reloaded the next time R is restarted.

## The RStudio GUI

RStudio is a typical integrated development environment (IDE) in that it provides additional tools to make the process of developing scripts easier.  It has a graphical user interface (GUI) that displays things without necessarily entering lines of commands.  

When RStudio is launched, it looks something like this:

![](../images/rstudio-initial.png)

The GUI is divided into several panes.  On the left there is a pane with two tabs - by default the Console tab is selected.  The console pane behaves exactly like the console as if it were launched in a Terminal or Command Prompt window.  As shown in screenshot above, the same commands as before were typed into the console pane, with the same results.  However, in the upper right pane, under the Environment tab, any data structures stored in the workspace are listed.  We can see that the vector `vec` shows up, along with a summary of its contents.  To clear the workspace, you can click on the little broom icon.

There is a third pane in the lower right that serves additional purposes.  Its Plots tab will show the results of any graphs that are generated.  Its Packages tab provides a graphical interface for installing and loading packages (an alternative to loading them via text commands in the console).

Typing commands directly in the Console window is a fine way to experiment and carry out simple tasks.  However, it's not the best way to develop more complex multiline scripts.  RStudio has a built-in editor that can be used to build scripts.  To begin a new script, select **New File** from the **File** menu, then **R Script**.  A fourth pane will appear in the RStudio window, in a tab that defaults to `Untitled1`.  

![](../images/rstudio-editor.png)

As you work in the editor window, suggestions will pop up as you type.  

----
Revised 2019-08-14
