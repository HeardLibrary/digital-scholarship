---
permalink: /script/python/object/
title: Object oriented programming in Python
breadcrumb: Object
---

Note: this is the third lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[previous lesson on basics of Python structure](../basics/)

# Object Oriented Programming in Python

In the last lesson, we used the *procedural programming* paradigm to write code.  In this lesson, we will use the *object-oriented programming (OOP)* paradigm.

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
print(secondDuck.company)
print(thirdDuck.company)
print('My name is ' + firstDuck.name + ' Duck. My friend ' + secondDuck.name + ' hates ' + secondDuck.name)
```
Why is the value of `thirdDuck.company` not what we want? Use the printDuck() function to explore.  What does the printDuck() function produce for `genericDuck`?

There is one more common way to specify attribute values when an object is instantiated. In that method, attribute key/value pairs are included inside the parentheses.  The key/value pairs can be listed in any order and often if an attribute is omitted, it's assigned a default value.

**Third Duck creation example (pass attributes as key/value pairs):**

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

print(secondDuck.company)
print(thirdDuck.company)
print('My name is ' + firstDuck.name + ' Duck. My friend ' + secondDuck.name + ' hates ' + secondDuck.nemesis + '!')
```

Why is the result here different from the last example?  Use the printDuck() function to explore the attributes of the ducks.

Python code in the wild will include examples of setting attributes in all three of these ways (directly by assignment, by passing values at instantiation, and by passing key/value pairs at instantiation).

## Methods



----
Revised 2019-01-27
