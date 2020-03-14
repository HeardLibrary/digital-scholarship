---
permalink: /script/python/basics/
title: Basics of Python structure
breadcrumb: Basics
---

Note: this is the second lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python lessons homepage](../wg/)

**General note:** 

The examples in this lesson can be run in a Google Colaboratory notebook. A Google account is required. Click on [this link](https://colab.research.google.com/drive/1HfJiFQCn0uFBSMLNXUxx63-2HzqOHel4), then from the file menu select `Save a copy in Drive...`. That will create a copy of the notebook that you can run, edit, and save.

You can run the examples in the Thonny IDE. Just cut, paste, then click the green run button to quickly test them out.  If you've installed Anaconda, the Spyder IDE can be used in the same way.

If you are interested in using Jupyter notebooks, the examples are available in [this notebook](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/basics.ipynb).

The PowerPoint presentation for this lesson is [here](presentations/lesson2-basics.pdf)

The video of this presentation is in two parts. The first part is embedded immediately below and the second part is inserted in the page at the place where it picks up in the lesson.

<iframe id="kaltura_player" src="https://cdnapisec.kaltura.com/p/1821441/sp/182144100/embedIframeJs/uiconf_id/41615771/partner_id/1821441?iframeembed=true&playerId=kaltura_player&entry_id=1_8036a7dk&flashvars[streamerType]=auto&amp;flashvars[localizationCode]=en&amp;flashvars[leadWithHTML5]=true&amp;flashvars[sideBarContainer.plugin]=true&amp;flashvars[sideBarContainer.position]=left&amp;flashvars[sideBarContainer.clickToClose]=true&amp;flashvars[chapters.plugin]=true&amp;flashvars[chapters.layout]=vertical&amp;flashvars[chapters.thumbnailRotator]=false&amp;flashvars[streamSelector.plugin]=true&amp;flashvars[EmbedPlayer.SpinnerTarget]=videoHolder&amp;flashvars[dualScreen.plugin]=true&amp;flashvars[Kaltura.addCrossoriginToIframe]=true&amp;&wid=1_o6nbezhi" width="800" height="570" allowfullscreen webkitallowfullscreen mozAllowFullScreen allow="autoplay *; fullscreen *; encrypted-media *" sandbox="allow-forms allow-same-origin allow-scripts allow-top-navigation allow-pointer-lock allow-popups allow-modals allow-orientation-lock allow-popups-to-escape-sandbox allow-presentation allow-top-navigation-by-user-activation" frameborder="0" title="Kaltura Player"></iframe>

# Basics of Python Structure

*Warning: Pretty much everything on this page is an oversimplification.  But you can learn the details when you need to know them.*

Note: in these instructions a *folder* means the same thing as a *directory*. 

## Objects

In Python, everything is an *object*.  We won't be providing a techical definition of object here, but we will cover object-oriented aspects of Python in a later lesson.  Examples of objects in Python are variables, functions, modules, and packages.

Python is a strongly typed language, meaning that once an object is defined, it's type can't be changed.  However, Python is quite a bit looser about typing than some other languages, such as languages that require you to explicitly declare the type of the object before you use it.

## Naming conventions

The following conventions are suggestions for naming conventions that are commonly used and "safe".  That doesn't mean that you can construct names in other ways and get away with it, but if you follow these conventions, your code will be easy to read and won't have unexpected behavior.

Your code is less likely to have bugs if it is easy for a human to read it and easily tell what's going on.  For that reason, it is better to have object names that are descriptive of what the object is or does.  For example, a name like `load_participant_data` is better than `x`.

The following **characters** can be considered "safe" for names in Python: upper and lower case Roman letters, numerals, and the underscore (`_`) character. Periods (dots) have special use in Python.  Spaces are bad. Hypens can cause problems in some circumstances, so it's better to avoid them.  As a general practice, it's probably safest to begin object names with letters, since other symbols sometimes have special uses, and in some contexts, object names beginning with numerals might have problems.

For **names** of variables and functions, the [PEP 8 style guide](https://www.python.org/dev/peps/pep-0008/) recommends separating words with underscores.  Examples: `company_report_file_name` and `convert_xml_to_json`.  This style is sometimes called *snake_case*.

camelCase is also frequently used.  In camelCase, descriptive words are concatenated, with the first word beginning with a lower case letter and subsequent words beginning with capital letters.  Examples: `companyReportFileName` and `convertXmlToJson`.  

# String, number, and boolean object types

A *string* is a sequence of characters, such as a word or sentence. 

There are a variety of *number types* in Python.  Two types are *integers* (numbers with no decimal point) and *floating point* numbers (numbers with a decimal point).

A *boolean* is a true or false value.

# Literals

In a *literal*, you state explicitly what the object is.  String literals are written within single or double quotes:

```text
"cat"
'dog'
"My name is Steve."
'!@#$%^&*'
```

To create a literal containing a quote, enclose it in the other kind of quote:

```text
"That's OK!"
`Why is he called "Paco"?'
```

A back slash is used to generate special characters, such as a *newline* ("hard return" character). The character after the backslash has a special meaning and is not included in the string. Example:

```python
'This is the first line of text.\nThis is the second line of text.'
```

Number literals are written without quotes:

```python
3.14159
157
57.25
0.0098
```

Bolean literals are written like this, without quotes:
```python
True
False
```
# Variables

A *variable* is like a box into which you can put objects.  A particular variable can hold a particular type of object, but the object in the variable can change over time.

## Assignment

Values are assigned to variables using an equals sign.  In variable assignment, **an equals sign does not mean that the two things are equal!**  The value on the right is assigned to the variable on the left.  It's helpful to think of the equals sign as an arrow pointing to the left.  Examples:

```python
user_name = "smithjr"
is_door_open = False
number_of_array_elements = 47
eulers_number = 2.7182818
```

In these examples, literals are being assigned to variables.  The contents of a variable can also be assigned to a variable, or an expression can be evalutated and the result placed in a variable.

```python
user_name = last_login_name
sum = number_widgets + 3
too_many = sum > 10
student_count = student_count + 1
```

In the third example above, the variable `too_many` will contain a boolean (True or False) depending on a condition (whether the number in `sum` is greater than 10 or not).

The fourth example above may seem strange, because no number can be equal to itself plus 1.  But the statment actual is saying "take the number that's in `student_count`, add one to it, and put the answer back in `student_count`.

**Try this**

Try re-running the following scripts with different values of `number_widgets`.

```python
number_widgets = 1
sum = number_widgets + 3
print(sum)
```

```python
number_widgets = 1
sum = number_widgets + 3
too_many = sum > 10
print(too_many)
```

Notice that when we tell Python to print a variable, it prints the value that's stored in the variable, not the variable name.

How do the following scripts differ? (Pay attention to the quotes!)

```python
first_number = 325
second_number = 145
together = first_number + second_number
print(together)
print(type(together))
```

```python
first_number = '325'
second_number = '145'
together = first_number + second_number
print(together)
print(type(together))
```

Notice in the last two examples that Python determines the type of a variable by the kind of object you put into it.

# Functions

It is a good idea to break code into small chunks.  If a script is too long or complicated, it's hard to tell how it works.  A *function* is a way to break Python into reusable chuncks.  

A function is like a processing machine.  You put stuff into it and different stuff comes out of it.  Think of a latte-making machine.  It might have three inputs: one for coffee beans, one for milk product, and one for water.  You put those three things in and a latte comes out.  The exact result will depend on what you put in.  Put in decaf beans, fat-free milk, and water and you get a skinny decaf latte.  Put in regular beans, soy milk, and water and you get a vegan regular latte.  Put in regular beans, full cream milk, and no water and you get an error.

The things you put into the function are called *arguments*.  The general format for a Python function is:

```python
function_name(argument1, argument2, ...)
```

There can be zero to many arguments in a function.  The latte function might look like this:

```python
make_latte(beans, milk, water)
```

The output of the function can be assigned to a variable:

```python
my_latte = make_latte(beans, milk, water)
```

## Built-in functions

Python comes with some build-in functions.  Here are some:

```python
max()
len()
```

**Try this**

Try the following script with different values for the numbers:

```python
first_number = 50
second_number = 67
biggest = max(first_number, second_number, 100)
print(biggest)
```

In the following script, try changing the value of `name`:
```python
name = 'Steve'
how_long = len(name)
print('Your name is '+ name + '. It is: ')
print(how_long)
print('characters long.')
```

## Making your own functions

You can make your own function using this pattern:

```python
def function_name(parameter1, parameter2):
    # stuff happens with the parameters in this code block
    return the_result
```

Notes:
1. The inputs to the function are variables called *parameters*.  The parameters are used to do things in the code block.  
2. The parameters and any other variables in the function are *local*.  That means that they can have the same name as objects outside the function without either the variables or the other objects having any effect on each other.
3. In Python, code blocks are defined by consistent indentation.  The standard for Python is an indentation of four spaces.  If you are using a Python IDE or code editor, it should automatically indent four spaces for you (including when you press the tab key).  If you are using another kind of text editor, do NOT insert tab characters.
4. The return statement indicates what the function should output.
5. Don't forget the colon after the final parentheses!

## Home-made function example

```python
def multiplication(first_number, second_number):
    answer = first_number * second_number
    return answer

print(multiplication(3,5))
```

In this example, the function is defined in the first three lines.  (The star (`*`) character is the multiply operator.)  The function is called in the last line of the script.  Usually, functions are defined at the start of the program and other code follows.  Python knows that the print statement is not part of the function because it is not indented.

Using the function is called *calling* the function. Inserting values into the function when it is called is called *passing* values into the function.  

Here is a variation on the previous script:

```python
def multiplication(first_number, second_number):
    answer = first_number * second_number
    return answer

num1 = 3
num2 = 5
answer = multiplication(num1,num2)
print(answer)
```

Notice that in this example, the arguments that are put into the function when it is called (`num1,num2`) have different names than the placeholder parameters used to define the function (`first_number, second_number`).  It would also be fine to use the same names in both places, since the parameter variables are local to the function and what happens to variables outside the function has no effect on their value.  The values that the parameters take when the function is run depends only on the values that are passed into the function as arguments.  

**Try this**

Modify the previous example to multipy three numbers.

# Modules and Packages

## Using a function from a module
We can make use of functions that have previously been created without actually including the function code in the file with our script.  The functions are stored in a separate file, and their code is imported from that file into our script.  The file containing the importable functions is called a *module*.

Here is an example where we use two functions from a module called `simple_math`.  One of the functions we are going to use is called `addition`.  The `addition` function is a fairly useless one where we pass two numbers in as arguments and the function returns their sum.  The other function, `multiplication`, operates similarly.

In order to let Python know that we are getting the function from a different file, we have to give the name of the module in an `import` statement.

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
1. When we put the name of the module file in the import statement, we didn't need to add the `.py` extension.
2. When calling the functions, we had to put the name of the module in front of the function name, separated by a dot.

Writing out a long module name is annoying.  As a shortcut, we can abbreviate it using the `as` clause in the `import` statement.  Here's an example:

```python
import simple_math as m

num1 = 7
num2 = 2
sum = m.addition(num1, num2)
product = m.multiplication(num1, num2)

print(sum)
print(product)
```

## How does Python know where to find modules?

When we use an import statement in our code, the first place Python looks for the module file is in the same directory where the code is located.  However, it would be really annoying to have to always put a module file in the directory where the script lives.  

If a module is called and Python doesn't find it in the same directory as the calling script, it will look in other standard places that have been specified when Python was installed.  Python actually comes with a lot of pre-made modules, called the *standard library*.  You don't have to do anything to get those modules, all you have to do is to retrieve them into your code using an import statement.

Here is a fun example using the standard `random` module:

```python
import random

day_list = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
x = random.choice(day_list)

print(x)
```

The list of names of days of the week is part of a Python data structure called a *list*, but don't worry about that for now.  The *choice* function from the *random* module randomly picks a day from the list.  

Note that you don't have to have any idea how the *random* function works.  All you need to know is the kind of arguments it takes and the kind of output it produces.  That is part of the beauty of Python.

A categorized list of the modules in the standard library is [here](https://docs.python.org/3/library/). Here's another example you can try:

```python
import math as m

number = 113
square_root = m.sqrt(number)
print(square_root)
integer = m.floor(square_root)
print(integer)
```

This example finds the square root of the number, then finds the largest whole number less than the square root.  Notice that in this example, we abbreviated the module name as `m`.  

## What if the module isn't in the standard library?

Python would take up a lot more space on your computer if it included every known module that the Python community has created.  Sometimes you will see an Python script on the web that uses a module that isn't in the standard library.  If you try to run that script, an error will be generated saying that the module can't be found.  In that case, either use your IDE's package manager or PIP at the command line to install the missing module.  Once you've installed it on that particular computer, you won't need to do it again.  Instructions for using PIP are [here](../examples/#retrieving-libraries-that-arent-in-the-standard-library) and for installing packages in the Thonny IDE are [here](../thonny/#installing-a-package-in-thonny).

If you have installed Python by installing Anaconda, Anaconda has already installed many of the typical modules used in the STEM and data science world.

<iframe id="kaltura_player" src="https://cdnapisec.kaltura.com/p/1821441/sp/182144100/embedIframeJs/uiconf_id/41615771/partner_id/1821441?iframeembed=true&playerId=kaltura_player&entry_id=1_ot3ekhik&flashvars[streamerType]=auto&amp;flashvars[localizationCode]=en&amp;flashvars[leadWithHTML5]=true&amp;flashvars[sideBarContainer.plugin]=true&amp;flashvars[sideBarContainer.position]=left&amp;flashvars[sideBarContainer.clickToClose]=true&amp;flashvars[chapters.plugin]=true&amp;flashvars[chapters.layout]=vertical&amp;flashvars[chapters.thumbnailRotator]=false&amp;flashvars[streamSelector.plugin]=true&amp;flashvars[EmbedPlayer.SpinnerTarget]=videoHolder&amp;flashvars[dualScreen.plugin]=true&amp;flashvars[Kaltura.addCrossoriginToIframe]=true&amp;&wid=1_o45fn152" width="800" height="570" allowfullscreen webkitallowfullscreen mozAllowFullScreen allow="autoplay *; fullscreen *; encrypted-media *" sandbox="allow-forms allow-same-origin allow-scripts allow-top-navigation allow-pointer-lock allow-popups allow-modals allow-orientation-lock allow-popups-to-escape-sandbox allow-presentation allow-top-navigation-by-user-activation" frameborder="0" title="Kaltura Player"></iframe>

<img src="../images/module-structure.png" style="border:1px solid black">

## What are packages?

Sometimes related modules are grouped together into *packages*.  In the diagram above, you can see an example of a package called `functions`.  The functions package contains two modules: the useless `simple_math` module that you saw before, and another one called `simple_string` that contains two functions: one that join strings and another that finds their length.  

Here is a script that shows how the functions could be used:

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

The subtraction function subtracts the second argument from the first and the concatenation function joins the two string arguments together.  If you run the script, you would get the following result:

```
7
DonaldDuck
```

The hierarchical system of specifying the function from a package involves separating the package, module, and function by dots:

```text
package.module.function()
```

We can simplify the function names several ways:

```python
from functions import simple_math
import functions.simple_string as st

answer = simple_math.subtraction(10, 3)
print(answer)

first_name = 'Donald'
last_name = 'Duck'
combined_string = st.concatenation(first_name, last_name)
print(combined_string)
```

In line 1, we simply imported the `simple_math` module by specifying that it was in the `function` package.  If we had wanted, we could have shortened the module name using an `as` clause.  In line 2, we directly specified the module by giving its "path" expressed using the dot notation.  

In code examples, you will see all kinds of variations on these themes.  Just remember that functions live within modules, and modules live within packages.

**Making your own modules and packages**

If you are interested in the mechanics of making your own modules and packages, see [this page](../module/).

# Keyboard input

Python has a function that can be used to allow a user to enter text, then assign that text to a string variable.  

```python
name = input("What's your name? ")
print('Hello ' + name + '! How are you?')
```

The type of the variable will be string, so you need to change the type using a function if you intend for it to be something other than a string.

```python
# import the math module  
import math  

integer = int(input("What's the number? "))
print('The square root is:')
print(math.sqrt(integer))
```

# Conditional execution

Sometimes we want particular code to be executed only under certain conditions.  We can do that using an `if` statement.  

## if statement

Here is an example:

```python
name = 'Fred Flintstone'
is_micky = name == 'Mickey Mouse'
print(name)
print(is_micky)

if is_micky:
    print('You are a Disney character')
print('That is all!')
```

Notes:
1. The double equals sign `==` is a comparison operator to test for equality.  When `name == 'Micky Mouse'` is evaluated, the resulting boolean value is assigned to the variable `is_micky`.  Other conditional operators are: `!=` (not equal), `>` (greater than), `<=` (less than or equal to), etc.
2. The `if` statement controls whether the code block following the colon is executed or not (don't forget the colon!).  If the value following the keyword `if` has a value of `True`, then the code block is executed.  If the value is `False`, the code block is not executed. 
3. As with code blocks in functions, the code block here is demarcated by indentation (of the standard four spaces).  In this example, there is only one line in the indented code block, but there could be many.
4. The `print 'That is all!'` statement is not included in the code block, so it will be executed regardless of the condition.

**Try this**

Here's a modification of the previous example that uses the input() function:

```python
name = input('What is the name of the character? ')
is_micky = name == 'Mickey Mouse'
print(name)
print(is_micky)

if is_micky:
    print('You are a Disney character')
print('That is all!')
```

For each of the following, predict what would happen if it were entered in the program. Then try it.
1. `Mickey Mouse`
2. `Minnie Mouse`
3. `Micky Mouse`

We don't have to evaluate the condition separately.  We can evaluate it right in the `if` statement.  Here is a simplification of the code:

```python
name = input('What is the name of the character? ')
print(name)

if name == 'Mickey Mouse':
    print('You are a Disney character')
print('That is all!')
```

It's behavior will be the same except for printing the value of the condition.

## if ... else ...

You can create a structure where one code block is executed if the condition is true and a different block is executed if the condition is false.  Here is an example:

```python
name = input('What is the name of the character? ')
print(name)

if name == 'Mickey Mouse':
    print('You are a Disney character')
    print('You are almost ready to go out of copyright!')
else:
    print('You are not a Disney character')
print('That is all?')
```

Notice that both of the conditional code blocks are indented by the same amount.  That helps make it clear that they are two options.

For each of the following, predict what would happen if the value would be entered, then try it:
1. `Mickey Mouse`
2. `Minnie Mouse`

## if ... elif ... else ...

You can check for multiple conditions by following an initial `if` statement by additional conditions.  If none of the additional conditions are satisfied, the `else` code block will be satisfied.  Here is an example:

```python
name = input('What is the name of the character? ')
print(name)

if name == 'Mickey Mouse':
    print('You are a Disney character')
    print('You are a mouse')
elif name == 'Donald Duck':
    print('You are a Disney character')
    print('You are not a mouse')
elif name == 'Minnie Mouse':
    print('You are a Disney character')
    print('Your boyfriend is getting old')
else:
    print('You are not a Disney character')
print("That's all folks!")
```

# Homework problems

Answers are at [the bottom of the page](#try-this-answers)

1\. Yale University has an awesome website known as "Is it chicken tenders day?".  The website is at <http://www.isitchickentendersday.com/> and you can read about it [here](https://yaledailynews.com/blog/2011/09/08/is-it-chicken-tenders-day-question-answered-in-new-website/).  

Python has a module called `datetime` that includes various functions.  For example, you can get today's date like this:

```python
from datetime import date

now = date.today()
print(now)
```

There is also a *method* that determines the day of the week as a number (0=Monday, 1=Tuesday, etc.).  It's `date.today().weekday()`.  (More about methods next lesson.)

A. Modify the example above to print the day of the week number.

B. If chicken tenders are served in the cafeteria on Thursdays, write a program that will output `yes` if it's chicken tenders day and 'no' for any other day.

2\. Write a function that calculates the area of a circle.  The user should be able to pass the diameter as an argument and the function should return the area.  Use the function in a script where the user is prompted to enter the diameter and the answer is identified as the area.  Here are some things you need to know:

- The function to convert a string to a floating point number is `float()` and it takes a string as its only argument.  You'll need it to convert the string from the input function to a number.  See the [section about the `input()` function](#keyboard-input) for a similar example that converts to an integer (using `int()`) instead of a floating point number. 
- Exponentiation in Python is done using two asterisks.  So 4 squared would be `4**2` and x cubed would be `x**3`.
- If you forget the formula for area of a circle, Google it.  Pay attention to the difference between radius and diameter.  You can use `3.14159` as a value for pi.

3\. Math

A. Have the user input two numbers. Set the value of a variable called `zero` to have a boolean value of `True` if they entered a `0` character for the second number and `False` if they didn't.  The section on [conditional execution](#conditional-execution) has a similar example.

B. Convert the two numbers to a floating point number using the `float()` function.  

C. Calculate the first number multiplied by the second number.

D. Calculate the first number divided by the second number.  Since dividing by zero generates an error, only do this calculation if the value of `zero` is not `True`.  You can do it like this:

```python
if not zero:
    (do something here)
```

The variable `zero` is being used here as a *flag*.  A flag is a way to keep track of the state of something in your script so that you can make a decision based on it at a later time.

# Challenge problems

Answers in next week's lesson.

1. **Disney checker**  The Disney character-testing program is dumb because the user has to re-run the program to check each character.  It would be much better to have a graphical interface where the user enters the name in a text box, then clicks a button to see whether the name is of a Disney character.  Use the code [here](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/gui/python/simple_form.py) to create the graphical interface, then hack the GIU code by inserting the code from the previous example into the `doSomethingButtonClick()` function.  The best way to grab the code from the website is to click the Raw button, then highlight all the text, copy, then paste into your editor.  In the function, instead of printing the value of `firstInputBox.get()`, assign it to the variable name, then use the rest of the example code above as the remainder of the function.  Notice that the `if` code blocks will have to be indented 8 spaces, since the function itself is already indented 4 spaces.  **Embelishments:** Make the labels on the form and button appropriate for your app.  Get rid of the unnecessary second text box.

2. **Webpage checker**  Starting with the code [here](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/api/python/http_request.py), add a condition to check for an HTTP status code of 200.  If the status code is 200 ("OK"), then print a message saying that the web page is working.  If the status code is something else, tell the user that the web page isn't working and print the status code.  **Embelishments:** Check for other common response codes, like 301, 302, 303, 403, and 404.  You can see the meanings of the codes [on Wikipedia](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes).  You can also try to create a GUI version using the code mentioned in problem 1.  Put the URL in the text box and label the button "Check web page".

3. **Latte maker**  Create the latte-making function `makeLatte(beans, milk, extras, water)` described earlier in the exercise.  The function will need to have some complicated `if` statements to check for the kinds of beans, milk, and extras.  You should consider whether you should create additional functions that would be called by the `makeLatte()` function to figure out things about the possible ingredients.  Here are the program parameters:

**Minimum inputs** (you can have more):

| variable | possible string values |
|---|---|
| beans | "decaf", "regular", "dark roast" |
| milk | "whole", "skim", "soy" |
| extras | "none", "pumpkin spice", "vanilla" |
| water | "yes", "no" |

**Required output**:

Print a single string formed by concatenating adjective strings in front of the string "latte".  You can use whatever adjectives you think would work best for marketing, but at a minimum, you should be able to produce "regular non-fat plain latte", "decaf skinny vanilla latte", and "dark fat pumpkin spice latte" (substitute a different adjective for "fat" if you can think of a better euphamism).  If "no" is selected for water, then provide some kind of error message.  

**Embelishments:** Create a GUI version using the code mentioned in problem 1.  You'll have to add extra text boxes.  Create an option for a randomly generated latte using the `random.choice()` function.  Add an extra button to the GUI labeled "Surprise me" that generates the random latte.

[next lesson on object-oriented programming in Python](../object/)

# Homework problems answers

1\. 
```python
from datetime import date

now = date.today().weekday()
if now ==3:
    print('yes')
else:
    print('no')
```

2\.
```python
def area(diameter):
    radius = diameter/2.0
    area = 3.14159 * radius ** 2
    return area

d = float(input('What is the diameter? '))
print('The area of your circle is:')
print(area(d))
```

3\. 
```python
firstString = input('first number: ')
secondString = input('second number: ')
zero = secondString=='0'

firstNumber = float(firstString)
secondNumber = float(secondString)

print(firstNumber*secondNumber)
if not zero:
    print(firstNumber/secondNumber)
```

----
Revised 2020-03-13