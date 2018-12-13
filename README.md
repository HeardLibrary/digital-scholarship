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
│   │   │   └── http_library.py     : API Python module for import or cut/paste
│   │   └── xquery             : XQuery versions
│   │       ├── http_library.xq     : API XQuery code for cut/paste
│   │       └── http_library.xqm    : API XQuery module for import
│   └── csv                    : code for manipulating fielded text files
│   │   ├── README.md          : description of included code
│   │   ├── python             : Python versions
│   │   └── xquery             : XQuery versions
|   └── scrape                 : example code for scraping a website
│       ├── README.md          : description of included code
│       └── python             : Python versions
│           ├── scrape-sec.py       : code to perform the scrape, including loops
│           └── scrape-sec.ipynb    : Jupyter notebook of code for only a single instance of each resource
more stuff will go here
```
