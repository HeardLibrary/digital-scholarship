---
permalink: /lod/sparql/
title: SPARQL
breadcrumb: SPARQL
---
**Note:** This tutorial assumes that you have a basic understanding of basic Linked Data and RDF terminology.  If necessary, review the lessons on [graphs, URIs, and triples](../graphs/) and [serilizations and triplestores](../serialization/) before proceeding.

# SPARQL

SPARQL is a [recursive acronym](https://en.wikipedia.org/wiki/Recursive_acronym) for *SPARQL Protocol and RDF Query Language*.  Its name provides some clues about what it's for.  SPARQL is at its core a *query language*.  It allows users to query RDF triples that are stored in a graph database.  But it has other pieces as well.  SPARQL *Update* allows users to manage data in a triplestore, such as adding or deleting triples or entire graphs.  It is also a *communications protocol* that specifies how a client (software on a local computer) should interact with a server (remote computer) through HTTP when the client wants to perform either a query or update operation.

The name SPARQL suggests similarities with SQL, a common query language for relational databases.  However, SPARQL queries have some features that are intimately related to the graphs contained in the triplestore. 

**Important general note:** Generally, SPARQL is not case sensitive with respect to the keywords.  However, variable names and URIs ARE case sensitive, so use care to be consistent with them.  Also, SPARQL is generally not picky about whitespace, so you can use line breaks and indentation to make the queries more readable.

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

## Writing graph patterns as triple patterns

As you can see, it can quickly get messy to try to describe the graph patterns in words.  It is easier to describe the graph pattern using a notation similar to the [Turtle RDF serialization](https://heardlibrary.github.io/digital-scholarship/lod/serialization/#turtle). The overall graph pattern is enclosed in curly brackets, and the pattern is described by listing each of the triple patterns that describe the links between the nodes we are interested in.  For example, here is the graph pattern for the first example:

```sparql
{
?document dcterms:creator ?person.
}
```

SPARQL does not care about whitespace, so we could have crammed the whole graph pattern onto one line instead of putting the curly brackets on separate lines.  But it's easier to read this way, especially when the graph pattern contains more than one triple pattern.  

Notice that the triple pattern contains *variables* (beginning with question marks): 
`?document` and `?person`.  The variables can take any value that satisfies the pattern.  Since there are five triples (subjects connected to objects by predicate arrows) in the solution, we can say that there are five sets of subjects and objects that can be *bound* to the two variables.  The names that we use for the variables are arbitrary.  We would get the same result if we used the pattern

```sparql
{
?a dcterms:creator ?b.
}
```

But it's easier to keep track of what the variables represent if we use names for them that are descriptive.  The predicate `dcterms:creator` is a compact URI (CURIE) abbreviation of the full URI `http://purl.org/dc/terms/creator`.  In order to use abbreviations such as this, we need to list the abbreviations used in the query in the prolog.  There will be an example of this later.  
We could have also listed the full URI if we use the angle bracket notation of Turtle:

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

## Restricting by type

A common triple pattern used in graph patterms is to say that a resource must be an instance of a particular class.  Since `rdf:type` is used to indicate a class of which a resource is an instance, we can use `rdf:type` (or its abbreviation `a`) as the predicate in a triple patterm.  Here's an example:

```sparql
{
?resource a foaf:Document.
?resource rdfs:label ?articleLabel. 
}
```

In this graph, every core resource has a label, so sorting them out by class is a good way to find the labels of only the articles.  

## Restricting the pattern to a particular named graph

If the triplestore has many named graphs, we can specify that some triple patterns must occure in a certain named graph, but not others.  The following graph pattern only looks for the triple pattern in the graph `http://vanderbilt.edu/faculty`:

```sparql
{
GRAPH <http://vanderbilt.edu/faculty> {
    ?person foaf:givenName "Jonathan".
    ?person foaf:familyName "Smith".
    }
}
```

Triple patterns restricted to a certain graph can be combined with triple patters in a different graph or no specific graph.  Here's an example:

```sparql
{
  GRAPH <http://bioimages.vanderbilt.edu/people> {?s1 rdf:type ?class.}
  GRAPH <http://vanderbilt.edu/wikidata> {?s2 rdf:type ?class.}
}
```

This graph pattern restricts `?class` to classes that the two graphs have in common.

## Restricting conditions with FILTER

There are many conditions that can be used to limit the graph pattern.  FILTER sets conditions on the values that can be bound to variables.  For example:

```sparql
{
?person foaf:givenName ?firstName.
FILTER (?firstName != "Steve")
}
```

would exclude people whose first names were "Steve".  In this example:

```sparql
{
?book dcterms:created ?year.
FILTER (?year < "1928")
}
```

`?book` is restricted to those created before 1928.  (Note: in this example, `?year` is a plain literal string.  Times and dates may also be datatyped, wihch complicates the comparison.)

Here's a filter that restricts the pattern to titles that have English language tags:

```sparql
{
?book dcterms:title ?name.
FILTER (langMatches(lang(?name)),"en")
}
```

The `langMatches()` function allows the language tag to be generic "en" or a subtag like "en-US".

# Query prologues

The prologue is listed at the start of the query and is used to specify the namespace prefixes that can be used in CURIEs (URI abbreviations).  Here are some of the common ones, listed in the format used by SPARQL:

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX : <http://example.org/>
```

This form of prolog is used in all of the types of SPARQL queries.

Any abbreviation (including the empty one `:`) can be used for a namespace.  However, the ones listed above are conventionally used (with some variation).  The empty namespace abbreviation is often used in examples to indicate that the namespace isn't important.  So it may be assigned to a namespace like `http://example.org/`.  

# SELECT SPARQL queries

The SELECT query type simply reports the values of variables that are bound in each solution to the graph pattern.  Here's the form of a SELECT query:


```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
SELECT ?book
WHERE
{
?book dcterms:created ?year.
FILTER (?year < "1928")
}
```

For compactness, the query could also be written as:

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
SELECT ?book WHERE {
?book dcterms:created ?year.
FILTER (?year < "1928")
}
```

The result of a SELECT query is all of the bindings that satisfy the graph pattern, including redundant ones.  Since we usually don't care about redundance, the keyword DISTINCT can be added to include only unique bindings in the results:

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
SELECT DISTINCT ?book WHERE {
?book dcterms:created ?year.
FILTER (?year < "1928")
}
```

The SELECT clause can be used to return more than one bound variable.

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
SELECT DISTINCT ?author ?year WHERE {
?book dcterms:created ?year.
?book dcterms:creator ?author.
}
```

The query above would provide a list of authors and the years in which they created things.  It would not break the results down by book.  If we want the query to return all of the variables included in the graph pattern, we can use `*`:

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
SELECT DISTINCT * WHERE {
?book dcterms:created ?year.
?book dcterms:creator ?author.
}
```

Using `*` is a good trick to list triples:

```sparql
SELECT DISTINCT * WHERE {
?subject ?predicate ?object.
}
LIMIT 10
```

Since there may be many results in a query like this, it's probably safest to include a LIMIT clause to just get a small sample of the results.

## Building the dataset

By default, the query is run on all of the triples in the database.  If you only want to include part of the triples, you can build a *dataset* by specifying the graphs to be included in the query using FROM clauses.  Here's an example:

```sparql
PREFIX dcterms: <http://purl.org/dc/terms/>
SELECT DISTINCT ?book
FROM <http://vanderbilt.edu/orcid>
FROM <http://vanderbilt.edu/wikidata>
FROM <http://vanderbilt.edu/doi>
WHERE {
?book dcterms:created ?year.
?book dcterms:creator ?author.
}
```

The dataset used in the query would consist of only the three graphs: `http://vanderbilt.edu/orcid`, `http://vanderbilt.edu/wikidata`, and `http://vanderbilt.edu/doi`.  All other triples in the triplestore would be ignored.

FROM clauses can be used in any kind of SPARQL query.



----
Revised 2019-02-05
