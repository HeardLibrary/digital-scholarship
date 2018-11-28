# Code for interacting with APIs

This code is freely available under a [Creative Commons CC0 license](https://creativecommons.org/publicdomain/zero/1.0/) ![](https://licensebuttons.net/l/zero/1.0/88x31.png)

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
|JSON|application/json|
|XML|application/xml|
|CSV|text/csv|

Notes:
1. There are sometimes multiple MIME types for a serialization.  The ones listed above are the most commonly used ones.
2. MIME types are written in lower case only.

## Simple functions to request data from an API

### Function httpGet

**Description** Performs an HTTP GET call to a URL and requests a particular Internet Media Type.  The function returns the HTTP status code and the response body.

**Arguments and Return Type**

| name | type | description|
|---|---|---|
| uri | string | The URL of the endpoint or file to be retrieved |
| acceptMime | string | The Internet Media Type requested. |
| *return value* | sequence of two items | First item is the HTTP status code, second item is the response body |

**Example (Python 3)**

Code is [here](python/http_library.py).  The function uses the **requests** module, which is not in the standard library and must be installed using PIP.  The code can be copied and pasted into a script, or the http_library.py file can be included in the same directory as the script and imported. If copy and paste is used, the libraries **requests**, **csv**, and **json** must be imported (see lines 1-3 of the [code](python/http_library.py)).

The return value is a list of two items: the HTTP status code as an integer and the response body as a string.

```python
import http_library
uri = 'http://api.gbif.org/v1/occurrence/search?recordedBy=William%20A.%20Haber'
acceptMime = 'application/json'
response = http_library.httpGet(uri, acceptMime)
print('Status: '+string(response[0]+'\nBody:\n'+response[1]))
```

**Example (XQuery)**
This function uses functions from the BaseX HTTP module, and is therefore BaseX-specific.

The function can be copied from this [code](xquery/http_library.xq), or called from this [module](xquery/http_library.xqm).  The module namespace and retrieval URL are shown in the example below.

The return value is a sequence of two items: the HTTP status code as a string and the response body as an XML node (the structure of the node depends on the serialization requested).

```xquery
xquery version "3.1";

import module namespace vudsscapi = 'https://github.com/HeardLibrary/digital-scholarship/tree/master/code/api' at 'https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/code/api/xquery/http_library.xqm';

let $uri := "http://api.gbif.org/v1/occurrence/search?recordedBy=William%20A.%20Haber"
let $acceptMime := "application/json"
return vudsscapi:httpGet($uri,$acceptMime)
```
