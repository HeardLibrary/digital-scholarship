---
permalink: /script/python/inout/
title: File input and output
breadcrumb: Files
---

Note: this is the sixth lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[prevous lesson on dictionaries and JSON](../json/)

If you are interested in using Jupyter notebooks, the examples are available in [this notebook](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/inout.ipynb).

The presentation for this lesson is [here](presentations/lesson6-files.pdf)

Answers for last week's challenge problem:

[Look up data about schools from Wikidata](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge5/vandy-schools.py)

# File Input and Output

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
- The last argument specifies the character encoding.  It can be omitted, since the default encoding in Python 3 is UTF-8, but the situation is more clear if you include it.
- The file write isn't necessarily completed untill you close the file with the `close()` function. 
- Because the file name in the first argument doesn't specify any path, it will default to the directory from which the script is being run.

If you run this script, you won't see anything in the Shell.  But if you go to the directory from which you ran the script, you should see the `datafile.txt` file.  (If you run it using an IDE, the file should be in the directory where you saved the script.)  You can open file you wrote with a text editor and see that it includes the text that was in the `someText` variable.

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

Note that if you want to have newlines separating lines that you've output to a file with the `.write()` method, you can just add it to the end of the output string, like this:

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

An extremely common way to store tabular data is in *fielded text files*, commonly called *"CSV"* (comma separated values) files.  "Fielded text" is probably a better term, because the fields in the text aren't always delimited by commas.  It is also fairly common for fields to be separated by tabs or some other characters.  But it's still common to call them "CSV" files regardless of the delimiter.

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

It would be relatively easy to write the Python code to parse CSV files if they contained only fields separated by commas.  However, it's also allowable for fields to be contained inside a text delimiter like quotes (to handle the case where the field text includes commas).  Then there's the problem of delimiting text fields that include quotes as part of their text.  For that reason, it is better to read and write CSV files using the CSV module that is included in the Python standard library.  To use CSV functions, add the line

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

Note that when using the CSV reader, you don't need to specify text (`t`) in the second parameter.  The [CSV Reader doc](https://docs.python.org/3/library/csv.html) also says that the file object should be opened with `newline=''`. (This is related to how Python 3 handles the difference in newline characters in different operating systems.  See [this](https://docs.python.org/release/3.2/library/functions.html#open) for details.)

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

Here's an example of how we can use some data from the web.  Go to [this page](https://github.com/jasonong/List-of-US-States/blob/master/states.csv), then right-click on the Raw button and select Save link as... Save the file in the directory from which you've been running your scripts.  **Note:** in some situations your browser will change the file extension from `.csv` to `.txt`. (Technical reason: GitHub reports a Content-Type of text/plain for every raw file, regardless of extension.)  So check after downloading to make sure the file actually has a `.csv` extension.  If not, change it from `.txt` to `.csv` before proceeding.

In a new Python script, include the `import csv` line and the `readCsv()` function, followed by this code:

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

def writeCsv(fileName, array):
    fileObject = open(fileName, 'w', newline='', encoding='utf-8')
    writerObject = csv.writer(fileObject)
    for row in array:
        writerObject.writerow(row)
    fileObject.close()

data = [ ['col1', 'col2'], ['stuff', "more stuff"], ['second row', 'more data'] ]
writeCsv('test.csv', data)
```

## Reading into dictionaries

In the examples above, the CSV reader input each row of the file as a list.  It's also possible to read the data in as a sequence of dictionaries, using the column headers as keys.  Here's an example that reads in the cartoons.csv file that was written in a previous example.

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
- If you run the script, you'll see that the type of the rows is *ordered dictionary*.  This is a more complicated data structure than the ordinary unordered dictionaries we saw in the last lesson.  However, you can use them in the same way as regular dictionaries.
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

# Homework

The answers are [at the end](#homework-answers)

1\. **Reading an AWS credentials file**

The Amazon Web Services (AWS) command line client needs to know the user's access key and access secret (something like a password) in order to perform secure communications with online services.  The credentials file (named `credentials` and stored in a subdirectory of the user directory called `.aws`) looks like this:

```
[default]
aws_access_key_id=AKIAYXHJJLTLYSK3
aws_secret_access_key=f1+UDwKg6huwH+7u
```

Save this text in a file called `credentials` and put it in the directory from which you've been running your scripts.

A. Write a program to open the file, read in the lines, and assign the second and third lines to variables.

B. Use the `.split('=')` method to assign access key and secret to two different variables.

C. Write a "password-checking" script that asks the user to enter their username and password.  Check the username against the access key and the password against the secret and make appropriate messages if they log in successfully or not.

2\. **Nashville Schools info** Download these [Nashville schools data](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/gis/wg/Metro_Nashville_Schools.csv) from GitHub.  (Right-click on the `Raw` button, then click on `Save link as...`.  Save the file in the directory from which you have been running your scripts.) Use the `readDict(filename)` function from the code in the previous section to read in the file as a list of dictionaries.  Also, don't forget to import the CSV module.  **Note that the keys for the dictionary are the column headers, including the spaces, capitalization, etc.  So you may want to copy and past from the column headers in GitHub to make sure you have them correctly.**

A. **Search by school name** Let the user enter the name of the school they want, then loop through the list of school dictionaries until there is a match with the school name value (key=`School Name`). When the school is found, provide some information about the school that you think might be useful, such as the school level and zip code.

B. **Case-insensitive school search** Modify your script so that it doesn't matter whether the user capitalizes correctly or not.  You will want to use the `.lower()` method on both the string from the CSV file and the string that the user inputs with which the string from the file is being compared.

C. **Partial string school search** Modify the script in B so that the user doesn't have to enter the entire school name.  Use the `substring in string` boolean expression.  For example `'he' in 'hello'` evaluates to `True`, but `'hi' in 'hello'` evaluates to `False`.  Since only part of the name will be entered, print the whole school name as part of your output.  What happens if you enter part of a name that is found in many schools (such as `hill`)?

# Challenge Problems
1\. Modify the school search program from the homework to calculate the percentage of students in that school that fall into particular categories.  You'll need to add up the total number of students in all grades, which means that you probably will want to read in the school table as a list of lists, rather than a list of dictionaries (using `csv.reader()` rather than `csv.DictReader()`).  You can also iterate through the columns to list the name of the category (from row 0, the header row) and the value for that category (from the row with the matching name).

2\. **Advanced cartoon checker** Use the [cartoons.csv](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoons.csv) file to create a script that allows the user to input all or part of the name of a cartoon character, then tell the user the company that created the character, and the character's nemesis.  You will have to download the cartoons.csv file into the directory from which you run the script.
 
**Program features**
- Notice that the nemesis for most characters hasn't been entered or isn't known.  So you should handle that.
- In order to allow the user to enter part of the character's name, use the `substring in string` boolean expression.  For example `'he' in 'hello'` evaluates to `True`, but `'hi' in 'hello'` evaluates to `False`.
- In order to make the search case insensitive, apply the `.lower()` method to both the string that the user entered and the character name in the CSV file.
- Handle gracefully the case where there are no matches.
- Also handle the case where there is more than one match.

## Homework answers

1\. A. Note that in this application it does not matter whether there is a trailing newline at the end of the file since we are explicitly referencing list items 1 and 2.  So the code doesn't do anything to get rid of a trailing newline if there is one.

```python
with open('credentials', 'rt', encoding='utf-8') as fileObject:
    lineList = fileObject.read().split('\n')

userString = lineList[1]
pwdString = lineList[2]
print(userString)
print(pwdString)
```

B. For clarity, the processing of the input strings has been done in steps here:

```python
with open('credentials', 'rt', encoding='utf-8') as fileObject:
    lineList = fileObject.read().split('\n')

userString = lineList[1]  # get the second line
pwdString = lineList[2]   # get the third line
userList = userString.split('=')
pwdList = pwdString.split('=')
username = userList[1]   # get the second item in the list created by .split(), i.e. what's after the equals sign
password = pwdList[1]
print(username)
print(password)
```

However, one could put all of the steps into one assignment if desired:

```python
with open('credentials', 'rt', encoding='utf-8') as fileObject:
    lineList = fileObject.read().split('\n')

username = lineList[1].split('=')[1]
password = lineList[2].split('=')[1]
print(username)
print(password)
```

The code is more compact, but it's less apparent what the processing steps are.

c. 

```python
with open('credentials', 'rt', encoding='utf-8') as fileObject:
    lineList = fileObject.read().split('\n')

username = lineList[1].split('=')[1]
password = lineList[2].split('=')[1]

user = input('Enter your username: ')
if user != username:
    print('Unknown user')
else:
    pwd = input('Enter your password: ')
    if pwd == password:
        print('Validated!')
    else:
        print('Incorrect password')
```

Obviously this leaves a lot to be desired as a validation system, since you could just hack the script to print out the username and password.  Also, for security reasons it would be better to have the entered characters not show up on the screen when the user types them.  But this is a beginner class, after all!

2\. A. 

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

schoolData = readDict('Metro_Nashville_Schools.csv')
mySchool = input('What school do you want to know about? ')
for school in schoolData:
    if school['School Name']==mySchool:
        print('Level:', school['School Level'])
        print('Zip code:', school['Zip Code'])
```

B. Note: the import statement and `readDict()` function definition are the same as in part A.  Only the code after the function is shown here.

```python
schoolData = readDict('Metro_Nashville_Schools.csv')
mySchool = input('What school do you want to know about? ')

for school in schoolData:
    if school['School Name'].lower()==mySchool.lower():
        print('Level:', school['School Level'])
        print('Zip code:', school['Zip Code'])
```

C. Import and function definition omitted here

```python
schoolData = readDict('Metro_Nashville_Schools.csv')
mySchool = input('What school do you want to know about? ')

for school in schoolData:
    if mySchool.lower() in school['School Name'].lower():
        print('School:', school['School Name'])
        print('Level:', school['School Level'])
        print('Zip code:', school['Zip Code'])
        print()
```

I put in an empty print statement to separate output from multiple school hits.

[next lesson on data from the Internet](../internet/)

Revised 2019-10-02
