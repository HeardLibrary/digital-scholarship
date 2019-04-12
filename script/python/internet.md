---
permalink: /script/python/internet/
title: Data from the Internet
breadcrumb: Internet
---

Note: this is the sixth lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[prevous lesson on data structures](../inout/)

Answers for last week's challenge problems:

# Requests library for the Internet

If we have data on our local computer in the form of a file, we can avoid hard-coding a large amount of information in our script, or having to do a lot of data entry when the script is run.  However, sometimes the information is already available online, so it would be nice to be able to make use of that information without requiring the user to download it.

There are features for using HTTP (Hypertext Transfer Protocol) in the Python standard library, but the best methods are part of the `requests` module.  (You may need to use PIP to install `requests` or in Thonny use "Manage packages..." under the Tools menu.)  Here is a simple example that makes an HTTP request and prints the response code using the `.status_code` method:

```python
import requests

r = requests.get('http://bioimages.vanderbilt.edu/baskauf/24319.rdf')
print('HTTP status code: ', r.status_code)
```

Note: The `requests.get()` method creates a requests "Response" instance.

The `.text` method returns the body of the HTTP request.  The body is a single string containing the content of the delivered file.  

The requests module is a great way to access data stored on GitHub. For example, here's some data on schools in Nashville: <https://github.com/HeardLibrary/digital-scholarship/blob/master/data/gis/wg/Metro_Nashville_Schools.csv>. This URL dereferences to the GitHub page for the data.  If we want to retrieve the data itself, we need the Raw file.  In the past, we downloade Raw data by right-clicking on the Raw button and selecting "Save link as...".  We can acquire the URL of the Raw data by right-clicking and selecting "Copy link address".  In this example, we get <https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv>.  With the URL from the Raw file, we can retrieve the file contents as a string.  Here's an example:

```python
import requests

r = requests.get('https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv')
print(r.text)
```

## Reading from CSV files from the Internet

If the file that we are retrieving from the web is a CSV file (as was the case for the Nashville school data), we can use the same methods from the `csv` module as we did when loading data from a file locally.  

When we open a file object, it's an iterable object and we can turn it into a reader or DictReader object.  However, the string that we get from the requests `.text` method is a string, which is not iterable.  However, as we saw at the end of the section on loading text from a file, we can turn a string containing newlines into a list using the `.split()` method, with '\n' as the argument.  Since a list is iterable, it can be passed into either the `.reader()` or `.DictReader()` methods.  Here is some code that reads in the Nashville school data and uses the `.reader()` function to create a list of lists serving as a table of the school data:

```python
import requests
import csv

r = requests.get('https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv')
fileText = r.text.split('\n')
if fileText[len(fileText)-1] == '':
    fileText = fileText[0:len(fileText)-1]
fileRows = csv.reader(fileText)
schoolData = []
for row in fileRows:
    schoolData.append(row)

# print the IDs and names of all of the schools
print(schoolData[0][2] + '\t' + schoolData[0][3])
for school in range(1, len(schoolData)):
    print(schoolData[school][2] + '\t' + schoolData[school][3])
```

Notes:
- After the string is turned into a list, but before that list is turned into a .reader() object, there is a check to see if the file contained a final newline at the end of the last row of data in the CSV.  If so, the .split() method will create a final empty string in the list, which will result in an empty final list in the list of lists.  So the `if` statement removes the final empty string (if it's there) before creating the .reader() object.
- As the first `for` loop iterates through the .reader() object, it appends the row list to the schoolData list of lists.
- The school ID  is in the third column (column 2 counting from 0) of the table and the school name is in the fourth column, so the final `for` loop prints the IDs and names of all of the schools in the table.  

If we replace the `.reader()` class with the `.DictReader()` class, we can create a list of dictionaries instead. Instantiating the dictionary reader is not sensitive to a trailing final newline, so we can leave off the `if` statement checking for it.

```python
import requests
import csv

r = requests.get('https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv')
fileText = r.text.split('\n')
fileRows = csv.DictReader(fileText)
schoolData = []
for row in fileRows:
    schoolData.append(row)

# use the dictionary to look up a school ID
schoolName = input("What's the name of the school? ")
found = False
for school in schoolData:
    if school['School Name'] == schoolName:
        print('The ID number for that school is: ' + school['School ID'])
        found = True
if not found:
    print("I couldn't find that school.")
```

# JSON

Currently, Javascript Object Notation (JSON) is one of the most popular was to transmit data between applications.  Most application programming interfaces (APIs) that are available online provide data in the form of JSON -- sometimes exclusively.  

## JSON background

Here are some basics about JSON.

A basic unit of JSON is a *key:value pair*.  for example:

```
"name":"Steve"
"fingers":10
```

The key (technically called a "name" in JSON) must be a string in quotes.  The value can be a string (in double quotes), a number (not in double quotes), or other things.  In JSON, double quotes must be used to enclose quotes -- single quotes aren't allowed.

A *JSON object* is an unordered list of key:value pairs, separated by commas and enclosed in curly brackets:

```json
{"name":"Steve", "fingers":10, "street":"Keri Drive"}
```

A *JSON array* is an ordered list of values, separated by commas and enclosed in square brackets.  As in key:value pairs, array values can be strings (in double quotes), numbers (not in double quotes), or other things:

```json
["Steve", "Steven", "Esteban"]
```

The "other things" allowed as values in key:value pairs or arrays can be JSON objects or arrays.  Thus JSON can have complicated nested structures, such as arrays within objects, objects within arrays, arrays within arrays, objects within objexts, or more complicated combinations.  For example:

```json
{"name":["Steve", "Steven", "Esteban"], "fingers":10, "street":"Keri Drive"}
```

In this example, nesting an array as a value with a JSON object shows that the name key can have the multiple values within the array.  

Whitespace is not important in JSON.  The following three JSON structures are exactly the same:

```json
{"name":["Steve","Steven","Esteban"], "fingers":10, "street":"Keri Drive"}
```
```json
{"name":["Steve","Steven","Esteban"],
 "fingers":10, 
 "street":"Keri Drive"}
```
```json
{
  "name":
         [
         "Steve",
         "Steven",
         "Esteban"
         ],
  "fingers":10, 
  "street":"Keri Drive"
}
```

Whitespace can be used to make the JSON more readable to humans, but consuming software sees the alternatives as the same.

For the details of JSON, see [this page](https://www.json.org/).

## JSON and Python

As you read the previous section, you may have noticed that JSON is very similar to data structures that we have used in Python (with the exception that JSON requires double quotes and Python allows either double or single quotes).  A "JSON object" is very similar to a Python dictionary.  A "JSON array" is very similar to a Python list. In the same way that JSON objects can be nested within arrays or arrays nested within objects, Python dictionaries can be nested within lists or lists nested within dictionaries.  So pretty much any JSON data structure can be translated into a complex Python data object.  

There is a Python library, appropriately called the json module, that will convert a JSON string into a Python data object and vice versa.  Here is an example of how it can be used:

```python
import json

jsonString = '''{
  "name":
         [
         "Steve",
         "Steven",
         "Esteban"
         ],
  "fingers":10, 
  "street":"Keri Drive"
}'''

data = json.loads(jsonString)

print(data)
print(data['name'])
print(data['fingers'])
print(data['name'][1])
```

Notes:
- Notice how the triple single-quote was used to create a multi-line string that includes the newlines as part of the string.  Since newlines and spaces are ignored whitespace, the `.loads()` method has no problem with them and the multi-line string is easier for us to read.
- In the dictionary that results from the `.loads()` method, we can refer to values by the key string.
- Since the value of the `name` key is a list, we have to include an index number in second set of square brackets to refer to the value that we want.

The json module has a `.dumps()` method that works in the reverse direction: it turns a data structure composed of dictionaries and lists into a JSON string that can be saved in a file or used in some other way.

## JSON from APIs

Since a lot of APIs on the web provide JSON through HTTP, the `requests` module has a method `.json()` that will directly turn JSON text from the body of an HTTP response into a Python data structure.  Essentially, it is like combining the requests module `.text()` method with the json module `.loads()` method in a single step.  

The [Global Biodiversity Information Facility (GBIF)](https://www.gbif.org/) allows users to search its records of over a billion organism occurrences via its API.  Usually, an API has a web page that explains how to make the HTTP request.  The directions for searching occurrence records are on [this page](https://www.gbif.org/developer/occurrence#search).  The search URL is constructed by concatenating the root endpoint URI (`http://api.gbif.org/v1`) with the search subpath (`/occurrence/search`) followed by a question mark, then the query string.  It's typical to query APIs this way (combining a complete endpoint URL with a query string, separated by a question mark).  

Usually, the values in query strings must be "URL-encoded" so that characters that aren't "safe" in the URL are escaped.  In our example, we are searching for occurrences recorded by "William A. Haber", so the spaces between the names muse be escaped with `+`.  

The requests module will automatically encode query string values of passed parameters and concatenate them with ampersands, the appropriate format when there are multiple parameters in the query string. The keys and values are included in the `.get()` method as a dictionary of keys and values to be encoded.  Here's an example:

```python
r = requests.get('http://api.gbif.org/v1/occurrence/search', params={'recordedBy' : 'William A. Haber'})
```

You can see the URL that requests generates by printing the `.url` attribute of the response instance:

```python
print(r.url)
```

After URL-encoding, the entire URL for the query is:

```
http://api.gbif.org/v1/occurrence/search?recordedBy=William+A.+Haber
```

If you put this URL directly into a browser URL bar, you can see the raw JSON response from the API.  

Here's the basic structure of the results JSON:

```json
{
"offset":0,
"limit":20,
"endOfRecords":false,
"count":2770,
"results":[
    lots of results go in here
        ],
"facets":[]
}
```

The value of the `results` key is an array that contains a list of result objects separated by commas.  Each of the reult objects has a long list of key:value pairs whose values are what we really are interested in.  Here's some code that will fetch the JSON, turn it into a Python structure, pull out the results, and show us the first (index of 0) dictionary in the list of results:

```python
url = 'http://api.gbif.org/v1/occurrence/search'
r = requests.get(url, params={'recordedBy' : 'William A. Haber'})
data = r.json()

print(data['results'][0])
```

To see more useful output, replace the print statement with this code

```python
resultsList = data['results']
for result in resultsList:
        print(result['species'] + ', date: ' + result['eventDate'])
        print('Observed at: ' + result['locality'] + ', ' + result['country'] + '\n')
```

In this example, the API does not require any authentication.  Authentication is nearly always required to write to an API using an HTTP POST request and in a lot of cases it's also required for a read-only GET request as well.  This is to prevent abuse of the API.  

Sometimes an API will offer results in several possible formats, such as JSON or XML.  In such cases, one may need to send an `Accept:` header with the desired Internet Media Type (MIME type).  The MIME type for JSON is `application/json` and for XML is `text/xml`.  The request headers are sent as a dictionary, like this: 

```python
r = requests.get(uri, headers={'Accept' : 'application/json'})
```

**API etiquette:**

1. Do not try to scrape the entire contents of the API.  This is considered bad form.  If the site has open data, it will often provide a compressed dump of the entire dataset that you can download rather than making a massive API call.

2. Do not try to download a massive amount of data.  Usually the API will place a limit on the number of results that can be retrieved in a single call.  To retrive many results, there is usually a paging feature where you can retrive a certain number of results (like 20 or 100) in each request.  The pages are numbered so you can request them sequentially.

3. Do not hit the API repeatedly in a short period of time.  This is actually pretty easy to do with a script that can execute hundreds of operations per second.  Use the `.wait()` method from the time module to space your calls out.



# TkInter graphical interface
 
 Although Python isn't the greatest platform for building applications with graphical user interfaces (GUIs), it does include the tkinter module creating GUIs.  In a number of previous lessons, we've played around with using tkinter to create GUI versions of the scripts we wrote.  Here we'll present a brief overview since it's a significant possible method of user input and output.

 The primary object of tkinter is an instance of the `Tk` class.  A `Tk` instance is usually the main *window* of an application.  The various items in the window (buttons, text boxes, dropdown lists, etc.) are called *widgets*.  Within the main window, widgets are organized in *frames*. 

 As with everything else in Python, widgets are objects.  So they are usually created by assigning an instance of their class to a variable.  Since a window is likely to have more than one button or more than one text box, the different instances can be disginguished by their different variable names.  

 Just instantiating a widget does not make it appear in the window.  The widgets are placed into a frame in one of two ways.  They can be *packed*, which basically means they are stuck into the frame in the order in which they are packed, or they can be assigned to a position in a *grid*.  The grid positions are referenced by their row and column and are relative.  Column 5 is to the right of column 3, but there doesn't have to be any column 0, 1, or 2, nor does there need to be a column 4.  The widths and heights of the columns and rows are determined by the size of the largest widget in that position.  A particular frame must either be populated by packing or by a grid -- you can't mix the two.

 Each widget has a number of attributes and methods.  Some attributes are standard across widgets, such as `.width`, and can be assigned when the widget is instantiated by including them as arguments.  However, generally you need to read the documentation about each particular widget to know how to set it up.  The documentation can be complex, so it is often helpful to find an example to see how the widget is used in actual practice. 

 Note that the TkInter interface is event-driven.  That means that while the program is running, it waits for an action on the part of the user (such as clicking a button) before executing code.  That requires associating functions with particular objects so that the function is triggered when something happens to the object.  The details of this are beyond the scope of this tutorial, so having an example template is helpful.

 The documentation for TkInter is at [this page](https://docs.python.org/3/library/tkinter.html)

# Challenge problems

1. A. **Nashville Schools info** Load the [Nashville schools data](https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv) directly from GitHub so that the user doesn't have to download the file.  Let the user enter the school name, then when the school is found, provide some information about the school that you think might be interesting, such as the percentage of students in that school that fall into particular categories. 

   B. **Case-insensitive school search** Modify your script so that it doesn't matter whether the user capitalizes correctly or not.  You will want to use the `.lower()` method on both the string that the user inputs and the string from the CSV file with which it's being compared.

   C. **Partial string school search** Modify the script in B so that the user doesn't have to enter the entire school name.  Use the `substring in string` boolean expression.  For example `'he' in 'hello'` evaluates to `True`, but `'hi' in 'hello'` evaluates to `False`.

2. A.  **Advanced cartoon checker** Use the [cartoons.csv](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoons.csv) file to create a script that allows the user to input all or part of the name of a cartoon character, then tell the user the company that created the character, and the character's nemesis.  You can decide whether you want to access the CSV file from a downloaded local file, or to retrieve it from GitHub when the script runs.
 
    **Program features**
    - Notice that the nemesis for most characters hasn't been entered or isn't known.  So you should handle that.
    - In order to allow the user to enter part of the character's name, use the `substring in string` boolean expression.  For example `'he' in 'hello'` evaluates to `True`, but `'hi' in 'hello'` evaluates to `False`.
    - In order to make the search case insensitive, apply the `.lower()` method to both the string that the user entered and the character name in the CSV file.
    - Handle gracefully the case where there are no matches.
    - Also handle the case where there is more than one match.

   B. **Cartoon checker with Wikidata search** The following script shows how to query the Wikidata API to learn more about items in its database.  

```python
import requests   # best library to manage HTTP transactions

endpointUrl = 'https://query.wikidata.org/sparql'
query = '''select distinct ?property ?value
where {
  <''' + 'http://www.wikidata.org/entity/Q3723661' + '''> ?propertyUri ?valueUri.
  ?valueUri <http://www.w3.org/2000/01/rdf-schema#label> ?value.
  ?genProp <http://wikiba.se/ontology#directClaim> ?propertyUri.
  ?genProp <http://www.w3.org/2000/01/rdf-schema#label> ?property.
  FILTER(substr(str(?propertyUri),1,36)="http://www.wikidata.org/prop/direct/")
  FILTER(LANG(?property) = "en")
  FILTER(LANG(?value) = "en")  
}'''

# The endpoint defaults to returning XML, so the Accept: header is required
r = requests.get(endpointUrl, params={'query' : query}, headers={'Accept' : 'application/json'})

# delete the next two lines after you see how it works
print(r.url)
print(r.text)

data = r.json()
statements = data['results']['bindings']
for statement in statements:
    print(statement['property']['value'] + ': ' + statement['value']['value'])
```

   Notice that the cartoons.csv data file has a column containing the Wikidata identifier for each character.  Combine the script in part A with this script to follow up the character search with a retrieval of other information about the character from Wikidata.  You can accomplish this by replacing the hard-coded `'http://www.wikidata.org/entity/Q3723661'` string in the query with a variable. Note that you will have to decide what to do in cases where there are no matches to the user input, or when there are multiple matches.

   C. **Cartoon checker with Wikidata search and GUI** Combine your answer in B with code from previous challenge problems that use a TkInter GUI.

   **Program features**
   - The user enters the character name in a text box.
   - The user clicks a button to run the check.
   - The user clicks another button to get more information about the character from Wikidata.
   - The results of the search show up in a scrolled text box.  
   - Can you figure out how to add a drop-down list to select the character to be looked up in Wikidata from among those that matched in the search?

[some notes about practical problem solving with Python](../hack/)


Revised 2019-04-11
