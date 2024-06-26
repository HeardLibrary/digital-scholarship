# Zotero export tool

## Summary

`zotero_export_tool.py` is a Python script that exports the contents of a Zotero library to a series of JSON files, each of which contains 100 records (or fewer for the last file). The output files are raw API output. The script is intended to be used as a component of a larger workflow that will convert the JSON files to TEI XML for ingest into a database.

## Current limitations

1. This script does not currently support database caching. `requests` caching is enabled, but that only caches previously issued HTTP requests for 5 minutes. `requests` caching generates a SQLite database in the current working directory named `requests_cache.sqlite`. If this is not desired, the caching can be disabled by commenting out the `requests_cache.install_cache` line in the Imports section of the script.
2. The script does not do any intrinsic throttling, since the API guide does not suggest any overall rate limits. However, it does support Backoff and Retry-After headers from the server when it is overloaded or too many requests are made in a certain period of time. When these requests are received, they will be noted in the script console output.
3. The script does not handle every possible error condition, but if an agent ID is invalid (resulting in a 500 error), it does prompt the user to check the submitted ID. In most cases, the script retries after some interval.
4. Currently, the following API request parameters default to the values shown below. If these values are likely to change, they should be made into command line options.
- library_type='groups'
- what_to_include='bib,data,coins,citation'
- endpoint='items'
- citation_style='chicago-fullnote-bibliography'

# Script details

Script location: <https://github.com/HeardLibrary/digital-scholarship/blob/master/code/api/python/zotero/zotero_export_tool.py>

Current version: v0.3.0

Written by Steve Baskauf 2024-02-08.

Copyright 2024 Vanderbilt University. This program is released under a [GNU General Public License v3.0](http://www.gnu.org/licenses/gpl-3.0).

### RFC 2119 key words

The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

## Installation requirements

The script REQUIRES that you have Python 3 installed on your computer. It REQUIRES the [requests](https://docs.python-requests.org/en/latest/) module, which is not part of the Python Standard Library, so you may have to use PIP to install it prior to running the script. It also REQUIRES the [requests-cache](https://pypi.org/project/requests-cache/) module, although that feature can be disabled as described above.

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
| --modpath | -M | OPTIONAL path string (including filename) of XML file containing the last modified version of the library | '' |
| --path | -P | OPTIONAL path string to be prepended to filename. The path MUST exist before the script is run. | '' (current working directory) |
| --start | -S | OPTIONAL integer starting record for paging | 0 |
| --version | -V | no values; displays current version information |  |
| --help | -H | no values; displays link to this page |  |

## Restarting after a crash

Each set of 100 records is saved in a file that has the paging start integer appended to the filename, e.g. `zotero_400.json`. If the script crashes or is aborted and there is no "Download completed successfully" message, examine the output files to determine the last successful page retrieved and the integer of the start of the next page. For example, if the script aborted after retrieving `zotero_400.json`, the script should be restarted with a paging starting record of 500. This can be specified using the `--start` or `-S` command line argument:

```
python zotero_export_tool.py --id 2267085 --start 500
```

## Retrieving recently modified records

If the `--modpath` or `-M` command line argument is provided, the script will obtain the last modified version number from an XML file, which MUST have the following structure:

```
<zotero-config>
    <last-modified-version>7323</last-modified-version>
    ... other elements
</zotero-config>
```

The last modified version will then be provided as the value of a `since` query argument. This will result in the API returning only records that have been modified since that last modified version. 

If no `--modpath` or `-M` command line argument is provided, all records from the specified database will be retrieved.

The script retrieves the current last modified version number from the API as the value of `latest_modified_version`. However, currently the script does nothing but report this value. It does not replace the previous value in the XML file.
