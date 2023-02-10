---
permalink: /lod/wikibase/properties/
title: Adding properties to a non-Wikimedia wikibase
breadcrumb: properties
---

[back to the wikibase model](../)

# Adding properties to a non-Wikimedia wikibase

One issue with using a custom wikibase is that it not only starts with no items, but also does not initially have any properties. So before any item data can be added, it is necessary to create any properties that will be used to create statements about the new items. In a custom wikibase, this can be done using the graphical interface, but it is tedious and requires many button clicks.

An alternative to creating the properties manually is to create them via the API using the [wbeditentity](https://wbwh-test.wikibase.cloud/w/api.php?action=help&modules=wbeditentity) module, which allows you to create the property and set labels for it in any number of languages in a singal step. The script `VanderPropertyBot` reads data about any number of properties from a CSV spreadsheet and uses the MediaWiki API associated with the wikibase to create the properties described in the CSV.

Before you can use this script, you need to have a credentials for the wikibase in which you want to make the deletions. For more information about this, see the section on [setting up a bot password](../load/#set-up-a-bot-password) in the page about loading data into a wikibase.

## About datatypes

Each property is restricted to a specific types of value that can be used with it to create a statement. The possible property types can be seen in the dropdown list in the editing screen when a new property is created using the graphical interface. These same datatypes also have a controlled value string that must be passed to the API when it is used to create a property. 

| label in dropdown | controlled value string | controlled value in a VanderBot mapping configuration file<sup>*</sup> |
| ------------------| ----------------------- |
| String | string | string |
| Monolingual text | monolingualtext | monolingualtext |
| Quantity | quantity | quantity |
| Point in time | time | date |
| Geographic coordinates | globe-coordinate | globecoordinate |
| Item | wikibase-item | item |
| URL | url | uri |
| External identifier | external-id | |
| Mathematical expression | math | |
| Tabular data | tabular-data | |
| Commons media file | commonsMedia | <sup>**</sup> |
| Geographic shape | geo-shape | |
| Musical notation | musical-notation | |

<sup>*</sup> Types with no value in this column are not currently supported by VanderBot.
<sup>**</sup> Supported by VanderBot, but under special conditions. See the [VanderBot documentation](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/README.md#the-wikidata-image-property-p18-and-image-file-identification) for more information.



[back to the wikibase model](../)

[deleting statements and references](../delete/)

[loading data into a wikibase](../load/)

[querying a wikibase with SPARQL](../sparql/)

----
Revised 2023-02-10

