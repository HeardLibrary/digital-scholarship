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

deck = makeDeck()
for dealtCardCount in range(0, 5):
    dealtCard = random.choice(deck)
    print(dealtCard)
    deck.remove(dealtCard)
print(deck) # make sure that the dealt cards are really gone