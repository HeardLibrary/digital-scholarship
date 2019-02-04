---
permalink: /script/python/inout/
title: Input and output
breadcrumb: Input/Output
---
# Input and Output

# Challenge problems

\1. a. Print five cards

```python
import random

{makeDeck function here}

deck = makeDeck()
for dealtCardCount in range(0, 5):
    dealtCard = random.choice(deck)
    print(dealtCard)
    deck.remove(dealtCard)
print(deck) # make sure that the dealt cards are really gone
```

   b. Deal five cards

```python
import random

{makeDeck function here}

deck = makeDeck()
hand =[]
for dealtCardCount in range(0, 5):
    dealtCard = random.choice(deck)
    hand.append(dealtCard)
    deck.remove(dealtCard)
print(hand)
print(deck) # make sure that the dealt cards are really gone
```

\2. Add up all the numbers to...

```python
enteredString = input("What's the upper number? ")
myNumber = int(enteredString)
sum = 0
for number in range(1, myNumber + 1): # don't forget to add one to the upper range
    sum += number # this does the same thing as
    # sum = sum + number
print(sum)
```

\3.a. Reversing "Stopping by woods..."

```python
{frostText from the example file goes here}

words = frostText.split()
for reversedWordIndex in range(len(words)-1, -1, -1):
    print(words[reversedWordIndex])
```

b. 

```python
{frostText from the example file goes here}

# reverse the stanzas
reversedStanzas = []
stanzas = frostText.split('\n\n')
for reversedStanzaIndex in range(len(stanzas)-1, -1, -1):
    reversedStanzas.append(stanzas[reversedStanzaIndex])
    
# reverse the sentences in the stanzas
newPoem = []
for stanza in reversedStanzas:
    reversedSentences = []
    sentences = stanza.split('\n')
    for reversedSentenceIndex in range(len(sentences)-1, -1, -1):
        reversedSentences.append(sentences[reversedSentenceIndex])
    newPoem.append(reversedSentences)

# reverse the words in the sentences
printOutString = ''  # create a string to append the words
for stanza in newPoem:
    for sentence in stanza:
        words = sentence.split()
        for reversedWordIndex in range(len(words)-1, -1, -1):
            printOutString += words[reversedWordIndex] + ' ' # put a space between words
        printOutString += '\n' #put a newline at the end of each sentence
    printOutString += '\n' #put an extra newline at the end of each stanza
print(printOutString)
```

Revised 2019-02-04
