# Vanderbilt Heard Library digital scholarship resources

Code and documentation for digital scholarship resources provided by the Vanderbilt Libraries Digital Scholarship and Scholarly Communications Office.

[Go to the Digital Scholarship Resources website](https://heardlibrary.github.io/digital-scholarship/)

## Repo structure

The repository structure is described below. 

```
├── README.md                  : Description of this repository
├── LICENSE                    : CC0 license description
│
├── code                       : reusable code examples
│   ├── api                    : code for interacting with APIs via HTTP
│   │   ├── README.md          : description of included code
│   │   ├── python             : Python versions
│   │   └── xquery             : XQuery versions
│   │       ├── http_library.py     : API Python module for import or cut/paste
│   │       ├── http_library.xq     : API XQuery code for cut/paste
│   │       └── http_library.xqm    : API XQuery module for import
│   ├── file                   : code for manipulating text files
│   │   ├── README.md          : description of included code
│   │   ├── python             : Python versions
│   │   └── xquery             : XQuery versions
│   │       ├── load_file.xq        : file loading XQuery code for cut/paste
│   │       └── load_file.xqm       : file loading XQuery module for import
│   ├── gui                    : code for generating a graphical interface for user interaction
│   │   ├── README.md          : description of included code
│   │   └── python             : Python versions
│   │       └── simple_form.py      : simple script that generates two text boxes and a button
│   ├── scrape                 : example code for scraping a website
│   │   ├── README.md          : description of included code
│   │   └── python             : Python versions
│   │       ├── scrape-sec.py       : code to perform the scrape, including loops
│   │       └── scrape-sec.ipynb    : Jupyter notebook of code for only a single instance of each resource
│   ├── viz                    : data visualization resources
│   ├── wikibase               : interact with Wikibase using Pywikibot, or generic MediaWiki API
│   │   ├── api                : code for interacting with Wikibase using MediaWiki API
│   │   │   ├── write-statements.py : generic Python code for writing to Wikibase using MediaWiki API
│   │   │   ├── load_csv.py         : abbreviated Python code for writing CSV data to Wikibase using API
│   │   │   └── credentials.txt     : credentials necessary for using MediaWiki API
│   │   ├── families           : folder to hold Pywikibot family settings
│   │   └── {various files}    : remaining files in this directory are for using Pywikibot
│   └── wikidata               : preliminary work on setting up a bot
│       ├── item-properties.html     : HTML page template for reading from Wikidata
│       ├── item-properties.js       : Javascript to run HTML page to read from Wikidata
│       ├── rdflib_wikidata.py       : Python script to use rdflib library to process Wikidata data 
│       ├── requests_wikidata_json.py : Python script to retrieve JSON data using SPARQL 
│       └── requests_wikidata_triples.py : Python script to retrieve RDF/Turtle triples using SPARQL
└── data                       : sample data
    ├── rdf                    : Resource Description Framework (RDF) examples
    │   ├── presidents.rdf     : data about presidents retrieved from Wikidata via SPARQL CONSTRUCT
    │   ├── vandy              : sample dataset of people associated with Vanderbilt and their works
    │   │   ├── institution.csv     : source data table about insitutions
    │   │   ├── person.csv          : source data table about people
    │   │   ├── work.csv            : source data table about creative works (publications)
    │   │   ├── graph-model.pdf     : diagram showing the relationships between the classes of institutions, people, and works
    │   │   ├── vandy-graph.png     : graph diagram of instances of institution, people, and works represented in the source tables
    │   │   ├── vandy-triples.csv   : table of 66 triples that describe the graph of institution, people, and works
    │   │   └── vandy.ttl           : Turtle serialization of 66 triples in the graph of institution, people, and works
    │   └── serializations         : RDF serialization examples
    │       ├── example.json   : JSON-LD example
    │       ├── example.nt     : N-Triples example
    │       ├── example.nq     : N-Quads example
    │       ├── example.rdf    : XML example
    │       └── example.ttl    : Terse RDF Triple Language (Turtle) example
    │
    ├── gis                    : Geographic Information Systems example data
    │   └── wg                 : GIS working group examples
    │       ├── Metro_Nashville_Schools.csv        : spreadsheet of data about Nashville schools
    │       └── qgis-example.zip    : 
    │
    └── xml                    : Extensible Markup Language (XML) examples
        ├── menu-example-errors.xml    : generic XML example with errors
        ├── menu-example-corrected.xml : generic XML example (corrected)
        └── tei                : Text Encoding Initiative (TEI) examples
            ├── dickinson-tei-example.xml         : brief example of Dickinson text
            └── dickinson-variants-tei-example.xml : example with text variants
```
