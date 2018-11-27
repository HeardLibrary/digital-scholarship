# Code for interacting with APIs

## Introduction

Technically, an **application program interface (API)** is a system of functions and communication protocols to make it easy to develop software.  In common usage, "an API" generally means a web API where an application (software) can communicate through the Internet with a server that provides data services through a standardized protocol.  

The data provider specifies an **endpoint**, which is the URL to which a request for data from the server can be sent.  The data provider also specifies the exact form of the URL that is required to retrieve a particular kind of data.  The application that uses the data communicates with the server using Hypertext Transfer Protocol (HTTP).  The simplest kind of communication is a GET request, where the application simply requests the server to send a particular item (known as a **resource**).  Since a GET request is read-only, it often does not require any kind of password or authentication unless the requested resources is secure or private.

## A simple example

The [Global Biodiversity Information Facility (GBIF)](https://www.gbif.org/) allows applications to search their organism occurrence database using [their Occurrence API](https://www.gbif.org/developer/occurrence), which has an endpoint

```
http://api.gbif.org/v1/occurrence/search
```

The API instructions say that occurrences recorded by a particular person can be retrieved by adding a query string the end of the endpoint URL.  To find occurrences recorded by "William A. Haber", the query string is "recordedBy=William%20A.%20Haber" (where the code "%20" replaces spaces in the name).  The query string is separated from the endpoint URI by a question mark character, making the complete URL for the API request:

```
http://api.gbif.org/v1/occurrence/search?recordedBy=William%20A.%20Haber
```

You can put this URL in a web browser and see what happens. The result is a bunch of machine-readible **Javascript Object Notation (JSON)** that doesn't mean much to human eyes, but which can easily be interpreted by software.  

## Internet Media Types (MIME types)

In the case of the GBIF API, the data are available only in the form of JSON.  However, some APIs allow you to request the results in different **serializations** (representations of the data in different forms).  Serializations are identified by standard abbreviations, known as Internet Media Types (also known as MIME types).  For example, the MIME type for JSON is "application/json".  The HTTP protocol allows the application to request particular serializations using an "Accept" request header, and the server tells the application the kind of file it is sending using a "Content-type" response header.

### Common Internet Media Types

|serialization|Internet Media Type|
|---|---|
|web page (HTML)|text/html|
|JSON|application/xml|
|XML|application/xml|
|CSV|text/csv|

Notes:
1. There are sometimes multiple MIME types for a serialization.  The ones listed above are the most commonly used ones.
2. MIME types are written in lower case only.

## Simple functions to request data from an API

