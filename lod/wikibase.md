---
permalink: /lod/wikibase/
title: Wikibase
breadcrumb: Wikibase
---
**Note:** This tutorial assumes that you have a basic understanding of basic Linked Data, RDF terminology, and SPARQL.  If necessary, review the lessons on [graphs, URIs, and triples](../graphs/), [serilizations and triplestores](../serialization/), and [SPARQL](../sparql/) before proceeding.

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






```turtle
@prefix ns0: <http://wikibase.svc/prop/direct/> .
@prefix ns1: <http://wikibase.svc/prop/> .
@prefix ns2: <http://wikiba.se/ontology#> .
@prefix schema: <http://schema.org/> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix ns3: <http://wikibase.svc/prop/statement/> .

<http://wikibase.svc/entity/Q2>
  ns0:P2 <http://wikibase.svc/entity/Q3> ;
  ns1:P2 <http://wikibase.svc/entity/statement/Q2-0509ef95-4bed-ec8a-3502-75fc735e0722> ;
  ns2:identifiers 0 ;
  schema:version 5 ;
  schema:description "National Broadcast Corporation"@en ;
  rdfs:label "NBC"@en ;
  ns2:statements 0 ;
  ns2:sitelinks 0 ;
  schema:dateModified "2019-02-06T18:26:19Z"^^xsd:dateTime .

<http://wikibase.svc/entity/Q3>
  ns2:identifiers 0 ;
  schema:version 4 ;
  schema:description "The flagship news broadcast of the NBC network"@en ;
  rdfs:label "NBC Nightly News"@en ;
  ns2:statements 0 ;
  ns2:sitelinks 0 ;
  schema:dateModified "2019-02-06T18:25:43Z"^^xsd:dateTime .

<http://wikibase.svc/entity/P2>
  ns2:claim ns1:P2 ;
  ns2:directClaim ns0:P2 ;
  ns2:novalue <http://wikibase.svc/prop/novalue/P2> ;
  ns2:qualifier <http://wikibase.svc/prop/qualifier/P2> ;
  ns2:qualifierValue <http://wikibase.svc/prop/qualifier/value/P2> ;
  ns2:qualifierValueNormalized <http://wikibase.svc/prop/qualifier/value-normalized/P2> ;
  ns2:reference <http://wikibase.svc/prop/reference/P2> ;
  ns2:propertyType ns2:WikibaseItem ;
  ns2:referenceValue <http://wikibase.svc/prop/reference/value/P2> ;
  ns2:referenceValueNormalized <http://wikibase.svc/prop/reference/value-normalized/P2> ;
  ns2:statementProperty <http://wikibase.svc/prop/statement/P2> ;
  ns2:statementValue <http://wikibase.svc/prop/statement/value/P2> ;
  ns2:statementValueNormalized <http://wikibase.svc/prop/statement/value-normalized/P2> ;
  schema:version 2 ;
  schema:description "The value is a news show that is broadcast by the subject network"@en ;
  a ns2:Property ;
  rdfs:label "broadscasts show"@en ;
  ns2:statements 0 ;
  schema:dateModified "2019-02-06T18:24:08Z"^^xsd:dateTime .

ns0:P2 a owl:ObjectProperty .
<http://wikibase.svc/prop/statement/P2> a owl:ObjectProperty .
<http://wikibase.svc/prop/qualifier/value/P2> a owl:ObjectProperty .
<http://wikibase.svc/prop/statement/value/P2> a owl:ObjectProperty .
<http://wikibase.svc/prop/statement/value-normalized/P2> a owl:ObjectProperty .
<http://wikibase.svc/prop/reference/value/P2> a owl:ObjectProperty .
<http://wikibase.svc/prop/reference/value-normalized/P2> a owl:ObjectProperty .
<http://wikibase.svc/prop/qualifier/value-normalized/P2> a owl:ObjectProperty .
<http://wikibase.svc/prop/qualifier/P2> a owl:ObjectProperty .
ns1:P2 a owl:ObjectProperty .
<http://wikibase.svc/prop/reference/P2> a owl:ObjectProperty .
<http://wikibase.svc/prop/novalue/P2>
  a owl:Class ;
  owl:complementOf [
    a owl:Restriction ;
    owl:onProperty ns0:P2 ;
    owl:someValuesFrom owl:Thing
  ] .

<http://wikibase.svc> schema:dateModified "2019-02-06T18:26:18.000Z"^^xsd:dateTime .
<http://wikibase.svc/entity/statement/Q2-0509ef95-4bed-ec8a-3502-75fc735e0722>
  ns3:P2 <http://wikibase.svc/entity/Q3> ;
  ns2:rank ns2:NormalRank ;
  a ns2:BestRank .
```


----
Revised 2019-02-06
