---
permalink: /script/python/json/
title: Dictionaries and JSON 
breadcrumb: JSON
---
Note: this is the fifth lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[previous lesson on lists and loops](../structures/)

# Dictionaries

A dictionary is a structure that is essentially a list of key:value pairs.  Dictionaries are enclosed by curly braces.  Here's an example:

```python
company = {'Mickey Mouse':'Disney', 'Donald Duck':'Disney', 'Daffy Duck':'Warner Brothers', 'Fred Flintstone':'Hanna Barbera'}
```

In a dictionary, we refer to items by their key, rather than their index number based on their position in the sequence.  So the order of key:value pairs in a dictionary is unimportant.  Here's how we refer to the value where the key is 'Daffy Duck': `company['Daffy Duck']`

Here's an example of how we could use a dictionary:

```python
company = {'Mickey Mouse':'Disney', 'Donald Duck':'Disney', 'Daffy Duck':'Warner Brothers', 'Fred Flintstone':'Hanna Barbera'}
characterName = input("What's the character's name? ")
print('That character works for ' + company[characterName])
```

This works pretty well, as long as we type in one of the keys that's included in the dictionary.  But if we don't, we generate an error.  A solution is to include an error trap.  Here's how we can do that:

```python
company = {'Mickey Mouse':'Disney', 'Donald Duck':'Disney', 'Daffy Duck':'Warner Brothers', 'Fred Flintstone':'Hanna Barbera'}
characterName = input("What's the character's name? ")
try:
    print('That character works for ' + company[characterName])
except:
    print("I don't know who that character works for.")
print("That's all folks!")
```

Note: an error is known as an *exception*, so that's why the keyword for the block after `try` is `except`.

**Try this**

Answers are [at the bottom of the page](#dictionary-answers)

Here are data on prices of items with the catalog number as the key.

```python
itemList = ['s049', 'm486', 'z010', 'x428']
itemName = {'s049': 'widget', 'm486': 'poiuyt', 'z010': 'thingamabob', 'x428': 'foobar'}
itemPrice = {'s049': 1.98, 'm486': 14.99, 'z010': 0.49, 'x428': 250.00}
```
A. Using the dictionaries, print the name and price of a thingamabob.

B. Use a `for` loop to iterate through the list of items.  For each item, print its name and price.

C. Let the user enter the name of an item.  Iterate through the list of items and check each one to see if it matches the name entered by the user.  If so, print the price.

D. Set a flag named `matched` equal to `False` before the loop.  If there is a match, set the value of `matched` equal to `True`.  If at the end of the loop there was no match, print a message saying so.

## Lists of dictionaries

Just as we could make lists of lists, we can make lists of dictionaries.  This could be useful if we want to keep track of more than two things that are linked.  In the previous example, we just wanted to link the character to the company.  But we might want to keep track of more than that. 

In the list of dictionaries, we refer first to the index number of the dictionary in square brackets, then the key of the dictionary item (the list is the outer structure and the dictionary is the inner structure).  Can you understand how this works?

```python
characters = [{'name':'Mickey Mouse', 'company':'Disney', 'gender': 'male'}, {'name':'Daisy Duck', 'company':'Disney', 'gender': 'female'}, {'name':'Daffy Duck', 'company':'Warner Brothers', 'gender': 'male'},  {'name':'Fred Flintstone', 'company':'Hanna Barbera', 'gender': 'male'}, {'name':'WALL-E', 'company':'Pixar', 'gender': 'neutral'}, {'name':'Fiona', 'company':'DreamWorks', 'gender': 'female'}]
print(characters[1]['company'])
print(characters[0]['name'])
print(characters[4]['gender'])
```

Because the list is iterable, we can iterate through each of the dictionaries.  In the following example, we step through each of the dictionaries (represented by the variable `character`) and check the name of each character to see if it is a match to the name we typed in.

```python
characters = [{'name':'Mickey Mouse', 'company':'Disney', 'gender': 'male'}, {'name':'Daisy Duck', 'company':'Disney', 'gender': 'female'}, {'name':'Daffy Duck', 'company':'Warner Brothers', 'gender': 'male'},  {'name':'Fred Flintstone', 'company':'Hanna Barbera', 'gender': 'male'}, {'name':'WALL-E', 'company':'Pixar', 'gender': 'neutral'}, {'name':'Fiona', 'company':'DreamWorks', 'gender': 'female'}]
characterName = input("What's the character's name? ")
for character in characters:
    if character['name'] == characterName:
        print('The character ' + character['name'] + ' works for ' + character['company'] + '.')
```

This is a bit better than the earlier script, since we don't get an error if there is no matching character. (What happens?)

Here is a more sophisticated script.  Can you figure out how it works?

```python
characters = [{'name':'Mickey Mouse', 'company':'Disney', 'gender': 'male'}, {'name':'Daisy Duck', 'company':'Disney', 'gender': 'female'}, {'name':'Daffy Duck', 'company':'Warner Brothers', 'gender': 'male'},  {'name':'Fred Flintstone', 'company':'Hanna Barbera', 'gender': 'male'}, {'name':'WALL-E', 'company':'Pixar', 'gender': 'neutral'}, {'name':'Fiona', 'company':'DreamWorks', 'gender': 'female'}]
characterName = input("What's the character's name? ")
found = False
for character in characters:
    if character['name'] == characterName:
        found = True
        if character['gender'] == 'male':
            answer = 'He works'
        elif character['gender'] == 'female':
            answer = 'She works'
        else:
            answer = 'They work'
        answer = answer + ' for ' + character['company'] + '.'
        print(answer)
if not(found):
    print("I don't know that character.")
```
Notice how we need to pay careful attention to indentation levels when code gets complicated with loops and nested `if` statements.  How did we solve the problem of the case where no character matches?

# Homework

The answers are [at the end](#homework-answers)


# Challenge problems


## Dictionary answers

A.

```python
itemName = {'s049': 'widget', 'm486': 'poiuyt', 'z010': 'thingamabob', 'x428': 'foobar'}
itemPrice = {'s049': 1.98, 'm486': 14.99, 'z010': 0.49, 'x428': 250.00}

print(itemName['z010'], itemPrice['z010'])
```

B.

```python
itemList = ['s049', 'm486', 'z010', 'x428']
itemName = {'s049': 'widget', 'm486': 'poiuyt', 'z010': 'thingamabob', 'x428': 'foobar'}
itemPrice = {'s049': 1.98, 'm486': 14.99, 'z010': 0.49, 'x428': 250.00}

for item in itemList:
    print(itemName[item], itemPrice[item])
```

C.

```python
itemList = ['s049', 'm486', 'z010', 'x428']
itemName = {'s049': 'widget', 'm486': 'poiuyt', 'z010': 'thingamabob', 'x428': 'foobar'}
itemPrice = {'s049': 1.98, 'm486': 14.99, 'z010': 0.49, 'x428': 250.00}

choice = input('What is the item? ')
for item in itemList:
    if itemName[item]==choice:
        print('It costs ', itemPrice[item])
```

D.

```python
itemList = ['s049', 'm486', 'z010', 'x428']
itemName = {'s049': 'widget', 'm486': 'poiuyt', 'z010': 'thingamabob', 'x428': 'foobar'}
itemPrice = {'s049': 1.98, 'm486': 14.99, 'z010': 0.49, 'x428': 250.00}

choice = input('What is the item? ')
matched = False
for item in itemList:
    if itemName[item] == choice:
        print('It costs ', itemPrice[item])
        matched = True
if not matched:
    print('That item is not in stock')
```

## Homework answers

1\

[next lesson on file input and output](../inout/)

----
Revised 2019-05-03
