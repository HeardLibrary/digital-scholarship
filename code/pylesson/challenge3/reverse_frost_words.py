frostText = 'Whose woods these are I think I know.\nHis house is in the village though;\nHe will not see me stopping here\nTo watch his woods fill up with snow.\n\n'
frostText = frostText + 'My little horse must think it queer\nTo stop without a farmhouse near\nBetween the woods and frozen lake\nThe darkest evening of the year.\n\n'
frostText = frostText + 'He gives his harness bells a shake\nTo ask if there is some mistake.\nThe only other sound’s the sweep\nOf easy wind and downy flake.\n\n'
frostText = frostText + 'The woods are lovely, dark and deep,\nBut I have promises to keep,\nAnd miles to go before I sleep,\nAnd miles to go before I sleep.'

words = frostText.split()
for reversedWordIndex in range(len(words)-1, -1, -1):
    print(words[reversedWordIndex])