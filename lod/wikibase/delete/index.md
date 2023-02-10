---
permalink: /lod/wikibase/delete/
title: Deleting statements and references from a wikibase
breadcrumb: delete
---

[back to the wikibase model](../)

# Deleting statements and references from a wikibase

Any statement or reference in a wikibase can easily be deleted using the graphical interface. But what if you have several or even hundreds of deletions that you need to make? Perhaps your accidentally used the wrong data source for many statements or the source information for many references has changed its URL. In those sorts of situations, it is impractical to make the deletions manually. 

The MediaWiki API provides two modules for making deletions in wikibases: [wbremoveclaims](https://www.wikidata.org/w/api.php?action=help&modules=wbremoveclaims) for removing statements (also known as "claims") and [wbremovereferences](https://www.wikidata.org/w/api.php?action=help&modules=wbremovereferences) for removing references. In both cases, the identifiers for the information to be deleted must be known. (See [this](../#statement-instances) for more on statement identifiers and [this](../#references) for more on reference identifiers.) 

This information isn't typically known if the statements or references were added using the graphical interface. However, if the [VanderBot](http://vanderbi.lt/vanderbot) script was used to [load data into a wikibase](../load/), those identifiers are captured and saved along in the source data CSV. In this tutorial, we'll see how to use a Python script called [VanderDeleteBot](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/vanderdeletebot.md) to use this saved information to make multiple deletions. 

Before you can use this script, you need to have a credentials for the wikibase in which you want to make the deletions. For more information about this, see the section on [setting up a bot password](../load/#set-up-a-bot-password) in the page about loading data into a wikibase.

![CSV containing uploaded data](images/uploaded_data.png)

## Identifiers

The screenshot above shows part of a CSV that was used to load information about elements into a wikibase. The abbreviation column contains the information that I used to create the `abbreviation` statement visible in the graphical interface:

![GUI interface view of statement and reference](images/identifiers_gui.png)



# Deleting a statement

Let's imagine that [IUPAC](https://iupac.org/) has assigned names and abbreviations to the last six elements in the row and I want to delete the abbreviations so that 

[back to the wikibase model](../)

[loading data into a wikibase](../load/)

[creating properties using a script](../properties/)

[querying a wikibase with SPARQL](../sparql/)

----
Revised 2023-02-10
