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

## Namespaces

In the material that follows, these namespace abbreviations will be used (defined in the format appropriate for SPARQL prologues):

```sparql
PREFIX wd: <http://wikibase.svc/entity/>
PREFIX wds: <http://wikibase.svc/entity/statement/>
PREFIX wdt: <http://wikibase.svc/prop/direct/>
PREFIX p: <http://wikibase.svc/prop/>
PREFIX pr: <http://wikibase.svc/prop/reference/>
PREFIX ps: <http://wikibase.svc/prop/statement/>
PREFIX wikibase: <http://wikiba.se/ontology#>
PREFIX schema: <http://schema.org/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX prov: <http://www.w3.org/ns/prov#>
```

To run example SPARQL queries from this lesson, you need to first paste in these lines as the prologue of the query.

**Important note: these abbreviations are the standard ones used by Wikidata's query service, <https://query.wikidata.org/>.  However, the domain name for the Wikidata namespace URIs (`http://www.wikidata.org/`) is NOT the same as the default namespace for generic Wikibase installations (`http://wikibase.svc/`).  So if you experiment with running analogous queries on Wikidata, you will need to change the namespace URIs in the prologue of your query to the Wikidata domain name.**  See the [Wikidata Query Service User Manual](https://www.mediawiki.org/wiki/Wikidata_Query_Service/User_Manual) for more details.

## Creating a Wikibase "triple"

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

We can diagram this as we typically do for RDF triples:

<img src="../images/wikidata-simple-triple.png" style="border:1px solid black">

The predicate of this triple is a Wikidata *direct property*, that is, it makes a direct connection between a subject and an object.

## Statement instances

There are several potential problems when we make a statement about something using an RDF triple.  One is that we have no way of easily knowing what the triple signifies ("means") without understanding the data model that underlies the triple.  We also do not have any way to know whether what is being asserted is true.  It could be a product of inadequate information, an outright lie, or about a fictional thing that has no basis in the objective world.  

Another deficiency is that there is no direct way in RDF to make statements about statements, such as when the statement was made, who made it, and the supporting evidence behind the statement.  ([Reification](https://www.w3.org/TR/rdf-primer/#reification) is a possibility, but it comes with its own problems.)

Wikidata gets around these problems by the design of its data model.  Wikidata avoids questions of deep meaning by having only two kinds of entities in its model: *items* and *properties*.  The definition of "item" is simply that it is something of interest - in particular, something that we might potentially want to write a Wikipedia article about.  Items form the subjects and objects in Wikidata (and therefore Wikibase) triples.  In contrast to most of the RDF world, Wikidata does not make `rdf:type` assertions about items. (There is a Wikidata property (P31) for "instance of", but the object of a P31 triple is another item, not an `rdfs:Class`.)  

The problem of making statements about statements is handled by creating a "statement" instance for every assertion that is made using a direct property.  Here is a diagram illustrating the situation with the triple we saw above:

<img src="../images/wikidata-statement-instance.png" style="border:1px solid black">

For every direct property attached to a subject item, there is also a simple *property* that connects the subject to a statement instance.  That statement instance is then connected to the object of the direct property by a *property statement*.  The direct property, simple property, and property statement for a particular property all share the same local name (`P2` in this example), but have different namespaces to differentiate them.  

## References

Because the statement instance is a URI-identified resource, we can now say things about it, such as when it was last modified or what references support it.  Supporting references are a key component built in to the Wikidata model.  Under each statement displayed in the Wikibase GUI, there is an "add reference" link that allows a contributor to add reference information to the database.  The generic Wikibase implementation does not come with any built-in reference properties that can be used to link to reference sources, so they must be created as with any other property (i.e. go to Special Pages and Create a new property).  Here is an example of a refence property that we created in our Wikibase instance to mimic the "reference URL" property that already exists in Wikidata:

<img src="../images/wikidata-statement-instance.png" style="border:1px solid black">

An important feature here is that the Data type of the value for this property is selected as "URL".  That forces the user to enter a URL when providing a value.

Once the reference property has been created, we can use it.  Returning to our "NBC" item, we click on the add reference link and start typing "reference URL" in the property box, then select it from the dropdown list.  Enter the URL in the value box, and click the "save" link to the right of the statement value.  If you don't enter a URL, it will refuse to save the change. Here's what it looks like when we are finished:

<img src="../images/nbc-with-reference.png" style="border:1px solid black">

After we have added the reference, here's a diagram of what the RDF looks like:

<img src="../images/wikidata-statement-reference.png" style="border:1px solid black">

We can see that Wikibase has now created a reference instance that is linked to the statement instance by `prov:wasDerivedFrom`.  Since the reference instance is a URI identified resource, we can say additional things about it.  The most important thing we want to say is how it is related to the statement.  That connection is made by the reference property that we created (`P3`, "reference URL").  The connection is made to the URL that we provided as the value of the reference (`https://www.nbcnews.com/nightly-news`).

There are many other properties associated with the entities, the statement instances, and the reference instances.  For a complete listing, see [this annotated dump](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/wikibase/wikibase-dump.ttl) of the Wikibase dataset after the items and properties discussed above had been created.  At this point, we don't care about most of these details.  However, there is one more bit that we need to know in order to examine what's going on in our Wikibase database.

Because there are two specific kinds of properties (actually more than two, but we'll ignore the others) that are associated with every generic property, Wikidata defines an instance of an entity that's a generic property, then assoicates that generic property with the specific direct (`wdt:` namespace) and simple (`p:` namespace) properties.  The labels and descriptions are linked to the generic property, so that they don't have to be repeated for all of the other flavors of the property.  Here's an example:

```turtle
wd:P2
  a wikibase:Property ;
  wikibase:claim p:P2 ;
  wikibase:directClaim wdt:P2 ;
  schema:description "The value is a news show that is broadcast by the subject network"@en ;
  rdfs:label "broadscasts show"@en .
```

Similarly, reference properties are connected to generic property entities by `wikibase:reference`.  This can be used to find the labels of reference properties.

```turtle
wd:P3
  a wikibase:Property ;
  wikibase:reference <http://wikibase.svc/prop/reference/P3> ;
  schema:description "should be used for Internet URLs as references"@en ;
  rdfs:label "reference URL"@en ;
```

## Using the model to query

If you have created these or similar properties and items, you can retrieve information about them using the Blazegraph SPARQL query interface that is built-in to the Wikibase application.  Make sure that Wikibase is running, then enter `http://localhost:8989/bigdata/` in a browser tab.  In the query text box, paste the namespace abbreviations listed at the top of the page.  You really only need to include the ones that you are going to use, but it doesn't hurt anything to paste them all in.  

Here is a query that asks what properties are associated with the "NBC" item we created:

```sparql
SELECT DISTINCT ?directProp ?label
WHERE {
  wd:Q2 ?directProp ?value.
  ?prop wikibase:directClaim ?directProp.
  ?prop rdfs:label ?label.
  }
  ```

  Notice that in order to differentiate between the direct property that I care about and other flavors of properties, I include the triple pattern:

  ```sparql
    ?prop wikibase:directClaim ?directProp.
  ```

  which only applies to direct properties.  That also serves the purpose of including in my graph pattern a link to the generic property so that I can access the property label.

  Here is a query that returns all of the references associated with a particular kind of statement made about NBC:

  ```sparql
SELECT DISTINCT ?refInstance ?refProp ?label ?value
WHERE {
  wd:Q2 p:P2 ?statementInstance.
  ?statementInstance prov:wasDerivedFrom ?refInstance.
  ?refInstance ?refProp ?value.
  ?refEntity wikibase:reference ?refProp.
  ?refEntity rdfs:label ?label.
  }
  ```

  Note that we had to include the `wikibase:reference` link to the generic property entity in order to get the label.

----
Revised 2019-02-07
