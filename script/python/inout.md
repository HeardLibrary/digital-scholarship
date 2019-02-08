---
permalink: /script/python/inout/
title: Input and output
breadcrumb: Input/Output
---

Note: this is the fifth lesson in a beginner's introduction to Python.  for the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

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

# CSV and Dict writer

# Requests library for the web

# Reading and Writing JSON

 A. JSON name:value vs. dict
 B. JSON array vs. list

# Event-based code
 A. GUI with TkInter



Revised 2019-02-08
