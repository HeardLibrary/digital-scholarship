---
permalink: /lod/sparql/
title: SPARQL
breadcrumb: SPARQL
---
**Note:** This tutorial assumes that you have a basic understanding of basic Linked Data and RDF terminology.  If necessary, review the lessons on [graphs, URIs, and triples](https://heardlibrary.github.io/digital-scholarship/lod/graphs/) and [serilizations and triplestores](https://heardlibrary.github.io/digital-scholarship/lod/serialization/) before proceeding.

# SPARQL

SPARQL is a [recursive acronym](https://en.wikipedia.org/wiki/Recursive_acronym) for *SPARQL Protocol and RDF Query Language*.  Its name provides some clues about what it's for.  SPARQL is at its core a *query language*.  It allows users to query RDF triples that are stored in a graph database.  But it has other pieces as well.  SPARQL *Update* allows users to manage data in a triplestore, such as adding or deleting triples or entire graphs.  It is also a *communications protocol* that specifies how a client (software on a local computer) should interact with a server (remote computer) through HTTP when the client wants to perform either a query or update operation.

The name SPARQL suggests similarities with SQL, a common query language for relational databases.  However, SPARQL queries have some features that are intimately related to the graphs contained in the triplestore. 

# Graph patterns

A fundamental feature of both SPARQL queries and updates is the *graph pattern*.  A graph pattern describes the circumstances in the data that must be satisfied in order to achieve a solution to the query.  The pattern that is specified is describes the parts of the graph structure in which we are interested, so it isn't really possible to write a graph pattern without being aware of the model that underlies the graph of interest.  

In the following examples, we'll use the graph model and data from earlier lessons.

![graph model](../images/graph-model.png)

The diagram above shows how three classes of things are related to each other.  (For a larger view of the model, view [this PDF](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/vandy/graph-model.pdf)).  Although each bubble representing a class in the model is labeled with the URI of a particular instance, the bubble represents the class in general.  The next diagram shows a diagram of the actual graph itself, and includes all of the specific data we can query.

![dataset graph](https://github.com/HeardLibrary/digital-scholarship/raw/master/data/rdf/vandy/vandy-graph.png)

Notice that in contrast to the general model of classes, this diagram shows every instance of each class: one organization, two people, and five documents.  In graph terminology, each of these URI-identified "bubbles" representing core resources are called *nodes*.  They are, in turn, connected to many literal nodes (represented by rectangles) that contain text strings that describe the nodes they are connected to.  There are also three important bubbles that tell the class to which the core resources belong.  They are connected by `rdf:type` links (abbreviated as `a` in the graph model).  

In general, we can refer to each circle or rectangle as a *node*, and each arrow as an *edge*.  In RDF terms, the edges are called *predicates* (which you can also consider to be synonymous with *properties*).  

We could describe a simple graph pattern in words: "what are all of the cases where a subject node is connected to an object node by a `dcterms:creator` predicate?"  By examining the diagram, we can see that there are five arrows that fit the pattern: one for each time a document is connected to a person.  We can say that there are five solutions that satisfy this graph pattern.  

We can make the pattern more specific.  We could say, "what nodes are the objects connected to a subject node by a `dcterms:creator` predicate, where the subject node is also connected to an object by a `dcterms:title` predicate to a text string that is 'Let My People Go' ?"  This further limits the solution to the previous graph pattern, because although there are five situations where documents are connected to people, only one of those documents is also connected to a node with the text "Let My People Go".  So the node we are interested in is the one with the label "Shaul Kelner" (i.e. the node that represents the person whose name is "Shaul Kelner").  

As you can see, it can quickly get messy to try to describe the graph patterns in words.  It is easier to describe the graph pattern using a notation similar to the [Turtle RDF serialization](https://heardlibrary.github.io/digital-scholarship/lod/serialization/#turtle). The overall graph pattern is enclosed in curly brackets, and the pattern is described by listing each of the triple patterns that describe the links between the nodes we are interested in.  For example, here is the graph pattern for the first example:

```sparql
{
?document dcterms:creator ?person.
}
```

SPARQL does not care about whitespace, so we could have crammed the whole graph pattern onto one line instead of putting the curly brackets on separate lines.  But it's easier to read this way, especially when the graph pattern contains more than one triple pattern.  

Notice that the triple pattern contains *variables* (beginning with question marks): `?document` and `?person`.  The variables can take any value that satisfies the pattern.  Since there are five triples (subjects connected to objects by predicate arrows) in the solution, we can say that there are five sets of subjects and objects that can be *bound* to the two variables.  The names that we use for the variables are arbitrary.  We would get the same result if we used the pattern

```sparql
{
?a dcterms:creator ?b.
}
```

But it's easier to keep track of what the variables represent if we use names for them that are descriptive.  The predicate `dcterms:creator` is a compact URI (CURIE) abbreviation of the full URI `http://purl.org/dc/terms/creator`.  In order to use abbreviations such as this, we need to list the abbreviations used in the query in the prolog.  There will be an example of this later.  We could have also listed the full URI if we use the angle bracket notation of Turtle:

```sparql
{
?document <http://purl.org/dc/terms/creator> ?person.
}
```


Here's what the graph pattern would be for the second example:

```sparql
{
?document dcterms:creator ?person.
?document dcterms:title "Let My People Go"@en.
}
```

Notes:

- In the [RDF](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/vandy/vandy.ttl), the book title has an English language tag.  We must include this in the triple pattern or we won't get a match.  There is a way around this, but we won't get into that now.
- In this query, the `?document` variable is a sort of "dummy" variable.  We don't actually care what it is -- we just need to refer to it because it's the connecting node between the title and the person we are trying to find.
- In this case, the solution to the graph pattern that we care about is the URI that gets bound to the `?person` variable.



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




## The graph as RDF triples

We can describe the graph completely by simply writing a triple for every connection in the graph diagram.  That has been done in [this table](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/vandy/vandy-triples.csv).  There are 66 triples in the graph.  If you count the arrows in the diagram, you will find fewer than 66 because the label properties are written under the bubbles rather than showing them linked as arrows.

Since the Wikipedia page, Vanderbilt website, and Wikidata entry for Vanderbilt (Q29052) are identified with URIs, they are shown as bubbles rather than rectangles in the bubble chart, and are enclosed in angle brackets in the table of triples.  If we were able to retrieve additional things about those three URI-identified resources (which we could do for at least the Wikidata entry), we could extend the graph as Tim Berners-Lee suggested in his fourth characteristic of Linked Data.



----
Revised 2019-02-05
