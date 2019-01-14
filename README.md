# Vanderbilt Heard Library digital scholarship resources

Code and documentation for digital scholarship resources provided by the Vanderbilt Libraries Digital Scholarship and Scholarly Communications Office.

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
│   │   │   └── http_library.py     : API Python module for import or cut/paste
│   │       ├── http_library.xq     : API XQuery code for cut/paste
│   │       └── http_library.xqm    : API XQuery module for import
│   ├── csv                    : code for manipulating fielded text files
│   │   ├── README.md          : description of included code
│   │   ├── python             : Python versions
│   │   └── xquery             : XQuery versions
|   └── scrape                 : example code for scraping a website
│       ├── README.md          : description of included code
│       └── python             : Python versions
│           ├── scrape-sec.py       : code to perform the scrape, including loops
│           └── scrape-sec.ipynb    : Jupyter notebook of code for only a single instance of each resource
└── data                       : sample data
    └── rdf                    : Resource Description Framework (RDF) examples
        └── vandy              : sample dataset of people associated with Vanderbilt and their works
            ├── institution.csv     : source data table about insitutions
            ├── person.csv          : source data table about people
            ├── work.csv            : source data table about creative works (publications)
            ├── graph-model.pdf     : diagram showing the relationships between the classes of institutions, people, and works
            ├── vandy-graph.png     : graph diagram of instances of institution, people, and works represented in the source tables
            ├── vandy-triples.csv   : table of 66 triples that describe the graph of institution, people, and works
            └── vandy.ttl           : Turtle serialization of 66 triples in the graph of institution, people, and works
```
