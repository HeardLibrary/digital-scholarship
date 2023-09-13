---
permalink: /lod/wikibase/sdoc/
title: Structured Data on Commons
breadcrumb: sdoc
---

[back to the wikibase model](../)

# Structured Data on Commons as a wikibase instance

[Structured Data on Commons](https://commons.wikimedia.org/wiki/Commons:Structured_data) (SDoC) is an attempt to overcome some of the deficiencies of the template-based system by which [Wikimedia Commons](https://commons.wikimedia.org/) has operated for years. Using SDoC, metadata are recorded and exposed in a more systematic way that allows for better search. What some people may not know is that SDoC is implemented as a wikibase. So the generic tools and graph model that apply to all wikibases also apply to SDoC.

## Some basics

Statements in SDoC are formed in the same manner as Wikidata. However, a key difference is that the subjects of statements (Commons media files) are not generally items in the `wd:` namespace with Q IDs. Instead, Commons media files use the namespace `sdc:`, which is an abbreviation for `https://commons.wikimedia.org/entity/`. The identifiers for Commons media files begin with "M" instead of "Q", so they are called "M IDs", instead of "Q IDs". 

The properties used in SDoC are taken entirely from Wikidata and have identical identifiers starting with "P". So for example, "depicts" is `P180` just as it is in Wikidata. 

SDoC uses the wikibase model, so the relationships between subject resources, statement instances, qualifiers, and values are the same as in Wikidata or any other wikibase. References are not used.

The SDoC uses the multilingual label feature of the wikibase model and these appear as "Captions" in the File information section of a media page. Descriptions and aliases are not used.

## SDoC properties and statements

SDoC statements can be made using the `Structured data` tab of the information page for any Commons media file. There are two properties that have special importance and that are frequently used to make SDoC statements: "main subject" (`P921`) and "depicts" (`P180`). In the case of exact representations of two dimensional artworks, "digital representation of" (`P6243`) also has special significance described in the [Visual artworks modeling page](https://commons.wikimedia.org/wiki/Commons:Structured_data/Modeling/Visual_artworks).  "depicts" is one one of the most important properties because it feeds the search tools. For more information see the [Depiction modeling page](https://commons.wikimedia.org/wiki/Commons:Structured_data/Modeling/Depiction). 

In some cases, SDoC statements will be added automatically after a media item is created. If an image contains EXIF metadata, they may be used to automatically generate statements about camera model, date created, etc. When a license template is used, the copyright and licensing statements will also be generated automatically.

## Commons identifiers

Commons uses a dizzying array of identifiers for its media files. There are four:

1. The most basic one is the media filename, unencoded and with file extension.

2.  The Commons web page URL is formed from the media filename by prepending a subpath and "File:", replacing spaces in the filename with _, and URL-encoding the file name string. The reverse conversion may be lossy because it assumes that underscores should be turned into spaces and the filename might actually contain underscores.

3. The Wikidata IRI identifier for the image is formed from the media filename by URL-encoding it and prepending a subpath and "Special:FilePath/". The reverse conversion is lossless since it simply reverse URL-encodes the local name part of the IRI.

4. Each media page is also identified by an M ID, which is the Commons equivalent of a Q ID. Since structured data on Commons is based on a Wikibase instance, the M ID is used when writing structured data to the API.

The [appendix at the bottom of this page](#appendix-code-to-convert-among-commons-identifiers) contains some Python code that can be used to convert among these forms and to look up the M ID using the Commons API if the media filename is known.

# Writing data programatically using VanderBot

Unlike in Wikidata, users do not create media file items directly in the SDoC wikibase. Instead, the items are created and M IDs are assigned when the media files are uploaded. Thus it is important to be able to find out the M IDs for media items if you want to use the Commons API to upload SDoC statements or edit captions (i.e. labels). There are [several methods for finding M IDs](https://commons.wikimedia.org/wiki/Commons:SPARQL_query_service#Find_M_IDs). The M IDs are also recorded if you make uploads using the [CommonsTool](https://github.com/HeardLibrary/linked-data/blob/master/commonsbot/README.md) Python script (described in [this blog post](https://baskauf.blogspot.com/2022/09/commonstool-script-for-uploading-art.html)). 

Since SDoC is just another wikibase, the [general instructions for writing to wikibases](../load/) with the VanderBot script apply. In this example, we will see how to write depicts statements using VanderBot. Creating other statements would be similar.

Credentials are valid across Wikimedia APIs, so if you have already created credentials to use with the Wikidata API, they can be used here. However, the [credentials file](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/wikibase/api/wikibase_credentials.txt) must have `https://commons.wikimedia.org` as the value for `endpointUrl`. 

Because of the way VanderBot works, each interaction with the API can only involve a single property. So there can only be one column in the CSV table for any particular property. However, if you want to write multiple values of a property to the same item, you can write each of them in a separate API call by having several rows in the CSV with the same item identifier. In [this example CSV](https://github.com/HeardLibrary/linked-data/blob/master/commonsbot/depicts/depicts.csv), there are four rows with the same M ID (placed in the `qid` column since the SDoC M ID is analogous to the Wikidata Q ID). Each value in the `depicts` column is different -- three of them have already been written since they have identifiers in the `depicts_uuid` column. The `label_en` column will be ignored if I run VanderBot with the `--update` labels option at its default, `suppress`. The only purpose of that column is to make it easier to know what media item the M ID denotes. The `depicts_label` column has been added as a mnemonic for humans to remind them what the Q ID in the `depicts` column stands for. 

The [config.yaml](https://github.com/HeardLibrary/linked-data/blob/master/commonsbot/depicts/config.yaml) file that maps the columns in this table shows how I set up the `depicts_label` column as a column to ignore. The value of `manage_descriptions` is set to `false` because descriptions aren't used in SDoC, so there's no point in having a column for that. Before running VanderBot, I need would need to run the [ConvertToMetadataSchema](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/convert-config.md#details-of-script-to-convert-configuration-data-to-metadata-description-and-csv-files) script to generate the appropriate [csv-metadata.json](https://github.com/HeardLibrary/linked-data/blob/master/commonsbot/depicts/csv-metadata.json) file needed by VanderBot. That script will also generate the header row for the CSV file, which I would need if I didn't already have the [depicts.csv](https://github.com/HeardLibrary/linked-data/blob/master/commonsbot/depicts/depicts.csv) file. 

If I visit the [information page](https://commons.wikimedia.org/wiki/File:Madonna_and_Child_with_St._Elizabeth_and_infant_John_the_Baptist_-_Vanderbilt_Fine_Arts_Gallery_-_1979.0321P_copy.tif) for the media file denoted by `M113161207` and click on the `Structured data` tab, I can see the depicts statements that I created with the script. Note: if you know the M ID of a media file, you can load its information page by appending its M ID to the string 'http://commons.wikimedia.org/entity/`, then loading it into your browser, like this: <http://commons.wikimedia.org/entity/M113161207>.

# Querying

As with the Wikidata Query Service (WDQS), you can make queries of Structured Data on Commons using the Wikimedia Commons Query Service (WCQS, currently in beta) graphical user interface at <https://commons-query.wikimedia.org/>. Unlike the WDQS, you must be logged in and authenticated in order to make queries. For more information about the WCQS, visit the [Commons SPARQL query service](https://commons.wikimedia.org/wiki/Commons:SPARQL_query_service) landing page, which also has a link that takes you to the WCQS graphical user interface.

To test the Query Service, we can use this query:

```
select distinct ?depicts where {
  sdc:M113161207 wdt:P180 ?depicts.
  }
```

It finds the Q IDs of items used as values of the `P180` (depicts) statements for the media file in the previous section. We won't go into detail here about how to do more complex queries, but there is a [page with many example queries](https://commons.wikimedia.org/wiki/Commons:SPARQL_query_service/queries/examples) that range from simple to extremely complex.

## Accessing the Wikimedia Commons Query Service programatically using Python

Since the Wikimedia Commons Query Service (WCQS) is querying a wikibase, everything that was covered in the [Querying programatically using Python](../sparql/#querying-programatically-using-python) section of the [SPARQL queries to a generic wikibase](../sparql/) lesson applies here as well. There is, however, a major idiosyncrasy of the WCQS that makes it more challenging to use than the Query Services of other wikibase. Unlike the Wikidata Query Service and wikibase.cloud Query Services, the WCQS requires authentication. 

Currently (2023-02-12) the authentication method is a bit of a kludge. In order to use it via HTTP, you need to have an authentication cookie. The method used to get the cookie value is described at the [How do I get a wcqsOauth cookie? FAQ](https://commons.wikimedia.org/wiki/Commons:SPARQL_query_service/API_endpoint#How_do_I_get_a_wcqsOauth_cookie?). After completing the steps described there, you should have a very long string consisting of two long hexidecimal numbers separated by a period, like this:

```
b8d15147d1cfed1129f1f7f38e2acb03.9f8b5d50d1861bf2198ead63ff345c4a94986c61
```

When you get this string, save it as the only text in a plain text file with no newline (hard return) at the end of the line. You can use a plain text editor like TextEdit on Mac or Notepad on Windows to create the file. Call the file `wcqs_oauth_cookie.txt` and save it in your home directory. 

**Important note:** This cookie allows any user who has it to query under your user account! It will remain active until you [revoke access to it](https://commons.wikimedia.org/wiki/Commons:SPARQL_query_service/API_endpoint#How_long_is_the_wcqsOauth_cookie_valid?). So do NOT save this file in some location that will be publicly exposed, such as a GitHub repository. The example code assumes that you have saved it in your home directory. You can save it somewhere else and use keyword arguments in the script to indicate that location. But keep this warning in mind if you choose a different location.

We will use a variation on the `init_session()` function from the [example Python script](https://commons.wikimedia.org/wiki/Commons:SPARQL_query_service/API_endpoint#Python) along with the [sparqler class](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/wikidata/sparqler.py) described in [Querying programatically using Python](../sparql/#querying-programatically-using-python). 

**Parts of the code explained**

Import statements and sparqler class (requires previous installation of the `requests` library).

```
import requests
import datetime
import time
import json
from http.cookiejar import Cookie
from urllib.parse import urlparse
from pathlib import Path

class Sparqler:
(PASTE THE __init__ SECTION AND query METHOD HERE)
```

Session initialization code modified from the example Python script from the Commons wiki.

```
def init_session(endpoint, token):
    domain = urlparse(endpoint).netloc
    session = requests.Session()
    session.cookies.set_cookie(Cookie(0, 'wcqsOauth', token, None, False, domain, False, False, '/', True,
        False, None, True, None, None, {}))
    return session
```

Code to retrieve the cookie from the file in your home directory.

```
def retrieve_cookie_string(path='wcqs_oauth_cookie.txt', relative_to_home=True):
    if relative_to_home:
        home = str(Path.home()) # gets path to home directory for both Mac and Win
        full_credentials_path = home + '/' + path
    else:
        full_credentials_path = path
    
    # Retrieve credentials from local file.
    with open(full_credentials_path, 'rt') as file_object:
        cookie_string = file_object.read()
    return cookie_string
```

Initialize a session by authorizing with the cookie, then create a Sparqler object by passing in the session.

```
user_agent = 'TestAgent/0.1 (mailto:username@email.com)' # put your own script name and email address here
endpoint_url = 'https://commons-query.wikimedia.org/sparql'
session = init_session(endpoint_url, retrieve_cookie_string())
wcqs = Sparqler(useragent=user_agent, endpoint=endpoint_url, session=session)
```

Create the query string to pass to the WCQS. Note: any prefixes that you use MUST be defined in the prolog. Unlike the Wikidata Query Service, you can't currently leave this part out. Other than the `sdc:` namespace, the other possible namespace abbreviations are listed [here](../sparql/#namespace-prolog). (You must substitute the Wikidata subdomain `www.wikidata.org` for the placeholder domain name `wikibase.svc` given in the namespace abbreviation list.)

```
query_string = '''PREFIX sdc: <https://commons.wikimedia.org/entity/>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
select distinct ?depicts where {
  sdc:M113161207 wdt:P180 ?depicts.
  }'''
```

Apply the `.query()` method to the `wdqs` object you created, and print the resulting data.

```
data = wcqs.query(query_string)
print(json.dumps(data, indent=2))
```

The full script can be downloaded from [here](https://github.com/HeardLibrary/linked-data/blob/master/commonsbot/wcqs/wcqs_query.py).

**Sample output**

```
(base) baskausj@LIBD0KAML85 wcqs % python3 wcqs_query.py 
[
  {
    "depicts": {
      "type": "uri",
      "value": "http://www.wikidata.org/entity/Q103304813"
    }
  },
  {
    "depicts": {
      "type": "uri",
      "value": "http://www.wikidata.org/entity/Q302"
    }
  },
  {
    "depicts": {
      "type": "uri",
      "value": "http://www.wikidata.org/entity/Q345"
    }
  },
  {
    "depicts": {
      "type": "uri",
      "value": "http://www.wikidata.org/entity/Q40662"
    }
  }
]
(base) baskausj@LIBD0KAML85 wcqs % 
```

----

[back to the wikibase model](../)

[loading data into a wikibase](../load/)

[deleting statements and references](../delete/)

[creating properties using a script](../properties/)

[querying a wikibase with SPARQL](../sparql/)

----

# Appendix: code to convert among Commons identifiers

To use the first four functions, you need to import `urllib.parse`. The last function requires importing the `requests` module, which may need to be installed using PIP on some systems.

## Filename to Commons Wikidata URL

```
def filename_to_commons_url(filename):
    """Convert a raw file name to a Wikidata IRI identifier."""
    encoded_filename = urllib.parse.quote(filename)
    url = commons_prefix + encoded_filename
    return url
```

## Commons Wikidata URL to filename 

```
def commons_url_to_filename(url):
    """Convert a Wikidata IRI identifier to an unencoded file name.
    
    Note
    ----
    The form of the URL is: http://commons.wikimedia.org/wiki/Special:FilePath/Castle%20De%20Haar%20%281892-1913%29%20-%20360%C2%B0%20Panorama%20of%20Castle%20%26%20Castle%20Grounds.jpg
    """
    string = url.split(commons_prefix)[1] # get local name file part of URL
    filename = urllib.parse.unquote(string) # reverse URL-encode the string
    return filename
```

## Filename to Commons web page URL

```
def filename_to_commons_page_url(filename):
    """Convert a raw file name to a Commons web page URL."""
    filename = filename.replace(' ', '_')
    encoded_filename = urllib.parse.quote(filename)
    url = commons_page_prefix + encoded_filename
    url = url.replace('%28', '(').replace('%29', ')').replace('%2C', ',')
    return url
```

## Commons web page URL to filename (potentially lossy)

```
def commons_page_url_to_filename(url):
    """Convert a Commons web page URL to a raw file name.
    
    Note
    ----
    The form of the URL is: https://commons.wikimedia.org/wiki/File:Castle_De_Haar_(1892-1913)_-_360%C2%B0_Panorama_of_Castle_%26_Castle_Grounds.jpg
    This conversion may be lossy if the file name contains underscores rather than spaces, since this function assumes that all underscores should be changed to spaces.
    """
    string = url.split(commons_page_prefix)[1] # get local name file part of URL
    string = string.replace('_', ' ')
    filename = urllib.parse.unquote(string) # reverse URL-encode the string
    return filename
```

## Use media filename to look up M ID via the Commons API

Because this function performs an HTTP GET and not a POST, authentication with the API is not required. Based on the [Wikimedia User-Agent policy](https://meta.wikimedia.org/wiki/User-Agent_policy), API users must supply a User-Agent header for all requests. This may not be enforced for a small number of GET requests, but if this function is used for more than testing, you should modify the value of `user_agent` to provide a tool name and your email address.

This script does not perform a time-consuming operation with the API (in contrast to a media file upload). So if it is used repeatedly without intervening operations that take a significant amount of time, you should probably add a significant delay between API calls (currently the delay is set for 0.1 seconds). Otherwise you may be blocked. Alternatively, I think you could modify the params to look up multiple filenames in a single API call.

```
import requests
from time import sleep

def get_commons_image_pageid(image_filename):
    """Look up the Commons image page ID ("M ID") using the image file name.
    
    Note
    ----
    The wbeditentity_upload function (which writes to a Wikibase API) needs the M ID, 
    the structured data on Commons equivalent of a Q ID. 
    """
    user_agent = 'tool_name/version (mailto:account@provider.org)'

    # get metadata for a photo from the file name
    params = {
        'action': 'query',
        'format': 'json',
        'titles': 'File:' + image_filename,
        'prop': 'info'
    }

    response = requests.get('https://commons.wikimedia.org/w/api.php', params=params, headers={'User-Agent': user_agent})
    data = response.json()
    #print(json.dumps(data, indent=2))
    page_dict = data['query']['pages'] # this value is a dict that has the page IDs as keys
    page_id_list = list(page_dict.keys()) # the result of the .keys() method is a "dict_keys" object, so coerce to a list
    page_id = page_id_list[0] # info on only one page was requested, so get item 0
    #print('Page ID:',page_id)
    
    # NOTE: appears to return '-1' when it can't find the page.
    
    sleep(0.1)

    return page_id
```

----
Revised 2023-02-16
