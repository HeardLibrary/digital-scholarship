---
permalink: /script/python/inout/
title: Input and output
breadcrumb: Input/Output
---
# Input and Output

# Challenge problems

1. a. Print five cards

```
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

```
deck = makeDeck()
hand =[]
for dealtCardCount in range(0, 5):
    dealtCard = random.choice(deck)
    hand.append(dealtCard)
    deck.remove(dealtCard)
print(hand)
print(deck) # make sure that the dealt cards are really gone
```

----
Revised 2019-02-04
