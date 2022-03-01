# poetry manipulation
class Poem():
    def __init__(self):
        # instantiate the poem object with default values
        self.text = "The woods is down;\nthey built a town.\nThis is my text by default.\nSo now I must come to a halt!"
        self.title = "Stopping by town where woods used to be"
        self.language = "en"
    def lines(self):
        textString = self.text
        noStanzas = textString.replace('\n\n','\n')
        lines = noStanzas.split('\n')
        return lines
    def words(self):
        textString = self.text
        lines = textString.split()
        return lines
    def stanzas(self):
        textString = self.text
        stanzas = textString.split('\n\n')
        return stanzas
    def abuse(self, inWord, outWord):
        textString = self.text
        self.text = textString.replace(inWord, outWord)
        titleString = self.title
        self.title = titleString.replace(inWord, outWord)

# In celebration of "Stopping by Woods on a Snowy Evening" coming out of copyright!!!
frostText = 'Whose woods these are I think I know.\nHis house is in the village though;\nHe will not see me stopping here\nTo watch his woods fill up with snow.\n\n'
frostText = frostText + 'My little horse must think it queer\nTo stop without a farmhouse near\nBetween the woods and frozen lake\nThe darkest evening of the year.\n\n'
frostText = frostText + 'He gives his harness bells a shake\nTo ask if there is some mistake.\nThe only other sound’s the sweep\nOf easy wind and downy flake.\n\n'
frostText = frostText + 'The woods are lovely, dark and deep,\nBut I have promises to keep,\nAnd miles to go before I sleep,\nAnd miles to go before I sleep.'

myPoem = Poem()
print(myPoem.text)
