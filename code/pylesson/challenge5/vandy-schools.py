import webbrowser # Note: you may need to download this module if your installation doesn't already have it
import json

collegesJsonString = '''[
    {
        "label":"Blair School of Music",
        "wikidataId":"Q4924165"
    },
    {
        "label":"College of Arts & Science",
        "wikidataId":"Q7914451"
    },
    {
        "label":"Divinity School",
        "wikidataId":"Q7914452"
    },
    {
        "label":"Graduate School",
        "wikidataId":"Q7914453"
    },
    {
        "label":"Law School",
        "wikidataId":"Q7914456"
    },
    {
        "label":"Owen Graduate School of Management",
        "wikidataId":"Q14710143"
    },
    {
        "label":"Peabody College of Education & Human Development",
        "wikidataId":"Q7157226"
    },
    {
        "label":"School of Engineering",
        "wikidataId":"Q7914459"
    },
    {
        "label":"School of Medicine",
        "wikidataId":"Q7914466"
    },
    {
        "label":"School of Nursing",
        "wikidataId":"Q7914461"
    },
    {
        "label":"Jean and Alexander Heard Libraries",
        "wikidataId":"Q16849893"
    }
]'''

# turn JSON data into a Python data structure (list of dictionaries)
collegesData = json.loads(collegesJsonString)

# loop through all of the schools and create a numbered list
for schoolNumber in range(0,len(collegesData)):
    print(schoolNumber + 1, collegesData[schoolNumber]['label']) # add one so the list numbering starts with 1
print() # print a blank line after the list

# get the school number from the user
schoolNumberString = input('Enter the number of your school: ')
schoolNumber = int(schoolNumberString) # turn the string they entered into an integer
schoolNumber -= 1 # subtract one from what they entered since Python indices are zero-based

# look up the Wikidata ID for the school and create the URL
wikidataId = collegesData[schoolNumber]['wikidataId']
url = 'https://www.wikidata.org/wiki/' + wikidataId

# open the Wikidata page about the school in a new browser tab
webbrowser.open_new_tab(url)
