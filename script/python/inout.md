---
permalink: /script/python/inout/
title: Input and output
breadcrumb: Input/Output
---

Note: this is the fifth lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[prevous lesson on data structures](../structures/)

Answers for last week's challenge problems:

1\.a. [Print 5 cards](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge3/print_cards.py)

b\. [Create hand list](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge3/make_hand.py)

2\. [Add 100 numbers](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge3/add_numbers.py)

3\.a. [Reverse Frost poem words](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge3/reverse_frost_words.py)

b\. [Reverse entire Frost poem](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge3/reverse_frost_poem.py)

# Input and Output

Although you can have a lot of fun playihg around with Python by just hard-coding information within the script, the ability to let Python work hard for you depends a lot on having ways to get large amounts of information in and out of the script.  We have already seen a simple way to get data into a script from a user: the `input()` function.  The `input()` function stops the execution of the program and waits for the user to enter some information.  We have also seen an example of a simple way to get data out of a script: the `print()` function, which displays something on the screen in the Shell window.  Here's an example of how we can use the two functions:

```python
yourName = input("What's your name? ")
response = 'Hey there, ' + yourName + '! How are you doing?'
print(response)
```

These information transferred by functions is *volatile* -- once the script executes, it's gone.  Unless we like re-entering information over and over, it's good to use other mechanisms that use information that persists between computing sessions.

# File input/output

A great way to save your work and be able to access it again is to use a file.  There are various file types, but for this lesson, we will focus on text files (files whose bytes represent text characters).  These are files that you can open, view, edit, and save in a text editor.

One issue that should be mentioned at this point is *character encoding*.  In an earlier lesson we learned about [how the Unicode system is used by Python](../structures/#escape-sequences) for representing all kinds of characters as numbers.  Character encoding is the way that these numbers are stored in a text file.  The most universally used character encoding is called [UTF-8](https://en.wikipedia.org/wiki/UTF-8).  UTF-8 is a clever way to store over a million different characters and symbols using between one and four bytes.  It is also backwardly compatible with one of the early character encoding systems, [ASCII](https://en.wikipedia.org/wiki/ASCII), which uses only a single byte to represent a character.  So all files whose characters are encoded in ASCII are also encoded in UTF-8.  UTF-8 has been around since 1993, but there are still some old files and applications that don't use it.  But you should always use UTF-8 as your character encoding whenever possible since it allows text in nearly any language to be represented.

## Writing to a text file

Writing to a text file involves instantiating a file object, then performing some operation that involves writing to the file object, then closing the file.  Here is a simple example:

```python
someText = "Goin' into the file!"
fileObject = open('datafile.txt', 'wt', encoding='utf-8')
fileObject.write(someText)
fileObject.close()
```

Notes:
- The arguments of the open() function are strings and can be replaced with variables rather than literals if you want.
- In the second argument, "wt", the "w" stands for "write" and the "t" stands for "text".
- The last argument specifies the character encoding.  It can be omitted, since the default encoding in Python3 is UTF-8, but it's clear if you include it.
- The file write isn't necessarily completed untill you close the file with the `close()` function. 
- Because the file name in the first argument doesn't specify any path, it will default to the directory from which the script is being run.

If you run this script, you won't see anything in the Shell.  But if you go to the directory from which you ran the script, you should see the `datafile.txt` file.  You can open it withe a text editor and see that it includes the text that was in the `someText` variable.

There are several other options for doing the writing to the file besides the `.write()` method. Our old friend the `print()` function can actually print to a file with the appropriate arguments.  It puts a space between each argument and puts a newline character at the end of the arguments.  Compare the output file in these two examples:

**Output to file using .write()**

```python
firstLine = "Goin' into the file!"
secondLine = "I'm there, too."
thirdLine = "Wrapping it up!"
fileObject = open('datafile.txt', 'wt', encoding='utf-8')
fileObject.write(firstLine)
fileObject.write(secondLine)
fileObject.write(thirdLine)
fileObject.close()
```

**Output to file using print()**

```python
firstLine = "Goin' into the file!"
secondLine = "I'm there, too."
thirdLine = "Wrapping it up!"
fileObject = open('datafile.txt', 'wt', encoding='utf-8')
print(firstLine, file=fileObject)
print(secondLine, file=fileObject)
print(thirdLine, file=fileObject)
fileObject.close()
```

Note that you if you want to have newlines separating lines that you've output to a file with the `.write()` method, you can just add it to the end of the output string, like this:

```python
fileObject.write(firstLine + '\n')
```

There is also a short-cut to achieve file output.  This option automatically closes the file when the following code block is finished.  Here is an example that achieves exactly the result as the first example in this section:

```python
someText = "Goin' into the file!"
with open('datafile.txt', 'wt', encoding='utf-8') as fileObject:
    fileObject.write(someText)
```

## Reading from a text file

Reading from a text file involves similar steps as writing.  A file object is opened, an operation is performed that reads from the file, then the file is closed.  Here's an example:

```python
fileObject = open('datafile.txt', 'rt', encoding='utf-8')
someText = fileObject.read()
fileObject.close()
print(someText)
```

Notes:
- As with opening a file to write, opening a file to read defaults in Python 3 to UTF-8, so including the encoding parameter is optional.
- In the second argument, "rt", the "r" stands for "read" and the "t" stands for "text".
- The `.read()` method doesn't take any arguments.

In this example, all lines in the input file will be read in as a single string.  So if the datafile.txt file looks like this:

```
First line
Second line
Third line
```

then `someText` will be `First line\nSecond line\nThird line`.  

File objects are iterable based on newlines present in the file, so we can actually just use a `for` loop to read in the lines one at a time. Here's an example:

```python
fileObject = open('datafile.txt', 'rt', encoding='utf-8')
for oneLine in fileObject:
    print(oneLine)
fileObject.close()
```

If we wanted to put each of the line strings into a list, we could do this:

```python
lineList = []
fileObject = open('datafile.txt', 'rt', encoding='utf-8')
for oneLine in fileObject:
    lineList.append(oneLine)
fileObject.close()
print(lineList)
```

If you run this script, you'll notice that each line comes in with a newline (`\n`) character stuck onto the end of it.  An easy way to get rid of it is to use the `.strip()` method, which removes any leading or trailing whitespace.  Here's the append line of the code with `.strip()` implemented:

```python
    lineList.append(oneLine.strip())
```

The `.readlines()` method is a shortcut that reads in all of the lines in a file directly into a list without setting up a loop.  However, it has the problem of trailing newlines.  Here's an example of how to use it:

```python
fileObject = open('datafile.txt', 'rt', encoding='utf-8')
lineList = fileObject.readlines()
fileObject.close()
print(lineList)
```

The same `with` shortcut we saw for writing to a file can be used here as well:

```python
with open('datafile.txt', 'rt', encoding='utf-8') as fileObject:
    lineList = fileObject.readlines()
print(lineList)
```

With this shortcut, you can read in all of the lines of a file in two lines of code (if you are OK with the trailing newlines at the end of each line).

Another way to load lines from a file into a list is to read the entire file as a single string, then split the string.  This can also be done with only two lines of code:

```python
with open('datafile.txt', 'rt', encoding='utf-8') as fileObject:
    lineList = fileObject.read().split('\n')
print(lineList)
```

If you try creating a multiline text file in a text editor, then open it with the last example script, you should notice that it makes a difference whether you add a hard return (i.e. a newline) after the last line of text.  If you did, you will create a list like this:

```
['First line', 'Second line', 'Third line', '']
```

where the last string in the list is an empty string.  That's because it considers the final newline in the file to separate the third line from an empty string. To avoid the empty string, you need to remove the final newline in the file.  This problem does not happen in the previous ways of reading in lines, which are insensitive to a trailing newline.  So they are probably "safer".

# CSV reader/writer

## CSV files

An extremely common way to store tabular data is in *fielded text files*, commonly called *"CSV"* (comma separated values) files.  "Fielded text" is probably a better term, because the fields in the text aren't always delimited byt commas.  It is also fairly common for fields to be separated by tabs or some other characters.  But it's still common to call them "CSV" files regardless of the delimiter.

A CSV file is simply a text file where the rows are on separate lines terminated by newlines, and the fields (i.e. columns) within the row are separated by commas.  Here's an example:

```
given_name,family_name,username,student_id
Jimmy,Zhang,rastaman27,37258
Ji,Kim,kimji8,44947
Veronica,Fuentes,shakira<3,19846
```

Paste this text into a text editor, then save it as `students.txt`. You can then open the file with a spreadsheet program like Excel, Open Office, or Libre Office.  If you do, it will look something like this:

<img src="../images/open-office-table.png" style="border:1px solid black">

You can also create the CSV file directly in the spreadsheet program, then use Save As... to save it in the CSV format.

**Note:** Although it is convenient to use Excel to work with CSV files since most people have Excel on their computers, if you are going to do serious work with CSV files using Excel is NOT recommended.  The reason for this is that Excel automatically converts some strings that include dashes (typically ID numbers or other codes) into dates when it imports them.  Because CSV files do not contain any metadata describing the format of the files, there is no known way to prevent this problem.  It is a frustrating and insidious problem that can ruin a large dataset in ways that are difficult to repair.  So it is better to install and use Libre Office (open source) or Open Office and use them instead.

When saving a newly-created CSV file, you should use Save As... In Libre or Open Office, there is a checkbox in the dialog where you have the option to Edit Filter Settings.  

<img src="../images/edit-filter-settings.png" style="border:1px solid black">

The subsequent dialog box allows you to select a field delimiter, which will usually default to comma:

<img src="../images/pick-delimiters.png" style="border:1px solid black">

There is also a dropdown where you can select UTF-8 as the file encoding:

<img src="../images/select-utf-8.png" style="border:1px solid black">

If your file contains only ASCII characters (Latin alphabet, numeric, and typical symbol characters), the Edit Filter Settings isn't that critical, but if your text contains any non-Latin language characters, unusual symbols, or letters with diacritics, it's critical to make sure that the file is saved as UTF-8.  

Libre or Open Office tend to assume that you want to use the last delimiter and character encoding that you used previously, so once you have saved a CSV file in this manner, it's usually safe to open and close it by just saving without going through the Save As... dialog.

## Reading CSV files

It would be relatively easy to write the Python code to parse CSV files if they contained only fields separated by commas.  However, it's also allowable for fields to be contined inside a text delimiter like quotes (to handle the case where the field text includes commas).  Then there's the problem of delimiting text fields that include quotes as part of their text.  For that reason, it is better to read and write CSV files using the CSV module that is included in the Python standard library.  To use CSV functions, add the line

```python
import csv
```

at the top of your program.

To read a CSV file, after opening the file as described above you create a `.reader()` object like this:

```python
readerObject = csv.reader(fileObject)
```

The reader object is iterable, and each iterator is a row in the table that is a list.  If you have saved the student.csv file described above, you can explore the CSV reader object with this code:

```python
import csv

fileObject = open('students.csv', 'r', newline='', encoding='utf-8')
readerObject = csv.reader(fileObject)
print(type(readerObject))
print(readerObject)
for row in readerObject:
    print(type(row))
    print(row)
fileObject.close()
```

Note that when using the CSV reader, you don't need to specify text (`t`) in the second parameter.  The [CSV Reader doc](https://docs.python.org/3/library/csv.html) also says that the file object should be opened with `newline=`. (This is related to how Python 3 handles the difference in newline characters in different operating systems.  See [this](https://docs.python.org/release/3.2/library/functions.html#open) for details.)

The output shows that the reader object itself isn't a thing that can be printed, but each of the rows we've iterated through in the reader object is just a familiar list.  So we can access and use them as we would use any other list.

One useful function would be to read in a CSV file and then store its data as a list of lists.  We can then refer to this array-like object by row and column using this notation:

```
data[row][column]
```

This script creates a CSV-reading function that takes the file name as an argument and returns a list of lists:

```python
import csv

def readCsv(filename):
    fileObject = open(filename, 'r', newline='', encoding='utf-8')
    readerObject = csv.reader(fileObject)
    array = []
    for row in readerObject:
        array.append(row)
    fileObject.close()
    return array

studentInfo = readCsv('students.csv')
print(studentInfo)
print()
print(studentInfo[1][2])
print()
outputString = ''
for row in range(0,len(studentInfo)):
    for column in  range(0,len(studentInfo[row])):
        outputString += studentInfo[row][column] + '\t'
    outputString += '\n'
print(outputString)
```

Notes:
- Although we might consider the header row (row 0) to be something special, as far as the CSV reader is concerned, it's just another row.
- In an attempt to make the columns line up, the inner for loop adds a tab character after each field.  But because the field values vary in length, they don't line up very well.
- Notice how the `len()` function was used to establish the end of the range in each loop.
- All of the items in a csv.reader() list are strings.  That is the case regardless of whether their form is that of an integer, floating point number, date, etc.  If you want data that has been read in using csv.reader() to have a different type, you need to run the values through the appropriate type conversion function (e.g. `int()`).

If you want the option to skip a header row in the CSV file, you can use the following modification of the reading function. The second argument is a boolean, with `True` including the header row and `False` omitting it.

```python
import csv

def readCsv(filename, header):
    fileObject = open(filename, 'r', newline='', encoding='utf-8')
    readerObject = csv.reader(fileObject)
    array = []
    if not header:
        next(readerObject)
    for row in readerObject:
        array.append(row)
    fileObject.close()
    return array

studentInfoNoheader = readCsv('students.csv', False)
print(studentInfoNoheader)
print()
studentInfoHeader = readCsv('students.csv', True)
print(studentInfoHeader)
```

Here's an example of how we can use some data from the web.  Go to [this page](https://github.com/jasonong/List-of-US-States/blob/master/states.csv), then right-click on the Raw button and select Save link as... Save the file in the directory from which you've been running your scripts.  In a new Python script, include the `import csv` line and the `readCsv()` function, followed by this code:

```python
states = readCsv('states.csv', False)
code = input("Enter the two-letter state abbreviation: ")
find = False
for state in states:
    if state[1] == code:
        print('The state name is ' + state[0])
        find = True
if not find:
    print("I couldn't find your state.")
```

## Writing CSV files

The CSV module also makes it easy to write data to files in CSV format. As with the CSV reader, the file must be opened and a csv.writer() object created.  The output process is essentially the opposite of the input process.  Each row to be written should be a list.  If the list doesn't already consist of strings, they'll be "stringified" before they are written.  The `.writerow()` method is used to actually write the row to the file.  Here's an example:

```python
import csv

data = [ ['name', 'company', 'nemesis'], ['Mickey Mouse', 'Disney', 'Donald Duck'], ['Road Runner', 'Warner Brothers', 'Wile Ethelbert Coyote'] ]
fileObject = open('cartoons.csv', 'w', newline='', encoding='utf-8')
writerObject = csv.writer(fileObject)
for row in data:
    print(row)
    writerObject.writerow(row)
fileObject.close()
```

If we run this script and open the resulting `cartoons.csv` file in a spreadsheet program, we see this:

<img src="../images/cartoon-spreadsheet.png" style="border:1px solid black">

A nice thing about CSV writer is that it takes care of escaping or enclosing in quotes any problematic characters.  for example, if I create the following data and run the script:

```python
import csv

data = [ ['string', 'anotherString'], ['has "quotes" in it', "has 'single quotes' in it"], ['has, commas, in it', 'has\nnewlines\nin it'] ]
fileObject = open('test.csv', 'w', newline='', encoding='utf-8')
writerObject = csv.writer(fileObject)
for row in data:
    print(row)
    writerObject.writerow(row)
fileObject.close()
```

The resulting files look like this in a text editor and spreadsheet:

<img src="../images/messy-text.png" style="border:1px solid black">

You can see that the double quotes were escaped by writing two consecutive double quotes and the strings with commas and newlines in them were inclosed in single quotes so that when the file was opened in a spreadsheet that could import CSVs, the data came in correctly.

The following script contains a reusable function called `writeCsv()`.  The first argument is the file path and the second is a list of lists.  The function does not return any value.

```python
import csv

def writeCsv(fileName, arrqy):
    fileObject = open(fileName, 'w', newline='', encoding='utf-8')
    writerObject = csv.writer(fileObject)
    for row in arrqy:
        writerObject.writerow(row)
    fileObject.close()

data = [ ['col1', 'col2'], ['stuff', "more stuff"], ['second row', 'more data'] ]
writeCsv('test.csv', data)
```

## Reading into dictionaries

In the examples above, the CSV reader input each row of the file as a list.  It's alos possible to read the data in as a sequence of dictionaries, using the column headers as keys.  Here's an example that reads in the cartoons.csv file that was written in a previous example.

*Note:* If you want to go for the big time, download [this file](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoons.csv) by right clicking on the Raw button and saving the file in the directory where you are running the script.

```python
import csv

fileObject = open('cartoons.csv', 'r', newline='', encoding='utf-8')
readerObject = csv.DictReader(fileObject)
print(type(readerObject))
print(readerObject)
cartoon = []
for row in readerObject:
    print(type(row))
    print(row)
    cartoon.append(row)
fileObject.close()
print()
print(cartoon[1]['name'] + ' works for ' + cartoon[1]['company'] + '. Its enemy is ' + cartoon[1]['nemesis'])
```

Notes:
- If you run the script, you'll see that the type of the rows is *ordered dictionary*.  This is a more complicated data structure than the ordanary unordered dictionaries we saw in the last lesson.  However, you can use them in the same way as regular dictionaries.
- Since the ordered dictionaries are put into a list, we refer to a value first by its row number, then by its key, which is the header for its column: `cartoon[rowNumber][keyString]`
- It's possible to override the column headers (the first row) and use different keys for the columns.  See [this page](https://docs.python.org/3/library/csv.html#module-contents) for details.
- There is also a dictionary writer that converts dictionaries to CSV files.  However, this is less likely to be useful, so we won't go into it.  See the [CSV module documentation](https://docs.python.org/3/library/csv.html#module-contents) for details.

Here's a reusable function that takes a file path as an argument and returns a list of dictionaries:

```python
import csv

def readDict(filename):
    fileObject = open(filename, 'r', newline='', encoding='utf-8')
    dictObject = csv.DictReader(fileObject)
    array = []
    for row in dictObject:
        array.append(row)
    fileObject.close()
    return array

cartoons = readDict('cartoons.csv')
name = input("What's the character? ")
find = False
for character in cartoons:
    if character['name'].lower() == name.lower():
        if character['nemesis'] == '':
            print("I don't know the nemesis of " + name)
        else:
            print(name + " doesn't like " + character['nemesis'])
        find = True
if not find:
    print("Sorry, I don't know that character.")
```

Notice that by comparing the lower case versions of both the name in the dictionary and the name input by the user, we've made the search case-insensitive.  We also error trap the situation where either the character or its nemesis isn't known.

# Requests library for the web

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

## Reading from CSV files from the web

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

If we replace the `.reader()` method with the `.DictReader()` method, we can create a list of dictionaries instead. Instantiating the dictionary reader is not sensitive to a trailing final newline, so we can leave off the `if` statement checking for it.

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


Revised 2019-02-11
