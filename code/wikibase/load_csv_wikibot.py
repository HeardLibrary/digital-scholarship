#!/usr/bin/env python
# -*- coding: utf-8 -*-
from pywikibot import family
import pywikibot, json, csv, sys

def readDict(filename):
    fileObject = open(filename, 'r', newline='', encoding='utf-8')
    dictObject = csv.DictReader(fileObject)
    dictList = []
    for row in dictObject:
        dictList.append(row)
    fileObject.close()
    return dictList

# *** Script begins here ***

# The list of properties to be assigned must correspond to column headers
# The properties and values (if items) must already have been created
propList = ['P6', 'P9']

# assumes source file is in the same directory as script. Use full or relative path if not.
sourceCsvFile = 'cartoons.csv'
listOfDicts = readDict(sourceCsvFile)

# Log in to the Wikibase instance
site = pywikibot.Site('ldwg', 'ldwg')
site.login()

repo = site.data_repository()

for item in listOfDicts:
    print(item)
    some_labels = {"en": item['enLabel'], "es": item['esLabel']}
    new_item = pywikibot.ItemPage(repo)
    new_item.editLabels(labels=some_labels, summary=u'Setting labels')
    print("created item: " + item['enLabel'])

    some_descriptions = {'en': item['enDescription']}
    new_item.editDescriptions(descriptions=some_descriptions, summary=u'Edit description')
    print("added description: " + item['enDescription'])

    for prop in propList:
        claim = pywikibot.Claim(repo, prop) # instance of
        target = pywikibot.ItemPage(repo, item[prop]) # cartoon character
        claim.setTarget(target)
        new_item.addClaim(claim, summary=u'Adding claim for ' + prop)
        print('added claim for: ' + prop)
        
    print(new_item.getID(), item['enLabel'])
    print()
