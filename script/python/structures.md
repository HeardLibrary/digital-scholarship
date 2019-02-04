---
permalink: /script/python/structures/
title: Using data structures 
breadcrumb: Structures
---
# Using Data Structures

Python includes a variety of data structures.  We will learn about two of the most important: lists and dictionaries

# Lists

A list is a sequence of objects.  The objects may be the same or different, but often are the same.  The order of the list is important and items can be referenced by their position in the list, numbered from zero.  

A list is created by putting the sequence in square brackets, separated by commas.  In the following example, a list is assigned to a variable:

```python
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
```

To reference a particular item, write the variable name followed by square brackets containing the index (position) of the object in the sequence: `basket[2]`.

A *slice* of the list can be referenced using the following notation: `basket[1:4]`.  **Important note: in Python, when ranges are specified, for some reason, the last number in the range is one greater than the actual position in the range.**  So in this example, items 1 through 3 will be included. Since counting in Python is zero based, that means that the slice will contain the second through fourth items.

To determin the count of items in a list, use the `len()` function.  In this example, it would be `len(basket)`, which would have a value of 5.  

Predict what would happen, then run the following code:

```python
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
howMany = len(basket)
print(howMany)
lunch = basket[1:3]
print(lunch)
print(len(lunch))
print(basket[4])
print(basket[0:howMany])
print(basket[0])
print(basket[0:1])
```

What is the difference between the last two things that were printed?

## Manipulating lists

To add an item to a list, use the `.append()` method.  Here is an example:

```python
basket.append('durian')
```

Notice that there is no assignment with this method -- you simply apply it and the list itself is changed. 

A list can also be empty.  You can create an empty list like this:

```python
hungry = []
```

You can then add items to the list using the `.append()` method. 

To change an item in a list, just assign a new value to that item:

```python
basket[1] = 'tangerine'
```

To remove an item from the list using its value, use the `.remove()` method:

```python
basket.remove('banana')
```

You can also delete an item using its index number:

```python
del basket[3]
```

Two lists can be combined using the `+` operator.  Predict what would happen, then run this code:

```python
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
print(basket)
basket[1] = 'tangerine'
print(basket)
basket.remove('banana')
print(basket)
basket.append('durian')
print(basket)
del basket[0]
print(basket)
lunchBag = ['sandwich', 'cookie']
lunch = lunchBag + basket
print(lunch)
```

## Lists of lists

A list can contain any object, including other lists.  In some programming languages, there are two-dimensional structures called *arrays*.  To create an array-like structure in Python, make a list of lists.  Here's an example:

```python
firstRow = [3, 5, 7, 9]
secondRow = [4, 11, -1, 5]
thirdRow = [-99, 0, 45, 0]
data = [firstRow, secondRow, thirdRow]
```

An equivalent way to have created this list of lists would have been:

```python
data = [[3, 5, 7, 9], [4, 11, -1, 5], [-99, 0, 45, 0]]
```

To reference a list of lists, first reference the outer list position, then the inner position.  For example, to refer to the first item in the third list, use `data[2][0]`.

Predict what would happen, then try:

```python
data = [[3, 5, 7, 9], [4, 11, -1, 5], [-99, 0, 45, 0]]
print(data[2][0])
print(len(data))
print(data[1])
print(len(data[1]))
```

# String manipulations

## Escape sequences

Since some characters can't be typed on some keyboards, we can include them in strings by using an *escape sequence*.  In Python, the backslash character `\` is used to escape some characters that follow, i.e. to make them have a different meaning than if the `\` weren't there.  We have seen this before with the *newline* character ("hard return" character) that makes a string go to the next line.  We write it as `\n`.  Although this escape sequence is composed of two letters `\` and `n`, it represents a single character, the "newline" character. 

A few other important escaped characters are:
```
\'  for a single quote
\"  for a double quote
\\  to print the actual backslash character
\t  for a tab character
```

Here are a few examples you can try:

```python
windowsPath = 'Use this path: c:\\users\\baskauf\\data.json'
print(windowsPath)
quote1 = "He said \"What's goin' on!\" to me."
print(quote1)
quote2 = 'He said "What\'s goin\' on!" to me.'
print(quote2)
print()
table = 'col1\tcol2\tcol3\napple\torange\tpear'
print(table)
```

In Python 3, all strings are composed of Unicode characters.  Unicode allows us to print characters outside of the Roman alphabet and typical ASCII characters.  To represent a Unicode character, we can write the escape sequence `\u` (for Unicode), followed by the [four character hexidecimal number for that character](https://en.wikipedia.org/wiki/List_of_Unicode_characters).  For example, two write the character for the Euro symbol, use `\u20ac`.  Here is an example you can try:

```python
statement = "It costs $25.00, but that's \u20ac21.82 !"
print(statement)
nobelPeacePrize = 'Dag Hammarskj\u00f6ld'
print(nobelPeacePrize)
box = '\u250e\u2512\n\u2516\u251a'
print(box)
```

## Slicing and dicing strings

Retrieving parts of strings uses the same notation as lists.  (You can essentially think of a string as a list of characters.)  So to get a particular character:

```python
nobelPeacePrize = 'Dag Hammarskj\u00f6ld'
print(nobelPeacePrize[2])
```

and to get part of a string, use:

```python
nobelPeacePrize = 'Dag Hammarskj\u00f6ld'
print(len(nobelPeacePrize))
print(nobelPeacePrize[12:15])
```

Notice that escaped characters count as a single character even if we write them as an escape sequence using several characters.

## Useful string methods

Try these methods:

```
.split()  split a string into a list based on a separator. Splits by any whitespace if no argument.
.capitalize()  capitalize the first word
.title()  capitalize all words
.upper()  capitalize all letters
.lower()  turn all letters to lower case
.replace()  replace the first argument with the second
```

To do more sophisticated things, you'll need to learn to use regular expressions (beyond the scope of this lesson!).

Examples to try:

```python
play = 'the taming of the shrew'
shakespere = play.title()
wordList = play.split(' ')
shouting = play.upper()
silly = play.replace('shrew', 'Tyrannosaurus rex')
print('We went to see "' + shakespere + '".')
print('The third word in the phrase was "' + wordList[2] + '".')
print("Don't write your email subjects like this: " + shouting)
print('I wrote the modern version of "' + silly + '".')

```

# Iterating using "for"

Python has several ways to control the flow through a script.  We've already seen how `if...else...` can be used to make choices.  Another very common task is to repeat some code multiple times.  For example, suppose we want to do something with every item in a list.  A list is *iterable*, meaning that you can step through the list and operate on each of the items in the sequence.  Here's an example:

```python
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
for fruit in basket:
    print('I ate one ' + fruit)
print("I'm full now!")
```

Each time the script iterates to another item in the list, it repeats the indented code below the `for` statement and the value of the iterator (`fruit` in this case) changes to the next item.  Strings are also iterable:

```python
word = 'supercalifragilisticexpialidocious'
print('Spell it out!')
for letter in word:
    print(letter)
print('That wore me out.')
```

## Ranges

You can generate an iterable range of numbers using `range()`.  The form of the numbers we use in `range()` is similar to the numbering in slices, although we separate them with commas.  The first number is the starting number and the second number is one more than the ending number. An optional third number can specify the step (e.g. 2 would generate every second number).  The step can also be negative.

We can use a `for` statement to iterate through a range.  Here are examples:

```python
for count in range(1,11):
    print(count)
```

```python
print('Prepare to launch!')
for countDown in range(10,0,-1):
    print(countDown)
print('Lift off!')
```

```python
cheer = ''
for skipper in range(2, 10, 2):
    cheer = cheer + str(skipper) + ', '
cheer = cheer + 'who do we appreciate?'
print(cheer)
```

Notice how we need to be careful that our second number goes one step beyond our intended range.  Also notice in the last example that if we wanted to treat the integer that we generated as a string, we needed to convert it to a string using the `str()` function.

Ranges are often used to index list items when we want to iterate through a list, but have access to the index number.  Here is an example:

```python
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
print('Here's a list of the fruit in the basket:")
for fruitNumber in range(0, len(basket)):
    print(str(fruitNumber+1) + ' ' + basket[fruitNumber])
print('You can see that there are ' + str(len(basket)) + ' fruits in the basket.')
```

Notice several things:
1. Because the number of items in the list `len(basket)` (5) is one more than the index of the last item in the list `basket[4]`, the range covers the entire list, since ranges must end one number greater than the range you want.
2. I had to add 1 to the `fruitNumber` as it iterated because Python counts starting from zero and I wanted to start from one.
3. I had to use the `str()` function each time I wanted to concatenate one of the integer numbers to other strings.

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

Questions: How did we solve the problem of the case where no character matches?

# Challenge problems

1. **Dealing cards** Here is some code that generates a deck of cards as a list:

```python
import random

def makeDeck():
    suits = ['hearts', 'spades', 'clubs', 'diamonds']
    deck = []
    
    # generate the deck of cards
    for suit in suits:
        deck.append('A ' + suit)
        for num in range(2,11):
            deck.append(str(num) + ' ' + suit)
        deck.append('J ' + suit)
        deck.append('Q ' + suit)
        deck.append('K ' + suit)
    return(deck)

newDeck = makeDeck()
print(newDeck)
print(random.choice(newDeck)) # select a single card at random and print it
random.shuffle(newDeck) # randomize all of the cards in the deck and replace them in the deck list
print(newDeck)
```

   The code after the makeDeck() function shows how the `choice()` function and the `.shuffle()` method can be used to randomize the cards in the deck.

   a. Use this function to write a script that "deals" a five card poker hand by printing five random cards from the deck.  Note that after each card is printed, it has to be removed from the deck so that when the next card is printed, there isn't any chance that you'll get the same one a second time.

   b. Instead of just printing the five cards, use `.append()` to add them to another list called `hand`.  Print the whole hand list.

2. In a [famous story](http://wbilljohnson.com/journal/math/gauss.htm), the young mathematician Kar Gauss's teacher assigned him the task of adding all of the numbers from 1 to 100, with the intention of keeping him busy for a while.  It didn't work because in a few moments, Gauss calculated the answer, 5050, using some clever thinking.  However, if Gauss were in school now, he could just write a Python script to do the calculation.  Write a script using `range()` to add all the numbers from 1 up to any number that you choose?

3. a. Print the words of "Stopping by Woods on a Snowy Evening" in reverse order.  You can get the poem as a string [here](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/poetry.py). You will need to iterate using an index rather than iterating the words directly. 
   b. Concatenate all of the words with spaces between them.  Can you put line breaks and stansas in what you think are the right places?

----
Revised 2019-02-04
