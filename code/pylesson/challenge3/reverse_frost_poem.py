frostText = 'Whose woods these are I think I know.\nHis house is in the village though;\nHe will not see me stopping here\nTo watch his woods fill up with snow.\n\n'
frostText = frostText + 'My little horse must think it queer\nTo stop without a farmhouse near\nBetween the woods and frozen lake\nThe darkest evening of the year.\n\n'
frostText = frostText + 'He gives his harness bells a shake\nTo ask if there is some mistake.\nThe only other sound’s the sweep\nOf easy wind and downy flake.\n\n'
frostText = frostText + 'The woods are lovely, dark and deep,\nBut I have promises to keep,\nAnd miles to go before I sleep,\nAnd miles to go before I sleep.'

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