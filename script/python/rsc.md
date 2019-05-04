---
permalink: /script/python/rsc/
title: RSC API project 
breadcrumb: API project
---

# Royal Society of Chemistry API project

## Preliminaries

Go to the RSC Developers Portal <https://developer.rsc.org/home> and register to get an account.  The account is free for up to 1000 API calls per month.

Log into your account (if necessary) and click on the `My Keys` tab.  Click on `Add a new Key`.  Copy the Consumer Key and paste it somewhere where you can find it.

## Part 1: Present choices

**Goal:** to present the user with options for the output that they want to get from the API.

**Specifics:** 
- Print the options to choose from.  "f" for formula, "w" for molecular mass, "c" for common name, and "3" for "3D structure" 
- The user types between 1 and 4 of these characters, then presses Enter.
- Print back to the user the option string they typed in.  

## Part 2: Check whether the user typed anything

**Goal:** to end the program if the user didn't enter anything

**Specifics:**
- Start with the code above.  If the user pressed Enter without typing anything the value assigned to the string variable by the input function will be an empty string (represented by `''`).  
- Use an IF statement to check for the empty string.  If they entered the empty string then print an error message and execute the `quit()` function. 
- If they entered a string, then continue to the next part of the program and ask the user for the common name of the compound they want to search for.  Again, check whether they typed anything or not, and give an error message and quit the program if they didn't type anything.  If they did enter a compound, print both the compound they entered and the option string containing their choices.  

## Part 3: Create the list of fields to return

**Goal:** to create a list of fields to return based on the option letters the user entered.

**Specifics:** 
- Create an empty list to hold the list of fields to get.
- Create a list of options.  Each option is a string that is one of the four possible letters they could pick. The list will be like this:

```python
optionList = ['f', 'w', 'c', '3']
```

- Create a list of strings for the record fields to be retrieved.  They need to be in the same order as the list of options.  You can see all of the possible record fields on [this page](https://developer.rsc.org/compounds-v1/apis/get/records/%7BrecordId%7D/details).  For the four choices we gave the user, the corresponding fields will be like this:

```python
fieldList = ['Formula', 'MolecularWeight', 'CommonName', 'Mol3D']
```

- Iterate through the range from 0 to the length of the option list.  That will look like this:

```python
for index in range(0,len(optionList)):
```

- For each index you iterate through, check whether the option for that iteration is in the option string that the user typed in.  Here's how you do the test:

```python
if optionList[index] in optionString:
```

- If the option string is in the option choice string, then add the appropriate field string to the list of fields to get.  Use the `.append()` method to add the field string to the list.
- Print the list that you created.

## Part 4: Create the JSON to send to the API for the name search

**Goal:** to create a dictionary in the form of the required JSON request

**Specifics:** 
- Go to <https://developer.rsc.org/compounds-v1/apis/post/filter/name>
- Paste your Consumer key in the "apikey" box.
- Edit the `Request Body` box so that the name of a compound is in the quotes for the value of the "name" key.  For example, you could use "benzene" as the value.
- Click the "Send this request" button.  If the request body was valid, you should see an HTTP response code of "200 OK" below the button.  
- The response should be shown below as JSON containing a single key:value pair with `queryId` as the key.  Leave this window open so that we can come back to it later to get the queryId value.
- In your code, set the variable `dataDict` equal to the dictionary represented by the JSON Request body.  That is, don't make the JSON a string by putting it in quotes -- just set the variable equal to the curly brackets. It's fine for the dictionary to span several lines.
- Test that your dictionary is OK by printing the value of the `queryId` key.
- After you verify that your dictionary is fine, replace the literal string that you used (e.g. "benzene") with the variable that you created in part 2 to hold the common name of the compound to be searched for.

## Part 5: Sending the first search request (POST) to the API

**Goal:** to use our API key to send a search request to the API

**Specifics:**
- At the top of your code, import the `requests` module.
- Find your API key from where you saved it and assign it to the variable `key`.
- Copy the Resource URL from the [search by name](https://developer.rsc.org/compounds-v1/apis/post/filter/name) page and assign it to the variable `searchUrl`.
- Create a request object by calling the `.post()` function from the `requests` module.  The format is similar to the `.get()` function we saw in the lesson.  Here's what it should look like:

```python
r = requests.post(searchUrl, headers={'apikey' : key}, json = dataDict)
```

The authorization happens because your API key is being sent as an HTTP request header.  In an HTTP POST request, data is sent to the API endpoint in the request body.  If the data are in the form of JSON (as ours are), the `requests` module accomplishes that by passing a dictionary as the value of a `json` argument.  
- Turn the response JSON text into a Python data structure using the `.json()` method of the request object.
- Print the data structure and compare it to what you got when you used the web page to test your API key and dataDict in Part 4.  The response should include the "queryId", a long random UUID. It won't be the same UUID because it's a new search. 
- Using what you know about accessing values in dictionaries, assign the value of `queryId` to the variable `queryIdString`.  

## Part 6: Sending the second request (GET) to retrieve the search results

**Goal:** to use the search ID number to retrieve the search results from the API

**Specifics:**
- [This page](https://developer.rsc.org/compounds-v1/apis/get/filter/%7BqueryId%7D/results) shows how to retrieve the results of a query from the API.  The query ID number you got in the last step has to be inserted into the Resource URL as shown on the page.  You can test this by pasting the query ID number you got from the last step into the box, then clicking the `Send this request` button (your key should be pre-filled in the `apikey` box).  
- In an HTTP GET request, there is no request body.  Rather, all of the information about the request is embedded in the URL.  In this case, the request UUID identifier has to be inserted into the proper spot in the URL.  Use copy and paste from the API instructions page to concatenate the first part of the Resource URL, the queryIdNumber variable, and the last part of the resource URL.  Assign the concatenated string to the variable `resultsGetUrl`.  
- The last example of the [JSON from APIs](../internet/#json-from-apis) section shows how to send an HTTP GET request with a request header.  The header you need to send is the same as you did for the POST request in the last step.  It should look like this:

```python
r = requests.get(resultsGetUrl, headers={'apikey' : key})
```
- As you did in the last part, convert the response JSON to a Python data structure and print it.  
- The second "Try this" exercise in the [JSON and Python](../json/#json-and-python) section worked through how to pull the "ChemSpider" compound ID number out of the response JSON.  Assign the ID number to the variable `compoundIdNumber`.

## Part 7: Sending the third request (GET) to retrieve the compound data fields

**Goal:** to use the compound ChemSpider ID number to get the data the user wants

**Specifics:** 
- Earlier we went to the [record details](https://developer.rsc.org/compounds-v1/apis/get/records/%7BrecordId%7D/details) page to see what data fields were available from the API for a compound.  Go back to that page to see how to set up the Resource URL to retrieve the fields. You will need to take the `compoundIdNumber` from the last step and turn it into a string (using the `str(compoundIdNumber)` function) before inserting it in the middle of the URL.  Assign the URL you construct to the variable `detailsGetUrl`.
- This request is a little more complicated than the last one because we need to send query parameters that indicate what fields the user wants.  The information on the page says that the field names should be concatenated with commas between them, then passed as the value of a `fields` key. There is a very easy way to do concatenate the names using the `.join()` method.  If you want to join the strings in a list variable called `fieldGetList` using commas, you can use:

```python
joinedList = ','.join(fieldGetList)
```

- The GET request will be like this:

```python
r = requests.get(detailsGetUrl, headers={'apikey' : key}, params={'fields': fieldGetList})
```

- After you get the results, convert the response JSON again and print it.

## Part 8: Print the final results

**Goal:** to show the users the final results retrieved from the API

**Specifics:**
- The number of fields we need to display will depend on which ones the user requested.  However, we know that because we saved the field names in the list `fieldGetList`.  So we can iterate through this list and print each item.
- The first "Try this" exercise in the [JSON and Python](../json/#json-and-python) section dealt with pulling data out of the JSON results from a fields details dictionary.  We can just use a for loop to iterate through each result.  The iterator is the key name and we can use the iterator key to specify the value of the result.  For example, if the results dictionary is the variable `results` and we iterate like this:

```python
for item in results:
```

Then each `item` iterator is the key for the dictionary item and `results[item]` is the value for the dictionary item.
- When everything is working the way you want, you can delete or comment out all of the unnecessary intermediate print statements.
