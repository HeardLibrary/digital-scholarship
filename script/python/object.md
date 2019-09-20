---
permalink: /script/python/object/
title: Object oriented programming in Python
breadcrumb: Object
---

Note: this is the third lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[previous lesson on basics of Python structure](../basics/)

If you are interested in using Jupyter notebooks, the examples are available in [this notebook](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/object.ipynb).

The presentation for this lesson is [here](presentations/lesson3-object.pdf)

Answers for last week's challenge problems:
1. [GUI Disney Checker](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge1/disney_checker.py)
2. [basic text-based Webpage Checker](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge1/website_checker1.py) / [advanced text-based Webpage Checker](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge1/website_checker2.py) / [advanced GUI Webpage Checker](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge1/website_checker3.py)
3. [text-based Latte Maker](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge1/latte_maker1.py) / [GUI Latte Maker with "Surprise Me!" button](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge1/latte_maker2.py)

# Comments

Comments should be used liberally within your code to help later users (including yourself!) understand what the parts of the code do.  Comments begin with a hash character `#` and all text following that character on the same line is ignored. Here is an example:

```python
count = 15
# the next line increments the counter
count = count + 1
```

You can also place comments following regular commands on the same line:

```python
pi = 3.14159 # this is the first 6 digits of pi
r = 2.0
area = pi*r**2 # double asterisk is the power operator in Python
print(area)
```

Python doesn't really have an official way to "comment out" multiple lines of text, although some programmers use multiline string docstring syntax (triple single-quotes) to achieve this.  For example:

```python
text = prefix + suffix
'''
print(prefix)
print(suffix)
'''
print('The whole text is: ' + text)
```

However, using consecutive single-line comments is favored in the Python style guide (see [here](https://stackoverflow.com/questions/7696924/way-to-create-multiline-comments-in-python) for more details).  Good Python code editors will have a feature to comment out a block of highlighted lines.  In Thonny, see "Comment Out" in the Edit menu.  In VS Code, see "Toggle Line Comment" in the Edit menu.  In Atom, see "Toggle Comments" in the Edit menu.

# Object Oriented Programming in Python

In the last lesson, we used the *procedural programming* paradigm to write code.  In this lesson, we will use the *object-oriented programming (OOP)* paradigm. (For another helpful description of this topic, see [this web page](http://openbookproject.net/thinkcs/python/english3e/classes_and_objects_I.html).)

## Classes and instances

In Python object-oriented programming, in addition to the built-in objects that come with Python, we can create our own user-defined objects.  To accomplish that, we define a *class* of objects.  A class is a generic type of thing.  We can then generate *instances* of that class.  An instance is an individual occurrence of that class.

For example, we can define a class of cartoon ducks, callded `Duck`.  Particular instances of that class would be Donald Duck, Daffy Duck, Scrooge McDuck, Huey, Dewey, Louie, etc.  The process of creating an instance of a class is called *instantiation*.  

It is conventional to use upper camel case (capitalizing the first concatenated word in the object name) for class names, for example `VehiclesWithWheels`.  Names of instances are typically given in lower camel case, for example `myBeatUpChevy`.

In Python, an instance can be assigned to a variable using the `=` operator.  Here is an example:

```python
myBeatUpChevy = VehiclesWithWheels()
```

We could say that we have instantiated the `VehiclesWithWheels` class and assigned the instance to a variable called `myBeatUpChevy`.

## Attributes

One of the advantages of defining our own objects in Python is that we can associate other characteristics with the object.  Those characteristics will "travel" with the object as it flows through different parts of the script.  One characteristic is called an *attribute*.  An attribute is essentially a variable that can be linked to a class.  Particular instances of that class have particular values for that variable.  

The notation used in Python is to link an attribute name to the name of instance it describes using a period (dot).  If the Duck class has attributes `name`, `company`, and `nemesis`, the respective attribute values for the `myDuck` instance of the `Duck` class would be written as `myDuck.name`, `myDuck.company`, and `myDuck.nemesis`.  

Here is a code example that creates an instance of the `Duck` class with default `name`, `company`, and `nemesis` values.  The user is then given an opportunity to change the values of any of these attributes (or press Enter/Return to leave them at their defaults).  The code also defines a function that prints out a description of a particular instance of `Duck`.  Notice that the `Duck` object can be passed as a single unit into the function.  Within the function, the values of the `name`, `company`, and `nemesis` attributes for that particular duck can be known even though they weren't passed into the function as separate variables.

**First Duck creation example (no parameters):**

```python
# define Duck class (don't worry about how this part works)
class Duck:
    def __init__(self):
        # set Duck object attributes with default values
        self.name = "default name"
        self.company = "a generic company"
        self.nemesis = "an unknown enemy"

# Duck printing function. Takes a single Duck instance as an argument
def printDuck(duck):
    print('My name is ' + duck.name + ' Duck. I work for ' + duck.company + '. My nemesis is ' + duck.nemesis +'.')

# instantiate a Duck instance
myDuck = Duck()

print(myDuck.name)
print(myDuck.company)
print(myDuck.nemesis)

# get Duck attributes from user input
name = input("What's the duck's name? ")
if name != '':
    myDuck.name = name

company = input('Who does the duck work for? ')
if company != '':
    myDuck.company = company

nemesis = input("Who is the duck's nemesis? ")
if nemesis != '':
    myDuck.nemesis = nemesis

# print information about the Duck instance
printDuck(myDuck)

```

In the instantiation statement:
```
myDuck = Duck()
```
there is nothing inside the parentheses of `Duck()`. This essentially instantiates a generic duck that has default attributes.  If we want to change the value of the duck's attributes, we have to set each of them manually.

Here is a variation of the previous example.  However, in this code, when we instantiate a duck, we have the option to set its attributes by including arguments within the parentheses of `Duck()`.  

**Second Duck creation example (pass attributes as arguments):**

```python
# define Duck class (don't worry about how this part works)
class Duck:
    def __init__(self, n='default name', co='a generic company', enemy='an unknown enemy'):
        # set Duck object attributes with values from parameters
        self.name = n
        self.company = co
        self.nemesis = enemy

# Duck printing function. Takes a single Duck instance as an argument
def printDuck(myDuck):
    print('My name is ' + myDuck.name + ' Duck. I work for ' + myDuck.company + '. My nemesis is ' + myDuck.nemesis +'.')

# instantiate four Duck instances
firstDuck = Duck('Donald', 'Disney', 'Mickey Mouse')
secondDuck = Duck('Daffy', 'Warner Brothers', 'Elmer Fudd')
thirdDuck = Duck('Roger', 'Wile E. Coyote')
genericDuck = Duck()

# print some stuff about the ducks
print('secondDuck company: ' + secondDuck.company)
print('thirdDuck company: ' + thirdDuck.company)
print('My name is ' + firstDuck.name + ' Duck. My friend ' + secondDuck.name + ' hates ' + secondDuck.nemesis)

```

**Try this**

Why is the value of `thirdDuck.company` not what we want? Delet the `print` statements in lines 20-22. Replace them with 

```python
printDuck(firstDuck)
```

Replace `firstDuck` with the other duck names.  What does the printDuck() function produce for `genericDuck`?

**Third Duck creation example (pass attributes as key/value pairs):**

There is one more common way to specify attribute values when an object is instantiated. In that method, attribute key/value pairs are included inside the parentheses.  The key/value pairs can be listed in any order and often if an attribute is omitted, it's assigned a default value.

```python
# define Duck class (don't worry about how this part works)
class Duck:
    def __init__(self, **kwargs):
        # set Duck object attributes with default values
        try:
            self.name = kwargs['name']
        except:
            self.name = 'default name'

        try:
            self.company = kwargs['company']
        except:
            self.company = 'a generic company'

        try:
            self.nemesis = kwargs['nemesis']
        except:
            self.nemesis = 'an unknown enemy'

# Duck printing function. Takes a single Duck instance as an argument
def printDuck(myDuck):
    print('My name is ' + myDuck.name + ' Duck. I work for ' + myDuck.company + '. My nemesis is ' + myDuck.nemesis +'.')

# instantiate four Duck instances
firstDuck = Duck(name='Donald', company='Disney', nemesis='Mickey Mouse')
secondDuck = Duck(name='Daffy', company='Warner Brothers', nemesis='Elmer Fudd')
thirdDuck = Duck(name='Roger', nemesis='Wile E. Coyote')
genericDuck = Duck()

print('secondDuck company: ' + secondDuck.company)
print('thirdDuck company: ' + thirdDuck.company)
print('My name is ' + firstDuck.name + ' Duck. My friend ' + secondDuck.name + ' hates ' + secondDuck.nemesis + '!')

```

**Try this**

Why is the result here different from the last example?  Use the printDuck() function to explore the attributes of the ducks as you did last time.

Python code in the wild will include examples of setting attributes in all three of these ways (directly by assignment, by passing values at instantiation, and by passing key/value pairs at instantiation).

## Methods

The second important characteristic of a user-defined object is a *method*.  A method is esentially a function that is associated with the class. When a method is evaluated for an instance of the class, the result depends on the state of the instance at the time.

A method associated with an object can return a value.  However, a method can also just *do* something without actually returning anything.  The method often does something to the object itself, such as changing the state of the object.

In Python, the notation for methods is to write the method name following the name of the instance, separated by a period (dot).  In this way, it's similar to the notation used for attributes, except that a method name is always followed by parentheses. For example, if the `VehiclesWithWheels` class has a method `changeOil()`, when the method is applied to the `myBeatUpChevy` instance, we would write it as `myBeatUpChevy.changeOil()`.

The following example defines a `Poem` object, which has the attributes `title`, `text`, and `language` (all strings).  The `text` attribute is a single string for the whole poem and it is divided into lines and stanzas.  The end of each line is indicated by a newline character, expressed in Python as `\n` (a single character, even though it is written as a `\` and a `n`). A newline character is what we might call a "hard return" in other contexts.  The end of each stanza is indicated by two consecutive newline characters (i.e. creating a blank line between the lines of each stanza.)

We have defined four methods for `Poem` objects:

1. The `lines()` method returns the number of lines in the poem.
2. The `words()` method returns the number of words in the poem.
3. The `stanzas()` method returns the number of stanzas in the poem.
4. The `abuse()` method does not return anything.  Instead, it allows you to abuse the text of the poem by replacing any word or phrase in the poem (and its title) with any other word or phrase.  The new text replaces the previous `text` attribute of the poem object.  This method takes two arguments.  The first argument is the string to be replaced and the second argument is the replacement string.

So if the `Poem` instance `majaAngelu27` had 278 words, evaluating

```python
wordCount = majaAngelu27.words()
```

would set the value of wordCount to the integer 278. If we use the `abuse()` method on the `beowulf` instance of the `Poem` class to replace the word "Grendel" with the phrase "my little yellow puppy" in the poem's text, we would write

```python
boewulf.abuse('Grendel','my little yellow puppy')
```

You can paste the following code ([poetry.py](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/poetry.py)) into your favorite editor or IDE to experiment with `Poem` objects.  Don't worry about how the `Poem` class is defined.  The code also includes assignment of the text of Robert Frost's poem "Stopping By Woods on a Snowy Evening" to the variable `frostText`.  You can use it in your experimenting.  The section of code following the instantiation of `stupidPoem` explores the attributes and methods that apply to `Poem` objects.  Run the code as-is and think about how it causes the output that you see.

```python
import copy # import the copy module from the standard library

# define Poem class (don't worry about how this part works)
class Poem():
    def __init__(self):
        # instantiate the poem object with default values
        self.text = "The woods is down;\nthey built a town.\nThis is my text by default.\nSo now I must come to a halt!"
        self.title = "Stopping by town where woods used to be"
        self.language = "en"
    # define the methods
    def lines(self):
        textString = self.text
        noStanzas = textString.replace('\n\n','\n')
        lines = noStanzas.split('\n')
        return lines
    def words(self):
        textString = self.text
        lines = textString.split()
        return lines
    def stanzas(self):
        textString = self.text
        stanzas = textString.split('\n\n')
        return stanzas
    def abuse(self, inWord, outWord):
        textString = self.text
        self.text = textString.replace(inWord, outWord)
        titleString = self.title
        self.title = titleString.replace(inWord, outWord)

# In celebration of "Stopping by Woods on a Snowy Evening" coming out of copyright!!!
frostText = 'Whose woods these are I think I know.\nHis house is in the village though;\nHe will not see me stopping here\nTo watch his woods fill up with snow.\n\n'
frostText = frostText + 'My little horse must think it queer\nTo stop without a farmhouse near\nBetween the woods and frozen lake\nThe darkest evening of the year.\n\n'
frostText = frostText + 'He gives his harness bells a shake\nTo ask if there is some mistake.\nThe only other sound’s the sweep\nOf easy wind and downy flake.\n\n'
frostText = frostText + 'The woods are lovely, dark and deep,\nBut I have promises to keep,\nAnd miles to go before I sleep,\nAnd miles to go before I sleep.'

# instantiate a Poem instance
stupidPoem = Poem()

# play around with the attributes and methods
print()
print(stupidPoem.title)
print()
print(stupidPoem.text)
print()
print('Here are the lines:')
print(stupidPoem.lines())
print('Number of words:')
print(len(stupidPoem.words()))

moreStupidPoem = copy.deepcopy(stupidPoem) # need to use deepcopy function to actually make a copy rather than a reference
moreStupidPoem.title = 'Enjoying the odor of the woods'
moreStupidPoem.abuse('woods', 'swamp')

print()
print(stupidPoem.title)
print(moreStupidPoem.title)
print()
print(moreStupidPoem.text)

```

Note that a method can be applied in the same line as the instantiation.  For example, if we want to change the default text as we create a poem instance, we can say:

```python
modifiedPoem = Poem().abuse('I', 'we')
```

**Technical note:** When you assign a user-defined object to another variable, by default Python simply creates a reference to source object.  In order to force Python to actually make a separate copy of the object, use the `deepcopy()` function from the `copy` module as shown in line 50.  If you want to see why this matters, change line 50 to

```
moreStupidPoem = stupidPoem
```

and try running the program again. 

**Try this**

In line 51, there is an equals sign, but in line 52 there isn't.  What is different about what's going on in those two lines?  Predict what would happen to the title of the poem if lines 51 and 52 were switched?  Predict, then switch them and run the program again.

# Examining the GUI code

For several projects, we've used some template code to generate a graphical interface.  That code forms the first part of the [GUI Latte Maker answer](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge1/latte_maker2.py) to challenge problem 3 from last week.  Let's look at some of the code to see places where objects have been created.  The Tkinter (from "interface toolkit") package is a part of the standard Python library for building GUI interfaces.  In line 12, we see a case of creating an instance of the `Tk` class (a graphical window) with default properties (no arguments listed), and in line 13, the name of the window is set by the `title()` method.

```python
root = Tk()
root.title("Latte maker")
```

In line 14, a `Frame` object was instantiated.  (The `Frame` class definition is in the ttk module of the tkinter package, so it had to be specified in full as `ttk.Frame`.) The containing window (root) was passed as an argument and the padding attribute was set using a key/value pair (passing by argument and key/value pair can be mixed in the same parentheses).

```python
mainframe = ttk.Frame(root, padding="3 3 12 12")
```

There are a bunch of other objects that are instantiated to create all of the Labels, text Entry boxes, and Buttons that are present on the form.  Here is an example of a text input box from line 44:

```python
fourthInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
```

In this example, as the Entry is instantiated, it's containing frame is passed as an argument, the `width` attribute is passed as a key/value pair where the value is an integer, and the `textvariable` attribute is passed as a key/value pair where the value is an instantiated `StringVar` object.

**Try this**

Copy the latte maker code from the Github Raw file and paste it into your editor.  Try running it, then click the X to close the GUI.  In line 33, change the default input box value from `soy` to `skim`.  The marketing department does not like `fat` as the adjective for whole milk.  Change line 79 so that the whole milk adjective is `healthy`.  Also change the text of the surpriseMeButton to something other than `Surprise me!` in line 57.  Try running the program to see how your changes affect the GUI.

# Homework problem

**Abusing Robert Frost** Now that "Stopping by Woods on a Snowy Evening" is in the public domain, we can use it in any creative way we want.  Modify the [poetry.py](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/poetry.py) code to do the following:

   a. Create a `Poem` instance and assign `frostText` to its `text` attribute. 

   b. Assign "Stopping by woods on a snowy evening" to the `title` attribute of your poem.  

   c. Abuse the poem by changing "horse" to "dragon".

   d. Further abuse the poem by changing "woods" to "lava flows".

   e. Print the title and text of the revised poem.

# Challenge problem

Answer in next week's lesson

**Adding scrolled text to the GUI code**

One of the deficiencies of the Latte Maker app (and all of the other programs in which we've used the GUI code) is that it allows input through the GUI, but only prints output to the Python shell console.  It would be nice to have the output right on the app.  

Add a scrolling text object to the bottom of the [GUI Latte Maker answer](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge1/latte_maker2.py) from last week.  

Tkinter has a `ScrolledText` object that can be added to a frame to output text in a scrolling text box.  It's in its own module, so you need to add

```python
import tkinter.scrolledtext as tkst
```

at the top of the code.  To instantiate the scrolling text box, pass attributes shown below. Replace what's inside the curly brackets with appropriate values; width of 50 and height of 10 are a good place to start

```python
tkst.ScrolledText(master = {name of frame variable}, width  = {characters as an integer}, height = {characters as an integer})
```

Here's an example with appropriate replacement values:

```python
scrollingTextBox = tkst.ScrolledText(master = mainframe, width  = 50, height = 10)
```

Use the `grid` method of the `ScrolledText` class to place the scrolling text box in the appropriate position on the grid.  Leave the padx and pady values as they are.  For the Latte Maker, use column 4 and row 17 (the "Surprise me!" button is in row 16).

```python
grid(column={position as an integer}, row={position as an integer}, padx=8, pady=8)
```

The `insert` method of the `ScrolledText` class adds new text to the box.  To put new text at the end, use `END` as the first attribute.

```python
insert(END, {text string to insert})
```

When you create the scrolling text object, use the insert method to insert the initial text: `Order record:\n\n`.  

The final method, `see` needs to be applied after adding text in order to get the text to automatically scroll up so that the text at the end is visible.

```python
see(END)
```

Replace the print statements in lines 103 and 111 with the `insert` and `see` methods applied to your `ScrolledText` object.

[next lesson on data structures in Python](../structures/)

# Homework Answer

Here's a [link](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge2/frost_abuse.py) to all of the code.

```python

# The first part of the script is the same as lines 1-32 in the example

myPoem = Poem()
myPoem.text = frostText
myPoem.title = 'Stopping by woods on a snowy evening'
myPoem.abuse('horse', 'dragon')
myPoem.abuse('woods', 'lava flows')
print(myPoem.title)
print()
print(myPoem.text)
```

----
Revised 2019-09-20
