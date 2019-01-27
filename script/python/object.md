---
permalink: /script/python/object/
title: Object oriented programming in Python
breadcrumb: Object
---

# Object Oriented Programming in Python

In the last lesson, we used the *procedural programming* paradigm to write code.  In this lesson, we will use the *object-oriented programming (OOP)* paradigm.

## Classes and instances

In Python object-oriented programming, in addition to the built-in objects that come with Python, we can create our own user-defined objects.  To accomplish that, we define a *class* of objects.  A class is a generic type of thing.  We can then generate *instances* of that class.  An instance is an individual occurrence of that class.



First Duck creation example (no parameters):

```python
# define Duck class
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

Second Duck creation example (pass attributes as parameters):

```python
# define Duck class
class Duck:
    def __init__(self, n='default name', co='a generic company', enemy='an unknown enemy'):
        # set Duck object attributes with values from parameters
        self.name = n
        self.company = co
        self.nemesis = enemy

# Duck printing function. Takes a single Duck instance as an argument
def printDuck(myDuck):
    print('My name is ' + myDuck.name + ' Duck. I work for ' + myDuck.company + '. My nemesis is ' + myDuck.nemesis +'.')

# instantiate three Duck instances
firstDuck = Duck('Donald', 'Disney', 'Mickey Mouse')
secondDuck = Duck('Daffy', 'Warner Brothers', 'Elmer Fudd')
thirdDuck = Duck('Roger', 'Wile E. Coyote')

# print some stuff about the ducks
print(secondDuck.company)
print(thirdDuck.company)
print('My name is ' + firstDuck.name + ' Duck. My friend ' + secondDuck.name + ' hates ' + secondDuck.neme
```
Why is the thirdDuck.company not what we want? Use the printDuck() function to explore.

Third Duck creation example (pass attributes as key values):

```python
# define Duck class
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

firstDuck = Duck(name='Donald', company='Disney', nemesis='Mickey Mouse')
secondDuck = Duck(name='Daffy', company='Warner Brothers', nemesis='Elmer Fudd')
thirdDuck = Duck(name='Roger', nemesis='Wile E. Coyote')

print(secondDuck.company)
print(thirdDuck.company)
print('My name is ' + firstDuck.name + ' Duck. My friend ' + secondDuck.name + ' hates ' + secondDuck.nemesis + '!')
```

Why is the result here different from the last example?

----
Revised 2019-01-27
