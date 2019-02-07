---
permalink: /lod/wikibase/
title: Wikibase
breadcrumb: Wikibase
---
**Note:** This tutorial assumes that you have a basic understanding of basic Linked Data, RDF terminology, and SPARQL.  If necessary, review the lessons on [graphs, URIs, and triples](../graphs/), [serilizations and triplestores](../serialization/), and [SPARQL](../sparql/) before proceeding.  If you have not installed Wikibase on your computer and want to, see the lessons on [installing and using Docker](../..//host/docker/) and [Installing Wikibase on your local computer](../install/#using-docker-compose-to-create-an-instance-of-wikibase-on-your-local-computer)

# Wikibase

You may already be familiar with [Wikidata](https://www.wikidata.org/), the database that supports the structured data used in Wikipedia.  Wikibase is the underlying platform on which Wikidata is built.  Anyone can [install Wikibase](../install/#using-docker-compose-to-create-an-instance-of-wikibase-on-your-local-computer) on their own computer or server and essentially build their own personal version of Wikidata.  

# The Wikidata data model

The data model on which Wikidata is based is baked into the Wikibase platform.  So anyone who uses Wikibase to host their own data needs to have a general idea about the Wikidata data model, since that is the data model they will be using.  The [technical details](https://www.mediawiki.org/wiki/Wikibase/DataModel) of the Wikidata model are a bit complex, but there is a [data model primer](https://www.mediawiki.org/wiki/Wikibase/DataModel/Primer) that is more accessible.


## Exploring data associated with a statement

To create items and properties, launch Wikibase and enter `localhost:8181/` in a browser.  From the main page, select the `Special pages` link from the menu on the left.  

<img src="../images/main-page.png" style="border:1px solid black">

Near the bottom of the page click on the `Create a new property` link.  

<img src="../images/new-item.png" style="border:1px solid black">

Enter a label and a description of some property that might link two items, and for Data type, pick `Item`.  Return to the Special pages page and select `Create a new item`.  Start by creating an item that will be the value (object) of your statement by entering the label and description.  Then create another item that will be the subject of your statement.  After the subject item has been created, click on the `add statement` link.  For the propery, begin entering the label for the property that you created, then select it from the drop-down list that pops up.  Then in the box to the right, begin entering the label for the value you created and select it from the drop-down list.  You should now see something like this:

<img src="../images/nbc-page.png" style="border:1px solid black">

In this example, the statement that we've created is, in English: "NBC broadcasts show NBC Nightly News".  In Wikibase URIs, the statement is the single triple:

```turtle
wd:Q2 wdt:P2 wd:Q3.
```

or in unabbreviated terms:

```turtle
<http://wikibase.svc/entity/Q2> <http://wikibase.svc/prop/direct/P2> <http://wikibase.svc/entity/Q3>.
```


----
Revised 2019-02-07
