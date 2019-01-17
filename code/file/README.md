# Code for manipulating text files

This code is freely available under a [Creative Commons CC0 license](https://creativecommons.org/publicdomain/zero/1.0/) ![](https://licensebuttons.net/l/zero/1.0/88x31.png)

Note: this code is still under development and may be unstable.

## Introduction

The functions in this library are used to load text data from a local file or a location on the Internet, and return it in a typical data structure for the language.  Types of text files include text lists where items are separated by newlines and fielded text (colloqually "CSV files").

Several functions allow specifying a file location relative to directories specified by system variables.  The function *test* can be used to determine the value returned by relative directory options.

### Function test

**Description** Determines the value that the system is returning for the current or base directory.

**Arguments and Return Type**

| name | type | description |
|---|---|---|
| baseLocation | string | a code for the path to the chosen directory; "b" for base directory, "c" for current working directory, or empty string for an absolute path |
| *return value* | string | the path to the specified directory |

**Example (XQuery)** This function uses functions from the BaseX HTTP module, and is therefore BaseX-specific

The function can be copied from this [code](xquery/load_file.xq), or called from this [module](xquery/load_file.xqm). The module namespace and retrieval URL are shown in the example below.

In this example, the option "c" was chosen to determine the path to the current working directory.  

```xquery
xquery version "3.1";

import module namespace vudssctext = 'https://github.com/HeardLibrary/digital-scholarship/tree/master/code/csv' at 'https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/code/file/xquery/load_file.xqm';

let $path := test("c")
return $path
```

## Code to retrieve a text list

**Description** A quick and dirty way to specify a list of items to be processed by a script is to use a text editor to create a text document where each item is on a separate line (i.e. items separated by newlines = hard returns).  The document is saved as simple text file using ASCII or UTF-8 character encoding (NOT in Word or PDF format).  The code opens or retrieves the file, then transforms it into an appropriate data structure for the language.

### Function loadTextList

**Description** Loads a text file from a local drive location and returns a sequence or list of strings.

**Arguments and Return Type**

| name | type | description |
|---|---|---|
| baseLocation | string | a code for the path to the chosen directory; "b" for base directory, "c" for current working directory, or empty string for an absolute path |
| relativePath | string | the path from the chosen directory to the file, ending in the file name with extension |
| *return value* | sequence of strings | the list of items specified in the text file |

**Example (XQuery)** This function uses functions from the BaseX HTTP module, and is therefore BaseX-specific

The function can be copied from this [code](xquery/load_file.xq), or called from this [module](xquery/load_file.xqm). The module namespace and retrieval URL are shown in the example below.

In this example, the option "c" was chosen to indicate that the text file is in the current working directory.  *N*ote: to determine the value that your system is using for the current working directory, display the value of the function vudssctext:test("c")*

```xquery
xquery version "3.1";

import module namespace vudssctext = 'https://github.com/HeardLibrary/digital-scholarship/tree/master/code/csv' at 'https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/code/file/xquery/load_file.xqm';

let $list := loadTextList("c", "file.txt")
return $list
```

## Code to retrieve data from a CSV file

**Description** Fielded text files (often called comma separated files, or CSV) are a standard method of structuring simple datasets.  These functions load CSV data and return it in a two-dimensional data structure appropriate for the programming language

### Function loadCsv

**Description** Loads a CSV file from a local drive location and returns a two-dimensional data structure.

**Arguments and Return Type**

| name | type | description |
|---|---|---|
| baseLocation | string | a code for the path to the chosen directory; "b" for base directory, "c" for current working directory, or empty string for an absolute path |
| relativePath | string | the path from the chosen directory to the file, ending in the file name with extension |
| delimiter | string | the character used as a field delimiter in the file.  For actualy CSVs, use ",". Other delimiters such as tab or pipe ("|") may be used.  Tab delimited files may require using the escaped code for tab.
| *return value* | sequence of strings | the list of items specified in the text file |

**Example (XQuery)** This function uses functions from the BaseX HTTP module, and is therefore BaseX-specific

The function can be copied from this [code](xquery/load_file.xq), or called from this [module](xquery/load_file.xqm). The module namespace and retrieval URL are shown in the example below.

In this example, the option "c" was chosen to indicate that the text file is in the current working directory.  *Note: to determine the value that your system is using for the current working directory, display the value of the function vudssctext:test("c")*

In this example, the file is comma delimited.  For a tab delimited file, use `&#9;`.  

In this example, the file is located is a subdirectory called "news-input" below the current working directory.

```xquery
xquery version "3.1";

import module namespace vudssctext = 'https://github.com/HeardLibrary/digital-scholarship/tree/master/code/csv' at 'https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/code/file/xquery/load_file.xqm';

let $recordSequence := vudssctext:loadCsv("c","news-input/text.csv", ",")
return $recordSequence
```

### Function loadCsvInternet

**Description** Loads a CSV file from a location on the Internet and returns a two-dimensional data structure.

**Arguments and Return Type**

| name | type | description |
|---|---|---|
| uri | string | the URL from which the CSV file can be retrieved. The file must be raw text, not formatted with HTML or Markdown. |
| delimiter | string | the character used as a field delimiter in the file.  For actualy CSVs, use ",". Other delimiters such as tab or pipe ("|") may be used.  Tab delimited files may require using the escaped code for tab.
| *return value* | sequence of strings | the list of items specified in the text file |

**Example (XQuery)** This function uses functions from the BaseX HTTP module, and is therefore BaseX-specific

The function can be copied from this [code](xquery/load_file.xq), or called from this [module](xquery/load_file.xqm). The module namespace and retrieval URL are shown in the example below.

In this example, the option "c" was chosen to indicate that the text file is in the current working directory.  *Note: to determine the value that your system is using for the current working directory, display the value of the function vudssctext:test("c")*

In this example, the file is comma delimited.  For a tab delimited file, use `&#9;`.  

```xquery
xquery version "3.1";

import module namespace vudssctext = 'https://github.com/HeardLibrary/digital-scholarship/tree/master/code/csv' at 'https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/code/file/xquery/load_file.xqm';

let $recordSequence := local:loadCsvInternet("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/code/file/xquery/sample.csv",",")
return $recordSequence
```

------
Last modified: 2019-01-17