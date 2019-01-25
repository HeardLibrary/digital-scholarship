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
<http://orcid.org/0000-0002-3178-0201> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://xmlns.com/foaf/0.1/Person>.
<http://orcid.org/0000-0002-3178-0201> <http://www.w3.org/2000/01/rdf-schema#label> "Julian Hillyer".
```
(Scroll the code window to the right to see all of the triples.) [Download file](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/serializations/example.nt)

N-Triples is not particularly easy to read because no abbreviation of URIs is allowed.  But it is very easy to write software to consume it, and it's easy to manipulate the triples in a file, since each triple is on a separate line.

RDF text files in N-Triples serialization are usually given the file extension `.nt`.

## Turtle

Turtle stands for "Terse RDF Triple Language".  N-Triples is a subset of the RDF Turtle serialization, meaning that any file that is valid N-Triples is also valid Turtle serialization.  However, Turtle allows compact URIs (CURIEs) and also allows shortcuts to prevent repeating parts of triples.  For example, if several triples share the same subject, the predicates and objects can be listed, separated by semicolons.  Here are the same triples as in the previous example, serialized as Turtle:

```turtle
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix orcid: <http://orcid.org/> .
@prefix mads: <http://www.loc.gov/mads/rdf/v1#> .

orcid:0000-0002-3178-0201 dcterms:created "2014-12-22T22:25:56.900Z"^^xsd:dateTime;
                          mads:hasAffiliation <http://www.grid.ac/institutes/grid.152326.1>;
                          rdf:type foaf:Person;
                          rdfs:label "Julian Hillyer".
```
[Download file](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/serializations/example.ttl)

The namespace prefixes that are used in the triples must be listed in a prolog at the start of the document.  Notice that URIs aren't required to be abbreviated.

In Turtle, you can use whitespace to make the triples more readable.  In this example, the second through fourth triples are indented to show that they share the same subject.  

If two triples share both the same subject and predicate, the two objects can be separated by commas.  For example:

```turtle
orcid:0000-0002-3178-0201 rdf:type foaf:Person;
                          rdfs:label "Julian Hillyer",
                                     "J. Hillyer".
```

Turtle also allows a special abbrevation for the important predicate `rdf:type`.  It can be replaced with `a`. For example:

```turtle
orcid:0000-0002-3178-0201 a foaf:Person.
```

RDF text files in Turtle serialization are usually given the file extension `.ttl`.

## XML

XML is the oldest serialization of RDF. For that reason, it is still one of the most commonly provided forms of RDF.  Many people who are unfamiliar with XML find it difficult to read and interpret as triples.  However, one advantage is that it can be generated from other forms of data using tools like XQuery.  We won't be discussing the structure of RDF/XML here, but here is what the four triples shown in our previous example look like when serialized as XML:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:foaf="http://xmlns.com/foaf/0.1/"
         xmlns:dcterms="http://purl.org/dc/terms/"
         xmlns:mads="http://www.loc.gov/mads/rdf/v1#"
         xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#">

  <foaf:Person rdf:about="http://orcid.org/0000-0002-3178-0201">
    <dcterms:created rdf:datatype="http://www.w3.org/2001/XMLSchema#dateTime">2014-12-22T22:25:56.900Z</dcterms:created>
    <mads:hasAffiliation rdf:resource="http://www.grid.ac/institutes/grid.152326.1"/>
    <rdfs:label>Julian Hillyer</rdfs:label>
  </foaf:Person>
</rdf:RDF>
```
[Download file](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/serializations/example.rdf)

RDF text files in XML serialization are usually given the file extension `.rdf`.

## JSON-LD

One of the newest RDF serializations is JSON-LD.  It is gaining popularity because of the widespread use of JSON in APIs and as a broadly usable data trasfer format.  JSON-LD is now a preferred format for providing structured data to the Google knowledge graph in web pages.

JSON-LD is actually a broader serialization for Linked Data since it includes additional features that are not included in strict RDF.  However, valid RDF can be transformed into JSON-LD.  There are actually several equivalent forms of JSON-LD (expanded, compacted, flattened, and framed) - see the [JSON-LD Playground](https://json-ld.org/playground/) for more details. 

Here's the four triples we've been looking at (in compacted form):

```json
{
  "@id": "http://orcid.org/0000-0002-3178-0201",
  "@type": "http://xmlns.com/foaf/0.1/Person",
  "http://purl.org/dc/terms/created": {
    "@type": "http://www.w3.org/2001/XMLSchema#dateTime",
    "@value": "2014-12-22T22:25:56.900Z"
  },
  "http://www.loc.gov/mads/rdf/v1#hasAffiliation": {
    "@id": "http://www.grid.ac/institutes/grid.152326.1"
  },
  "http://www.w3.org/2000/01/rdf-schema#label": "Julian Hillyer"
}
```
[Download file](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/serializations/example.json)

As in the case of XML, JSON-LD is intended primarily for machine consumption, so we won't belabor its details.  If you are interested in more information about JSON, JSON-LD, and providing structured data in web pages, see [this presentation](https://github.com/HeardLibrary/linked-data/blob/gh-pages/assets/notes-2018-fall/json-ld-2018-09-24.pdf).

JSON-LD files are usually given the default JSON file extension `.json`.

# Validating and converting between serializations

There are several online tools that can be used to validate and convert small RDF files from one serialization to another.  The best one is probably [RDF Translator](http://rdf-translator.appspot.com/), but the [EasyRDF Converter](http://www.easyrdf.org/converter) also works pretty well.  

Large files can be validated and converted using the rdfEditor application, part of the [dotNetRDF package](https://www.dotnetrdf.org/) of programs.  Unfortunately, it is only available for Windows. 

The W3C provides an [RDF validator](https://www.w3.org/RDF/Validator/) that unfortunately only accepts RDF/XML input.  However, it is one of the few online services that will provide a graphical diagram of the graph.  Select the "Graph only" option of "Triples and/or Graph" before parsing the RDF.  Here's an example of the output from the RDF/XML example above.

![graphical diagram](../images/w3c-validator-diagram.png)

By using one of the converter tools to convert an RDF serialization to XML, then the W3C Validator, it's possible to generate a diagram for any serialization.

# Designating and identifying graphs

Although triples can be serialized in a text document in one of the formats described above, simply existing in the same document does not make particular triples be part of a particular graph.  One of the features of RDF is that when triples are placed together in the same graph, they lose any identity that they may have had due to their source or theri position in a particular document.  That is good, because it makes it extremely easy to merge datasets from different sources.  However, it can also be bad because once the triples are dumped into a triplestore, we can lose track of any information about their provenance.  

## Graph URIs and N-Quads

The solution to this is to associate triples with a graph URI.  A URI can be used to uniquely identify anything, including sets of triples (which is essentially a way to define a graoph).  Because there is no requirement that a URI actually resolve to anything, or be used to retrieve something (as in the case of a URL), we can simply "make up" a URI to refer to a set of triples.  As long as the form of the URI is valid, we can use any URI that we like.  (If we are concerned about possible collisions of a graph URI that we mint with graph URIs created by someone else, we should use a domain name that we control and have a systematic method for generating the URIs.)

Let's say that we want to identify the set of four triples that we've been using in our examples using the URI `http://library.vanderbilt.edu/ldwg/researchers`.  There is a variant of N-Triples called [*N-Quads*](https://www.w3.org/TR/n-quads/) that allows us to designate that a particular triple is part of a particular graph.  The rules for N-Quads are essentially the same as for N-Triples, except that a fourth URI is added to each line indicating the graph to which the triple belongs.  Here is what our sample data would look like in N-Quads serialization if we assign the triples to the `http://library.vanderbilt.edu/ldwg/researchers` graph:

```nquads
<http://orcid.org/0000-0002-3178-0201> <http://purl.org/dc/terms/created> "2014-12-22T22:25:56.900Z"^^<http://www.w3.org/2001/XMLSchema#dateTime> <http://library.vanderbilt.edu/ldwg/researchers>.
<http://orcid.org/0000-0002-3178-0201> <http://www.loc.gov/mads/rdf/v1#hasAffiliation> <http://www.grid.ac/institutes/grid.152326.1> <http://library.vanderbilt.edu/ldwg/researchers>.
<http://orcid.org/0000-0002-3178-0201> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://xmlns.com/foaf/0.1/Person> <http://library.vanderbilt.edu/ldwg/researchers>.
<http://orcid.org/0000-0002-3178-0201> <http://www.w3.org/2000/01/rdf-schema#label> "Julian Hillyer" <http://library.vanderbilt.edu/ldwg/researchers>.
```
(Scroll the code window to the right to see all of the quads.) [Download file](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/rdf/serializations/example.nq)

The recommended file extension for N-Quads is `.nq`.

## RDF datasets and the default graph

An RDF *dataset* refers to a collection of graphs that interest us for some purpose.  In an RDF dataset, all but one of the graphs are named graphs.  The unnamed graph is called the *default graph*.  

If we refer to a set of triples without designating that it is associated with a named graph, we can assume that those triples are part of the default graph.  For example, if an application expects an N-Quad file but we provide it with an N-Triple file (essentially an N-Quad file with the graph URIs missing), the application will assume that the triples belong to the default graph.  

There is some lack of clarity about the exact meaning of RDF datasets and the roles of default and named graphs within them, and there are inconsistencies in how different applications handle cases where the name of a graph isn't specified. For more details, see the [W3C RDF Datasets](https://www.w3.org/TR/rdf11-datasets/) document and [this blog post](http://baskauf.blogspot.com/2017/02/sparql-weirdness-of-unnamed-graphs.html). For those wha aren't interested in the details, we can say that there are two "safe" approaches:

- don't care about dividing triples up among named graphs and dump all triples that we want to consider part of our dataset into the default graph
- care about dividing triples among named graphs and make sure that every triple is part of a named graph

The troublesome situations occur when we mix triples from named graphs with triples where no graph is specified.

## An aside on HTTP

To understand how we can interact with a *triplestore* (a graph database that stores RDF triples), we need to know a little bit about *HyperText Transfer Protocol* (HTTP) and its cousin, HTTPS (secure HTTP).  

![URL box example](../images/http-url.png)

Most people have seen the `http://` that is the start of most URLs.  Today, many URLs start with `https://` indicating that communication is secure.  Regardless of the flavor, the HTTP protocol specifies how software on a local computer (the *client*) interacts with a remote computer (the *server*).  

![HTTP GET example](../images/http-get.png)

There are several kinds of transactions that can take place via HTTP.  The diagrapm above illustrates one of the most common, a GET request.  In a GET request, the client asks the server for a document.  In the example above, the client is a web browser, and the document requested is an HTML web page.  There are several key parts to the GET transaction:

- the URL identifies the server
- an Accept header says what kind of document the client wants (in this case text/html; a web page)
- an HTTP status code (indicating if the server was successful in finding and serving; 200 "Success" in this case)
- the response body containing the content of the file (in this case the HTML text document)

If you carry out this transaction in a web browser, all of this interaction takes place under the hood.  When the browser receives the HTML text document, it renders it as a web page suitable for a human viewer.

If you want to actually see the gory details of the transaction, you can use client software that will show you what's going on in the interaction.  We can use [Postman](https://www.getpostman.com/) to see what's actually going on:

![HTTP GET in Postman](../images/postman-dialog.png)

We can interact with a triplestore using HTTP GET if we want to query it.  We can also use another kind of HTTP request, POST, to load data into the triplestore.

# Loading data into a triplestore

There are very few useful things we can do with linked RDF data unless we can load it into a triplestore.  There are three main ways that we can load data:

1. Using a graphical interface (GUI)
2. Using HTTP POST
3. Using software intermediaries

We will see how to 

----
Revised 2019-01-25
