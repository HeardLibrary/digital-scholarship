# Zotero export tool

## Summary

`zotero_export_tool.py` is a Python script that exports the contents of a Zotero library to a series of JSON files, each of which contains 100 records (or fewer for the last file). The output files are raw API output. The script is intended to be used as a component of a larger workflow that will convert the JSON files to TEI XML for ingest into a database.

## Current limitations

1. This script does not currently support database caching and conditional GET requests. If the dataset is large and changes to it are small, this capability should be added. `requests` caching is enabled, but that only caches previously issued HTTP requests for 5 minutes. `requests` caching generates a SQLite database in the current working directory named `requests_cache.sqlite`. If this is not desired, the caching can be disabled by commenting out the `requests_cache.install_cache` line in the Imports section of the script.
2. The script does not do any intrinsic throttling, since the API guide does not suggest any overall rate limits. However, it does support Backoff and Retry-After headers from the server when it is overloaded or too many requests are made in a certain period of time. When these requests are received, they will be noted in the script console output.
3. The script does not handle every possible error condition, but if an agent ID is invalid (resulting in a 500 error), it does prompt the user to check the submitted ID.
4. Currently, the following API request parameters default to the values shown below. If these values are likely to change, they should be made into command line options.
- library_type='groups'
- what_to_include='bib,data,coins,citation'
- endpoint='items'
- citation_style='chicago-fullnote-bibliography'

# Script details

Script location: <https://github.com/HeardLibrary/digital-scholarship/blob/master/code/api/python/zotero/zotero_export_tool.py>

Current version: v0.1.0

Written by Steve Baskauf 2024.

Copyright 2024 Vanderbilt University. This program is released under a [GNU General Public License v3.0](http://www.gnu.org/licenses/gpl-3.0).

### RFC 2119 key words

The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

## Installation requirements

The script REQUIRES that you have Python 3 installed on your computer. It REQUIRES the [requests](https://docs.python-requests.org/en/latest/) module, which is not part of the Python Standard Library, so you may have to use PIP to install it prior to running the script.

## Usage

The script is run at the command line by entering:

```
python zotero_export_tool.py [options]
```

where \[options\] are the command line options described below. NOTE: your implementation may require substituting `python3` for `python`. 

Example usage:

```
python zotero_export_tool.py --id 2267085 --path ./data/
```

## Command line options

| long form | short form | values | default |
| --------- | ---------- | ------ | ------- |
| --id | -I | REQUIRED Zotero user or group identifier | none |
| --path | -P | OPTIONAL path string to be prepended to filename. The path MUST exist before the script is run. | '' (current working directory) |
| --version | -V | no values; displays current version information |  |
| --help | -H | no values; displays link to this page |  |
