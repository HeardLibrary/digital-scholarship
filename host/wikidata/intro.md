---
permalink: /host/wikidata/intro/
title: Intro to Wikidata
breadcrumb: Intro
---

# Wikidata Links

Wikidata home page <https://www.wikidata.org/>

Wikidata Query Service <https://query.wikidata.org/>

Scholia <https://tools.wmflabs.org/scholia/>

# Examples

[Vanderbilt University (Q29052))](https://www.wikidata.org/wiki/Q29052)

[Antonis Rokas (Q42352198))](https://www.wikidata.org/wiki/Q42352198)

[gallwasp article(Q43639131)](https://www.wikidata.org/wiki/Q43639131)

## Query example

Paste this into the box at the [query service](https://query.wikidata.org/):

```
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?personLabel ?articleLabel WHERE {
  ?article wdt:P50 ?person.
  ?person wdt:P108 wd:Q29052.
  
  # find English labels
  ?article rdfs:label ?articleLabel.
  filter(lang(?articleLabel)="en")
  ?person rdfs:label ?personLabel.
  filter(lang(?personLabel)="en")
}
```

## Python code example

Go to the following link, copy the code, paste into your Python editor and run.

[Python code](https://gist.github.com/baskaufs/4483157f07341d7de9005561355c3487)

Enter part of the name of someone at Vanderbilt who might have created something (e.g. an article) and the script will look for that string in the list of names of people who have created.  For each one it finds, it will retrieve what they've created.

## Wikiodata superhero web search

[web page example](https://sparql-upload.s3.us-east-2.amazonaws.com/item-properties.html)

[javascript](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/wikidata/item-properties.js)

## Scholia example for Antonis Rokas

<https://tools.wmflabs.org/scholia/author/Q42352198>

----
Revised 2019-09-09
