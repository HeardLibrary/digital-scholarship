---
permalink: /lod/graphs/
title: Graphs, URIs, and triples
breadcrumb: Graphs
---

# Linked Data Basics: Graphs, URIs, and Triples

There are several key concepts that underlie Linked Data.  Fundamentally, Linked Data is a way of modeling data that differs from the more typical table-based database model.  Let's start by looking at graphs, then comparing how the same dataset can be conceptualized under the two models.

![Neo4J graph of habitats](../images/neo4j.png)

# Graphs

In the context of Linked Data, a graph is an abstract mathematical concept, not a graphical visualization of data as the term is commonly used.  A graph is a way of representing how things are connected and is composed of nodes, the entities of interest, and edges, the connections between the nodes.  Sometimes a node is also called a vertex (plural vertices) and an edge is sometimes called an arc.  

The diagram above shows a graphical representation of a graph.  In the graph, the nodes are field sites (shown in pink) and habitat types (shown in blue).  The edges (shown as black arrows) represent relationships between the field sites and habitats.  This is a "directed graph" because the relationship has a direction indicated by the arrowheads (the field sites have habitat types that are habitats, not the other way around). 

## Neo4J

[Neo4J](https://neo4j.com/) is a popular graph database system and was used to make the diagram above.  Neo4J allows you to designate connections between entities and to record data about the properties of those entities.  For example, the field site labeled "78" is in the state of Florida and has the latitude 25.679706 .  

Although Neo4J uses a graph model, it isn't Linked Data because it doesn't have the basic features of defined for Linked Data

## Linked Data

The principles of Linked Data were laid out by Tim Berners-Lee in a [2006 design note](https://www.w3.org/DesignIssues/LinkedData.html).  

1. Use URIs as names for things
2. Use HTTP URIs so that people can look up those names.
3. When someone looks up a URI, provide useful information.
4. Include links to other URIs. so that they can discover more things.

The primary difference between the approach taken by Neo4J and Linked Data as laid out by Tim Berners-Lee is the use of uniform resource identifiers (URIs) as a means to "name" or identify things.  This is a critical difference, because URIs are what makes it possible to link resources described by one data provider with resources described by another.  URIs are designed to be globally unique, so when we use them, we know that we won't have a "collision" when someone else uses the same identifier to refer to a different thing than we are referring to.  Neo4J handles graph-based data from a single provider well, but it does not allow for the automatic merging of multiple datasets from different providers - a primary goal of the Linked Data movement.

An 2010 add-on to Linked Data is the idea of Linked Open Data (LOD).  LOD is Linked Data that is available under an open license.  Today when most people think of Linked Data, they are assuming that it's open data, so we'll loosly consider Linked Data and LOD to be the same thing.

# URIs

By [design](https://tools.ietf.org/html/rfc3986), URIs are intended to be globally unique identifiers. A URI is [at its heart an identifier](https://tools.ietf.org/html/rfc3986#page-9), but it may or may not actually be usable for retrieving information on the Internet.  URLs (Universal Resource Locators) are a subset of URIs that can be used to retrieve information in a web browser; for example:

<https://tools.ietf.org/html/rfc3986>

 but there are other forms of valid URIs that won't do anything when typed into a browser, such as: 

 ```
mailto:steve.baskauf@vanderbilt.edu
urn:oasis:names:specification:docbook:dtd:xml:4.1.2
```
## HHTP URIs

A specific variant of URIs that are of primary interest to Linked Data are HTTP URIs.  These are URIs that begin with "http://" or "https://".  The reason these URIs are important to Linked Data is because it's possible for them to be URLs (i.e. to use them to look stuff up through the Internet).  However, just because it's possible to use an HTTP URI to look something up doesn't necessarily mean that every valid HTTP URI will actually do something if you paste it into a browser.  For example, the HTTP URI

<http://ns.adobe.com/xap/1.0/rights/UsageTerms>

is a well-kmowm and valid HTTP URI from the International Press and Telecommunications Council Photo Metadata Standard, Extension Schema 1.1, but it does not do anything when you try to look it up on the web.  That underscores the point that URIs are always identifiers for things, but they may or may not be usable to retrieve information, even though providing that information is a best-practice in the Linked Data world.

## Internationalized Resource identifiers

Internationalized Resource Identifiers (IRIs) are a superset of URIs.  The primary difference is that IRIs can contain more characters than the more restricted character set allowed in URIs.  For example, 

```
https://en.wiktionary.org/wiki/Ῥόδος
```

is a valid IRI, but is not a valid URI since it uses letters from the Greek character set.  

It is increasingly common to see references to IRIs in the literature, so just be aware that for most purposes, they can be considered somewhat synonymous with URIs.

## Compact URIs (CURIEs)

Because URIs are often long and ugly, it has been a longstanding practice to abbreviate them using "namespaces".  Namespaces are a feature of [qualified names (or "QNames") in XML](https://www.w3.org/2001/tag/doc/qnameids).  QNames substitute an abbreviation for the first part of a URI in order to shorten it.  For example, if we use `ex:` as an abbreviation for `http://example.org/`, then the URI

```
http://example.org/myData
```

can be written as the QName

```
ex:myData
```

In XML lingo, the abbreviated part `http://example.org/` is known as the "namespace", and the abbrevation `ex:` may be referred to as the namespace abbreviation.  The last part of the URI, `myData` is often referred to as the "local name".  So a QName is composed of a namespace abbreviation combined with a local name.

Because of their use in XML, QNames have rules that are more restrictive than what we'd like in the context of Linked Data.  So a a broader syntax called [Compact URIs (CURIEs)](https://www.w3.org/TR/curie/) was developed.  They are essentially QNames, but with fewer restrictions about what constitutes a valid abbreviation.  For example, if we consider `orcid:` to be an abbreviation for `https://orcid.org/`, we could abbreviate the URI

```
https://orcid.org/0000-0003-4365-3135
```

as `orcid:0000-0003-4365-3135`.  This isn't a valid QName, since the rules of XML require that local names do not begin with numerals.  However, it is a valid CURIE, since the rules about local names are more relaxed in CURIEs than in QNames.  

You should consider that abbreviated URIs (i.e. CURIEs) are interchangeable with their unabbreviated forms.  Thus whenever you see an identifier with a colon in the middle, you should recognize that it stands for a URI.  For example,

```
dcterms:title
```

is an abbreviation for 

```
http://purl.org/dc/terms/title
```

with `dcterms:` as a namespace abbrevation for `http://purl.org/dc/terms/` and `title` as the local name.

## Commonly used namespace abbreviations

There are no official rules about what abbreviations should be used for namespaces.  However, there are longstanding consensus abbreviations for URIs from many well-known vocabularies and databases.  Here are some of the most common ones:

|abbreviation|namespace|
|---|---|
|rdf:|http://www.w3.org/1999/02/22-rdf-syntax-ns#|
|rdfs:|http://www.w3.org/2000/01/rdf-schema#|
|xsd:|http://www.w3.org/2001/XMLSchema#|
|dc:|http://purl.org/dc/elements/1.1/|
|dcterms:|http://purl.org/dc/terms/|
|foaf:|http://xmlns.com/foaf/0.1/|
|skos:|http://www.w3.org/2004/02/skos/core#|

The abbreviations for the two Dublin Core namespaces, `dc:` and `dcterms:` are the traditional abbreviations.  More recently, other abbreviations have been used, such as `dct:` instead of `dcterms:` and using `dc:` for `http://purl.org/dc/terms/` instead of `http://purl.org/dc/terms/`.  For that reason, it's a best practice to state the abbreviations that you are going to use before you use them. 

# Building a graph

## 