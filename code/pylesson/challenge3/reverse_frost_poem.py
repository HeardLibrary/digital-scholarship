def reverseWords(sentence):
    printOutString = ''
    words = sentence.split()
    # step through each of the words in the sentence backwards
    for reversedWordIndex in range(len(words)-1, -1, -1):
        # concatenate each of the reversed words in the sentence
        printOutString += words[reversedWordIndex] + ' ' # put a space between words
    printOutString += '\n' #put a newline at the end of the sentence
    return printOutString

def reversedSentences(stanza):
    reversedSentences = ''
    sentences = stanza.split('\n')
    # step through each of the sentences backwards
    for reversedSentenceIndex in range(len(sentences)-1, -1, -1):
        # concatenate each of the reversed sentences in the stanza
        reversedSentences += reverseWords(sentences[reversedSentenceIndex])
    reversedSentences += '\n' #put an extra newline at the end of the stanza
    return reversedSentences

frostText = 'Whose woods these are I think I know.\nHis house is in the village though;\nHe will not see me stopping here\nTo watch his woods fill up with snow.\n\n'
frostText = frostText + 'My little horse must think it queer\nTo stop without a farmhouse near\nBetween the woods and frozen lake\nThe darkest evening of the year.\n\n'
frostText = frostText + 'He gives his harness bells a shake\nTo ask if there is some mistake.\nThe only other sound’s the sweep\nOf easy wind and downy flake.\n\n'
frostText = frostText + 'The woods are lovely, dark and deep,\nBut I have promises to keep,\nAnd miles to go before I sleep,\nAnd miles to go before I sleep.'

# reverse the stanzas in the poem
reversedStanzas = ''
stanzas = frostText.split('\n\n')
# step through all of the stanzas backwards
for reversedStanzaIndex in range(len(stanzas)-1, -1, -1):
    # concatenate each of the reversed sentences in the stanza
    reversedStanzas += reversedSentences(stanzas[reversedStanzaIndex])
print(reversedStanzas)
