# this program uses an object to return multiple attributes from a function
class Duck():
#    def __init__(self, n='default name', co='a generic company', enemy='an unknown enemy'):
    def __init__(self, **kwargs):
        # instantiate the Duck object with default values
        try:
            self.name = kwargs['name']
        except:
            self.name = 'default name'

        try:
            self.company = kwargs['company']
        except:
            self.company = 'a generic company'

        try:
            self.nemesis = kwargs['nemesis']
        except:
            self.nemesis = 'an unknown enemy'

def printDuck(myDuck):
    print('My name is ' + myDuck.name + ' Duck. I work for ' + myDuck.company + '. My nemesis is ' + myDuck.nemesis +'.')

firstDuck = Duck(name='Donald', company='Disney', nemesis='Mickey Mouse')
secondDuck = Duck(name='Daffy', company='Warner Brothers', nemesis='Elmer Fudd')
thirdDuck = Duck(name='Roger', nemesis='Wile E. Coyote')

print(secondDuck.company)
print(thirdDuck.company)
print('My name is ' + firstDuck.name + ' Duck. My friend ' + secondDuck.name + ' hates ' + secondDuck.nemesis + '!')
