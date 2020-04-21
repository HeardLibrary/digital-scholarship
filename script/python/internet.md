---
permalink: /script/python/internet/
title: Data from the Internet
breadcrumb: Internet
---

Note: this is the seventh lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[prevous lesson on file input and output](../inout/)

[Brief evaluation survey](https://forms.gle/xXLpLt4YcdCVbRqu7)

The examples in this lesson can be run in a [Google Colaboratory notebook](https://colab.research.google.com/drive/1cvYq-d7csmuTxPGXrKCHdOe4ddbsPiMF). A Google account is required. Click on this link, then if necessary, click on "Open with Google Colaboratory". From the file menu select `Save a copy in Drive....` That will create a copy of the notebook that you can run, edit, and save. You may have to enable popups in order for the copy to open in a new tab. **Note: the `webbrowser.open_new_tab()` function will not work from the Colab notebook since its on a remote server. But you can still click on or loads the generated URL from the last homework problem. Alternatively, you can run the code locally using Thonny or a local Jupyter notebook.** 

If you are interested in using Jupyter notebooks, the examples are available in [this notebook](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/internet.ipynb).

The presentation for this lesson is [here](presentations/lesson7-internet.pdf)

Answers for last week's challenge problems:

1\. [Print school data](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/schools_a.py)

2\. [Advanced cartoon checker](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoon_checker_a.py)

# Requests library for the Internet

If we have data on our local computer in the form of a file, we can avoid hard-coding a large amount of information in our script, or having to do a lot of data entry when the script is run.  However, sometimes the information is already available online, so it would be nice to be able to make use of that information without requiring the user to download it.

There are features for using HTTP (Hypertext Transfer Protocol) in the Python standard library, but the best methods are part of the `requests` module.  (You may need to use PIP to install `requests` or in Thonny use "Manage packages..." under the Tools menu.)  Here is a simple example that makes an HTTP request and prints the response code using the `.status_code` method:

```python
import requests

r = requests.get('http://bioimages.vanderbilt.edu/baskauf/24319.htm')
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

When we open a file object, it's an iterable object and we can turn it into a reader or DictReader object.  However, the string that we get from the requests `.text` method is a string, which is not iterable.  However, as we saw at the end of the section on loading text from a file, we can turn a string containing newlines into a list using the `.split()` method, with `\n` as the argument.  Since a list is iterable, it can be passed into either the `.reader()` or `.DictReader()` methods.  Here is some code that reads in the Nashville school data and uses the `.reader()` function to create a list of lists serving as a table of the school data:

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

## JSON from APIs

To review JSON, [click here](../json/#JSON).

Since a lot of APIs on the web provide JSON through HTTP, the `requests` module has a method `.json()` that will directly turn JSON text from the body of an HTTP response into a Python data structure.  Essentially, it is like combining the requests module `.text()` method with the json module `.loads()` method in a single step.  

The [Global Biodiversity Information Facility (GBIF)](https://www.gbif.org/) allows users to search its records of over a billion organism occurrences via its API.  Usually, an API has a web page that explains how to make the HTTP request.  The directions for searching occurrence records are on [this page](https://www.gbif.org/developer/occurrence#search).  The search URL is constructed by concatenating the root endpoint URI (`http://api.gbif.org/v1`) with the search subpath (`/occurrence/search`) followed by a question mark, then the query string.  It's typical to query APIs this way (combining a complete endpoint URL with a query string, separated by a question mark).  

Usually, the values in query strings must be "URL-encoded" so that characters that aren't "safe" in the URL are escaped.  In our example, we are searching for occurrences recorded by "William A. Haber", so the spaces between the names muse be escaped with `+`.  

The requests module will automatically encode query string values of passed parameters and concatenate them with ampersands, the appropriate format when there are multiple parameters in the query string. The keys and values are included in the `.get()` method as a dictionary of keys and values to be encoded.  Here's an example:

```python
import requests
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

The value of the `results` key is an array that contains a list of result objects separated by commas.  Each of the reult objects has a long list of key:value pairs whose values are what we really are interested in.  Here's some code that will fetch the JSON, turn it into a Python structure, pull out the results, and show us the dictionaries in the list of results:

```python
import requests
url = 'http://api.gbif.org/v1/occurrence/search'
r = requests.get(url, params={'recordedBy' : 'William A. Haber'})
data = r.json()

print(data['results'][0])
```

To turn all of the results into valid JSON so we can look at it in a code editor, use the `json.dumps()` function:

```python
import requests
import json
url = 'http://api.gbif.org/v1/occurrence/search'
r = requests.get(url, params={'recordedBy' : 'William A. Haber'})
data = r.json()

print(json.dumps(data, indent = 2))
```

## Examining the structure of JSON from an API

Just printing out a string dump of JSON is incomprehensible, making it difficult to pull the data we want from the resulting Python data structure.  However, VS Code will "prettify" JSON for you.  Copy the JSON string and paste it into a new VS Code document.  Save the document with a `.json` file extension so that VS Code will know what kind of file it is.  Highlight all of the text, right click, then select `Format Document`.  

Another option is to go to the online tool [JSON Editor Online](https://jsoneditoronline.org/).  In that editor, you can paste the raw JSON on the left side, then click the rightward arrow in the middle.  The pane on the right allows you to expand and collapse the various nested arrays and objects of the JSON.  This is a great way to understand how the JSON is organized hierarchically.

## Pulling particular items from response JSON

To see more useful output, replace the print statement with this code

```python
resultsList = data['results']
for result in resultsList:
    try:
        print(result['species'] + ', date: ' + result['eventDate'])
        print('Observed at: ' + result['locality'] + ', ' + result['country'] + '\n')
    except:
        pass # do nothing if one of the keys isn't available (not a great solution)
```

Compare the "prettified" JSON to the code to understand how the nested parts of the JSON were accessed.

In this example, the API does not require any authentication.  Authentication is nearly always required to write to an API using an HTTP POST request and in a lot of cases it's also required for a read-only GET request as well.  This is to prevent abuse of the API.  

Sometimes an API will offer results in several possible formats, such as JSON or XML.  In such cases, one may need to send an `Accept:` header with the desired Internet Media Type (MIME type).  The MIME type for JSON is `application/json` and for XML is `text/xml`.  The request headers are sent as a dictionary, like this: 

```python
r = requests.get(uri, headers={'Accept' : 'application/json'})
```

**API etiquette:**

1. Do not try to scrape the entire contents of the API.  This is considered bad form.  If the site has open data, it will often provide a compressed dump of the entire dataset that you can download rather than making a massive API call.

2. Do not try to download a massive amount of data.  Usually the API will place a limit on the number of results that can be retrieved in a single call.  To retrive many results, there is usually a paging feature where you can retrive a certain number of results (like 20 or 100) in each request.  The pages are numbered so you can request them sequentially.

3. Do not hit the API repeatedly in a short period of time.  This is actually pretty easy to do with a script that can execute hundreds of operations per second.  Use the `.wait()` method from the time module to space your calls out.


# Homework

The answers are [at the end](#homework_answers).

1\. **Nashville Schools info from the Internet** Begin with the [answer to Homework #2.C.](./inout/#homework_answers) from last week.  (You also need to include the `import` statement and `readDict()` function from the answer to #2.A.)  

We are going to modify the `readDict()` function so that it gets its data from the Internet instead of a file on your computer.   The argument for the function will be the URL for the file instead of the file name, so you can change the parameter in the function definition from `filename` to `url`.  You will need to change the first two lines in function from a file open command to:

```
r = requests.get(url)
lineList = r.text.split('\n')
dictObject = csv.DictReader(lineList)
```

Don't forget to import the `requests` module at the top of your code.

Since the iterable object you are applying the `.DictReader()` method to is a list and not a file object, you also need to get rid of the line in the function that closes the file object. 

Now you can load the [Nashville schools data](https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv) directly from GitHub so that the user doesn't have to download the file.  Insert its URL: <https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv> as the argument of the `readDict()` function when you call it in the main script (instead of `Metro_Nashville_Schools.csv`).  The rest of the script should work the same way as it did when you were getting the data from a local file. 

If you did challenge problem #1 last week, you can use that code as a starting point instead of the answer to homework #2.C.

2\. **Where is the International Space Station now?**  There is a very simple API that will tell you the current latitude and longitude of the ISS.  The endpoint URL is:

```
http://api.open-notify.org/iss-now.json
```

There is no authentication required and JSON is returned by default, so you don't need to specify that as a request header. Here's the code you need to get the JSON:

```python
import requests

url = 'http://api.open-notify.org/iss-now.json'
r = requests.get(url)
data = r.json()
```

The form of the JSON stored in the `data` variable is like this:

```
{
'timestamp': 1555613804, 
'iss_position': {
    'latitude': '-48.2676', 
    'longitude': '103.0617'
    }, 
'message': 'success'
}
```

As you can see, the latitude and longitude that we want are key:value pairs that are nested as second-level values of the `iss_position` key.  So to refer to the latitude value, we would need to say:

```python
latitude = data['iss_position']['latitude']
```

Here's the assignment:

- make the API call to the endpoint and assign the latitude and longitude values (which will be strings) to appropriate variables.  
- Create a string that is the Google Maps URL for showing the position.  The form of the URL is:

```
http://www.google.com/maps/place/{latitude},{longitude}/@{latitude},{longitude},{zoom}z
```

where {latitude} is the string for the lattitude as a decimal number as a string, {longitude} is the string for the longitude as a decimal number as a string, and {zoom} is an integer number as a string representing the zoom level.  A zoom level of 4 is good to show the position on the global level.  Here's an example:

```
http://www.google.com/maps/place/-28.2692,15.5214/@-28.2692,15.5214,4z
```

The `webbrowser` module has methods that can open web pages on your default browser.  Import it at the top of your script.

You can then use this line of code to open the URL that you created in your script:

```python
webbrowser.open_new_tab(googleMapUrl)
```

This API is discussed in a nice tutorial [here](https://www.dataquest.io/blog/python-api-tutorial/).

# Challenge problems

1\. **Retrieving Tweets from the Twitter API**  The Twitter API requires authentication to retrieve data.  In order to generate the access token that you need in order to use the API, you need to have a Twitter developer account.  If you are in a Python class at Vanderbilt, your teacher will give you a temporary one during the class.  See [this page](../authenticate/) for information on setting up your account, getting the API keys you need to proceed with this problem, and for starter code.

- Modify the example authentication code so that the access token is saved in a file.
- Modify the example API code so that the access token is retrieved from the file above.
- Allow the user to enter the Twitter handle (username) and number of Tweets to be retrieved.
- Hack the [latte maker](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge2/latte_maker.py) script, or some other script that uses TkInter to make a graphical interface that allows the user to put the handle and number of tweets in text entry boxes, executes when you click a button, and displays the tweets in a scrolling text box.

2\. A.  **Advanced cartoon checker (Internet)** Start with the [answer to last week's challenge problem 2](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoon_checker_a.py).  Modify lines 3 and 4 so that you get the file from the cartoons.csv file online at GitHub instead of from the file downloaded on your local computer.  You can see an example in the answer to homework #2. Don't forget to get rid of the close method in line 8, since you don't need it.  The URL to retrieve the raw CSV file is:

```
https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoons.csv
```
Answer for [Advanced cartoon checker (Internet)](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoon_checker_a1.py)

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

Answer for [Cartoon checker with Wikidata search](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoon_checker_b.py)

C. **Super cartoon checker with Wikidata search and GUI** Combine your answer in B with code from previous challenge problems that use a TkInter GUI.  See [this page](../tkinter/) for details about TkInter.
Answer for [Super cartoon checker with Wikidata search and GUI ](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoon_checker_c.py)


**Program features**
   - The user enters the character name in a text box.
   - The user clicks a button to run the check.
   - The user clicks another button to get more information about the character from Wikidata.
   - The results of the search show up in a scrolled text box.  
   - Can you figure out how to add a drop-down list to select the character to be looked up in Wikidata from among those that matched in the search?

## Homework answers

1\. **Nashville Schools info from the Internet**

```python
import csv
import requests

def readDict(url):
    r = requests.get(url)
    lineList = r.text.split('\n')
    dictObject = csv.DictReader(lineList)
    array = []
    for row in dictObject:
        array.append(row)
    return array

schoolData = readDict('https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv')
mySchool = input('What school do you want to know about? ')

for school in schoolData:
    if mySchool.lower() in school['School Name'].lower():
        print('School:', school['School Name'])
        print('Level:', school['School Level'])
        print('Zip code:', school['Zip Code'])
        print()
```

2\. **Where is the International Space Station now?** 

```python
import requests
import webbrowser

url = 'http://api.open-notify.org/iss-now.json'
r = requests.get(url)
data = r.json()
latitude = data['iss_position']['latitude']
longitude = data['iss_position']['longitude']
zoom = '4'
googleMapUrl = 'http://www.google.com/maps/place/'+latitude+','+longitude+'/@'+latitude+','+longitude+','+zoom+'z'
print(googleMapUrl)  # not necessary to print this, but useful for debugging
webbrowser.open_new_tab(googleMapUrl)
```

[some notes about practical problem solving with Python](../hack/)

----
Revised 2020-04-21
