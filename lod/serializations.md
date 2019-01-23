---
permalink: /lod/serializations/
title: RDF serializations and triplestores
breadcrumb: Serializations
---
[previous lesson](../graphs/)

# Linked Data Basics: RDF Serializations and Triplestores

Since RDF is an abstract model for expressing information about graphs, it can be expressed in a number of concrete ways.  One way that is particularly easy for humans to understand is a graphical diagram.  The triples in [this table](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/vandy/vandy-triples.csv) form a graph that can be represented by this diagram:

![dataset graph](https://github.com/HeardLibrary/digital-scholarship/raw/master/data/rdf/vandy/vandy-graph.png)

However, it is generally not possible for machines to interpret graphs that are expressed as diagrams. Machine need an RDF *serialization*, a method of transmitting or storing the information about the triples in the graph as a file.

## N-Triples

The simplest RDF serialization is called [*N-Triples*](https://www.w3.org/TR/n-triples/).  In N-Triples, the URIs that are included in the triple are written in their unabbreviated form and enclosed in angle brackets.  String literals are enclosed in double quotes and can be followed by either a language tag or datatype URI (written in unabbreviated form).  

The subject, predicate, and object are written in order. The end of the triple is indicated with a period, followed by a newline character (hard return) - in other words, each triple is written on a separate line.  

Here is an example of part of the graph diagrammed above:

```ntriples
<http://orcid.org/0000-0002-3178-0201> <http://purl.org/dc/terms/created> "2014-12-22T22:25:56.900Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>.
<http://orcid.org/0000-0002-3178-0201> <http://www.loc.gov/mads/rdf/v1#hasAffiliation> <http://www.grid.ac/institutes/grid.152326.1>.
<http://orcid.org/0000-0002-3178-0201> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <	http://xmlns.com/foaf/0.1/Person>.
<http://orcid.org/0000-0002-3178-0201> <http://www.w3.org/2000/01/rdf-schema#label> "Julian Hillyer".
```

N-Triples is not particularly easy to read because no abbreviation of URIs is allowed.  But it is very easy to write software to consume it, and it's easy to manipulate the triples in a file, since each triple is on a separate line.

## Turtle

Turtle stands for "Terse RDF Triple Language".  N-Triples is a subset of the RDF Turtle serialization, meaning that any file that is valid N-Triples is also valid Turtle serialization.

----
Revised 2019-01-14
