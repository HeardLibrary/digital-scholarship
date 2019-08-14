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

Typing commands directly in the Console pane is a fine way to experiment and carry out simple tasks.  However, it's not the best way to develop more complex multiline scripts.  RStudio has a built-in editor that can be used to build scripts.  To begin a new script, select **New File** from the **File** menu, then **R Script**.  A fourth pane will appear in the RStudio window, in a tab that defaults to `Untitled1`.  

![](../images/rstudio-editor.png)

As you work in the editor pane, suggestions will pop up as you type.  The following is an example of a two-line script that runs a t-test of means on a simple dataset.  

```
heightsDframe = read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/t-test.csv")
t.test(height ~ grouping, data=heightsDframe,
       var.equal=TRUE,
       conf.level=0.95)
```

Notice that although the script takes up four lines, the last three are considered a single line of code, since the function command doesn't come to an end until the final parenthesis is reached.  Here's what the code looks like when pasted into the RStudio editor:

![](../images/rstudio-script.png)

You can run code that's in the editor pane one line at a time, or all at once.  To run a single line of code, highlight it (or simply place the cursor somewhere on the line).  Then click the **Run** button at the top of the pane.  

![](../images/rstudio-first-line.png)

The first line creates a data structure called a *data frame*.  After clicking on the run button, we see in the console that the first line has run and a summary of it has appeared in the workspace.  The data are two extensive to display in the workspace summary, but if you click on the name of the dataframe in the summary, a new tab will open up in the upper left pane showing the structure of the data in the data frame.  To return to the scipt, click on the **Untitled1** tab.

To run the rest of the script, highlight the second line (or put the cursor on the second line), and click run again.

![](../images/rstudio-results.png)

The command appears in the console window, along with the results of the test.

If you want to run the entire script at once, just highlight the entire script in the editor window and click run.  Each line will be run one at a time in the console window.

----
Revised 2019-08-14
