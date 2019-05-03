---
permalink: /script/python/module/
title: Creating modules and packages
breadcrumb: Modules
---

Note: this is an auxillary lesson in a beginner's introduction to Python.  It's associated with the section on [modules and packages](../basics/#modules-and-packages). For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)


# Creating Your Own Modules and Packages

## Using a function from a home-made module

In the main lesson, we learned that a file containing an importable functions is called a *module*.  The first place Python looks for a module is in the directory in which the main script is located.  So if we want to create our own modules to use with scripts, we need to store the module file in the same directory as our script.

An example of a module is [here](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/functions/simple_math.py).  The four functions in this module aren't really that useful.  When we know how to write more complicated code, we can create more useful modules.  

There are two ways to get this library onto your computer:  

1. Right click on the Raw button and select "Save link as...".  Save the file to the directory you are running Python from (probably your home directory).

2. Click the Raw button. Open a new file in your code editor or IDE.  Copy and paste all of the text from the browser to the code editor.  Save the file as `simple_math.py` in the directory from which you are running Python (probably your home directory).  

To use one of the functions, we have to import the module.  Save the following code in the directory where you saved the simple_math.py file:

```python
import simple_math

num1 = 7
num2 = 2
sum = simple_math.addition(num1, num2)
product = simple_math.multiplication(num1, num2)

print(sum)
print(product)
```

Notes:
1. Notice that when we put the name of the module file in the import statement, we didn't need to add the `.py` extension.
2. When calling the functions, we had to put the name of the module in front of the function name, separated by a dot.

You can also try this version of the program using an abbreviated module name:

```python
import simple_math as m

num1 = 7
num2 = 2
sum = m.addition(num1, num2)
product = m.multiplication(num1, num2)

print(sum)
print(product)
```

<img src="../images/module-structure.png" style="border:1px solid black">

## How are packages related to modules?

In the main lesson, we learned that related modules can be grouped together into *packages* as shown in the diagram above.  

<img src="../images/file-structure.png" style="border:1px solid black">

From the standpoint of file structure, a package is a folder that holds several Python text files (with `.py` file extensions).  You can see an example of the package called `functions` [here](https://github.com/HeardLibrary/digital-scholarship/tree/master/code/pylesson/functions).  The function package contains two modules: the useless `simple_math` module that you used before, and another one called `simple_string` that contains two silly little functions that can be viewed [here](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/functions/simple_string.py).  

If you want to try using this package, you will need to download the `functions` folder to your computer's hard drive.  The easiest way to do that is to go to [this web page](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/functions.zip), click the download button, open the .zip file, and copy the `functions` folder to the folder from which you've been running Python (probably your user folder).  After you've finished the download, it should look something like this:

<img src="../images/package-directory.png">

Notice that there is a third file in the directory called `__init__.py`.  That file actually doesn't have any contents - its presence is simply a signal to Python that the directory is a package.

Now create this script in the directory where you placed the `functions` folder:

```python
import functions.simple_math
import functions.simple_string

answer = functions.simple_math.subtraction(10, 3)
print(answer)

firstName = 'Donald'
lastName = 'Duck'
combinedString = functions.simple_string.concatenation(firstName, lastName)
print(combinedString)
```

The subtraction function subtracts the second argument from the first and the concatenation function joins the two string arguments together.  If you run the script, you should get the following result:

```
7
DonaldDuck
```
<img src="../images/module-structure.png" style="border:1px solid black">

The system of specifying the function by connecting the package, module, and function by dots:

```text
package.module.function()
```

reflects the hierarchy of function within module file and module file within package directory:

```text
package directory
module file
function code
```

[Return to the main lesson](../basics/#keyboard-input)

----
Revised 2019-05-02