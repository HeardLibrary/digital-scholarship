---
permalink: /script/wikidata/vanderbot/
title: VanderBot tutorial
breadcrumb: vanderbot
---

# VanderBot tutorial

## Links

[Session prep notes](https://www.wikidata.org/wiki/Wikidata:WikiProject_LD4_Wikidata_Affinity_Group/Wikidata_Working_Hours/2021-May-24_Wikidata_Working_Hour#In_Preparation_for_the_Session)

[First blog post](http://baskauf.blogspot.com/2021/03/writing-your-own-data-to-wikidata-using.html)

# Introduction

<iframe width="1120" height="630" src="https://www.youtube.com/embed/WGlfxXYw6wo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

# test.wikidata.org

[Wikidata test instance (playground)](https://test.wikidata.org/)

-----

## Creating a bot password

<iframe width="1120" height="630" src="https://www.youtube.com/embed/NZP6lB7l8c8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[bot password page](https://www.wikidata.org/wiki/Special:BotPasswords)

-----

## Creating a credentials file

<iframe width="1120" height="630" src="https://www.youtube.com/embed/dHBv5IzBsQU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Use `TextEdit` for Mac or `Notepad` for Windows

Credentials file template:

```
endpointUrl=https://test.wikidata.org
username=User@bot
password=465jli90dslhgoiuhsaoi9s0sj5ki3lo
```
-----

## Creating a mapping schema file

<iframe width="1120" height="630" src="https://www.youtube.com/embed/6AlsPEr1mWs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Mapping schema builder webpage](https://heardlibrary.github.io/digital-scholarship/script/wikidata/wikidata-csv2rdf-metadata.html)

Properties and values to use:

```
P17 country (Item value, used as a statement property)
P87 start date (Point in time value, used as a qualifier property for P17)
Q346 France (Item, used as a value for P17)
Q53079 Mexico (Item, used as a value for P17)
P18 Date of birth (Point in time value, used as a statement property)
P93 reference URL (URL value, used as a reference property)
```

-----

## Creating the data CSV

<iframe width="1120" height="630" src="https://www.youtube.com/embed/ug8ivQkyt4c" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

## Downloading the VanderBot script

<iframe width="1120" height="630" src="https://www.youtube.com/embed/d9OHt5oDU8w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[VanderBot python script (for downloading)](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/vanderbot.py)

-----

## Writing to the test WikiData API

<iframe width="1120" height="630" src="https://www.youtube.com/embed/EyadhJmA_nM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Use `Terminal` on Mac or `Command prompt` on Windows

-----

## Adding statements and references to existing items

<iframe width="1120" height="630" src="https://www.youtube.com/embed/aG-OljIYkbE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

# Writing to Wikidata sandbox items

Test items in the "real" Wikidata:

- [Sandbox page 1](https://www.wikidata.org/wiki/Q4115189)
- [Sandbox page 2](https://www.wikidata.org/wiki/Q13406268)
- [Sandbox page 3](https://www.wikidata.org/wiki/Q15397819)

-----

## Switching to the "real" Wikidata

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Zv9rMzOczv8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

## Setup using a configuration file

<iframe width="1120" height="630" src="https://www.youtube.com/embed/0iJ9z1ea2QU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Practice configuration file for sandbox pages](https://gist.github.com/baskaufs/25a19cbb0edf9fcd16423bf231645939)

[Script to convert simplified configuration file into a schema](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/convert_json_to_metadata_schema.py)

-----

## Adding data to a sandbox item

<iframe width="1120" height="630" src="https://www.youtube.com/embed/ME-gx8UUdzE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-----

## Adding multiple values for a property

<iframe width="1120" height="630" src="https://www.youtube.com/embed/OZnv2dPQR6w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----
Revised 2021-05-24
