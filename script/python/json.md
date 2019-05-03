---
permalink: /script/python/json/
title: Dictionaries and JSON 
breadcrumb: JSON
---
Note: this is the fifth lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[previous lesson on lists and loops](../structures/)

# Dictionaries

In the previous lesson, we learned about one important Python data structure: lists.  In this lesson, we will begin by looking at a second important data structure: dictionaries.

A *dictionary* is a structure that is essentially a list of key:value pairs.  Dictionaries are enclosed by curly braces.  Here's an example:

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

# JSON

Currently, *Javascript Object Notation* (JSON) is one of the most popular was to transmit data between applications.  Most *application programming interfaces* (APIs) that are available online provide data in the form of JSON -- sometimes exclusively.  

## JSON background

Here are some basics about JSON.

A basic unit of JSON is a *key:value pair*.  for example:

```
"name":"Steve"
"fingers":10
```

The key (technically called a "name" in JSON) must be a string in double quotes.  The value can be a string (in double quotes), a number (not in double quotes), or other things.  In JSON, double quotes must be used to enclose quotes -- single quotes aren't allowed.

A *JSON object* is an unordered list of key:value pairs, separated by commas and enclosed in curly brackets:

```json
{"name":"Steve", "fingers":10, "street":"Keri Drive"}
```

A *JSON array* is an ordered list of values, separated by commas and enclosed in square brackets.  As in key:value pairs, array values can be strings (in double quotes), numbers (not in double quotes), or other things:

```json
["Steve", "Steven", "Esteban"]
```

The "other things" allowed as values in key:value pairs or arrays can be JSON objects or arrays.  Thus JSON can have complicated nested structures, such as arrays within objects, objects within arrays, arrays within arrays, objects within objexts, or more complicated combinations.  For example:

```json
{"name":["Steve", "Steven", "Esteban"], "fingers":10, "street":"Keri Drive"}
```

In this example, nesting an array as a value with a JSON object shows that the name key can have the multiple values within the array.  

Whitespace is not important in JSON.  The following three JSON structures are exactly the same:

```json
{"name":["Steve","Steven","Esteban"], "fingers":10, "street":"Keri Drive"}
```
```json
{"name":["Steve","Steven","Esteban"],
 "fingers":10, 
 "street":"Keri Drive"}
```
```json
{
  "name":
         [
         "Steve",
         "Steven",
         "Esteban"
         ],
  "fingers":10, 
  "street":"Keri Drive"
}
```

Whitespace can be used to make the JSON more readable to humans, but consuming software sees the alternatives as the same.

For the details of JSON, see [this page](https://www.json.org/).

## JSON and Python

As you read the previous section, you may have noticed that JSON is very similar to the Python data structures that we have used (with the exception that JSON requires double quotes and Python allows either double or single quotes).  A "JSON object" is very similar to a Python dictionary.  A "JSON array" is very similar to a Python list. In the same way that JSON objects can be nested within arrays or arrays nested within objects, Python dictionaries can be nested within lists or lists nested within dictionaries.  So pretty much any JSON data structure can be translated into a complex Python data object.  

There is a Python library, appropriately called the `json` module, that will convert a JSON string into a Python data object and vice versa.  Here is an example of how it can be used:

```python
import json

jsonString = '''{
  "name":
         [
         "Steve",
         "Steven",
         "Esteban"
         ],
  "fingers":10, 
  "street":"Keri Drive"
}'''

data = json.loads(jsonString)

print(data)
print(data['name'])
print(data['fingers'])
print(data['name'][1])
```

Notes:
- Notice how the triple single-quote was used to create a multi-line string that includes the newlines as part of the string.  Since newlines and spaces are ignored whitespace in JSON, the `.loads()` method has no problem with them and the multi-line string is easier for us to read.
- In the dictionary that results from the `.loads()` method, we can refer to values by the key string.
- Since the value of the `name` key is a list, we have to include an index number in second set of square brackets to refer to the value that we want.

The json module has a `.dumps()` method that works in the reverse direction: it turns a data structure composed of dictionaries and lists into a JSON string that can be saved in a file or used in some other way.

**Try this**

Answers are [at the bottom of the page](#json-answers)

1\. Here is some JSON about acetylsalicylic acid:

```json
{"id": 2157, "formula": "C_{9}H_{8}O_{4}", "molecularWeight": 180.1574, "commonName": "Aspirin"}
```

In Python, we can assign this JSON to a string like this:

```python
string = '{"id": 2157, "formula": "C_{9}H_{8}O_{4}", "molecularWeight": 180.1574, "commonName": "Aspirin"}'
```

Write a script to turn the JSON string into a Python data structure (a dictionary), then print the formula. Don't forget to import the json module.

2\. JSON is returned from a search of the Royal Society of Chemistry API (https://api.rsc.org/).  The results JSON tells us the identifier of compound(s) that meet the requirements of the search.  We want to insert the identifier in the following URL to get data about the compund(s):

`https://api.rsc.org/compounds/v1/records/{id}/details`

where the identifier is substituted in place of `{id}` in the URL. Here's the JSON:

```json
{"results": [2157], "limitedToMaxAllowed": "False"}
```

We can reformat the JSON to make its structure more clear:

```json
{
    "results": [
        2157
        ], 
    "limitedToMaxAllowed": "False"
}
```

We can turn this JSON string into a Python data structure with this code:

```python
import json

jsonString = '''{
    "results": [
        2157
        ], 
    "limitedToMaxAllowed": "False"
}'''

dataStructure = json.loads(jsonString)
print(dataStructure)
```

A. What type of Python object is the value of `dataStructure['results']` ?

B. How can we refer to the number `2157` as a subcomponent of `datastructure`?

C. In this example, what type of Python object is the number `2157` ? 

D. How could we make it be a string and insert it into the URL string?

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

## JSON answers

1\. 

```python
import json
string = '{"id": 2157, "formula": "C_{9}H_{8}O_{4}", "molecularWeight": 180.1574, "commonName": "Aspirin"}'
dataStructure = json.loads(string)
print(dataStructure['formula'])
```

2\. A. You can find out by adding the line:

```python
print(type(dataStructure['results']))
```

You will find that it's a list.  That's because the number is in square brackets - it's a list that has only a single member.

B. `dataStructure['results'][0]` The number is the first (and only) item in the list, so refer to it by the index 0.

C. You can find out by adding the line:

```python
print(type(dataStructure['results'][0]))
```

You will find that it's an int (integer number).  In order to make it a string, you need to use the `str()` function:

```
str(dataStructure['results'][0])
```

Here's an expression for the URL with the results inserted:

```python
url = 'https://api.rsc.org/compounds/v1/records/'+ str(dataStructure['results'][0]) +'/details'
```

## Homework answers

1\

[next lesson on file input and output](../inout/)

----
Revised 2019-05-03
