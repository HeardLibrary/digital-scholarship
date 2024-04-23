# Zenodo upload tool

## Summary

`zenodo_upload_tool.py` is a Python script that archives files in the [Zenodo data repository](https://zenodo.org/). Zenodo is a generalist data repository that accepts many types of data files and has few limits on size or number of files. Zenodo also assigns DataCite DOIs to each uploaded data record. The script was developed for archiving images, so one property of the upload that it captures is the access URL that allows the file (in this case image) to be retrieved directly.

Zenodo distinguishes between a "concept DOI" that represents all versions of the data, and a version-specific DOI that represents a version of the data at a particular time. The script captures the concept DOI, but the version-specific DOI can be constructed from the record number included in the captured access URL.

The script uses metadata from a CSV file to generated the metadata for the Zenodo record and to locate the file to be uploaded. The metadata captured from the upload is inserted into the CSV, which is saved under a different filename.

# Script details

Script location: <https://github.com/HeardLibrary/digital-scholarship/blob/master/code/api/python/zenodo/zenodo_upload_tool.py>

Current version: v0.1.0

Written by Steve Baskauf 2024-04-23.

Copyright 2024 Vanderbilt University. This program is released under a [GNU General Public License v3.0](http://www.gnu.org/licenses/gpl-3.0).

### RFC 2119 key words

The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

## Installation requirements

The script REQUIRES that you have Python 3 installed on your computer. It REQUIRES the [requests](https://docs.python-requests.org/en/latest/) module, which is not part of the Python Standard Library, so you may have to use PIP to install it prior to running the script. 

## API access token

To use the API, an access token is required. To acquire one, see the [Zenodo API documentation](https://developers.zenodo.org/). The access token is stored in a file that is read by the script. The file should contain only the access token and no other text. The file should be located in the user's home directory and its name hard-coded in the global variables section of the script.

## Script setup

Before performing an actual data upload, you should test the script using the sandbox API. The [endpoint URL and name of the file containing the access token](https://github.com/HeardLibrary/digital-scholarship/blob/3f752abec1e7592605628aab6aad47121aa9ffed/code/api/python/zenodo/zenodo_upload_tool.py#L35:L41) default to the sandbox API. In production, these will need to be changed in the script in the global variables section.

Because file locations will vary among users, there are two idiosyncratic functions in the script that will need to be modified. The [first function](https://github.com/HeardLibrary/digital-scholarship/blob/3f752abec1e7592605628aab6aad47121aa9ffed/code/api/python/zenodo/zenodo_upload_tool.py#L54) generates a path to the location of the file to be uploaded. The [second function](https://github.com/HeardLibrary/digital-scholarship/blob/3f752abec1e7592605628aab6aad47121aa9ffed/code/api/python/zenodo/zenodo_upload_tool.py#L62) maps the metadata fields in the CSV file to the metadata fields required by Zenodo. These functions will need to be modified to match the file locations and metadata fields used by the user.

## Usage

The script REQUIRES a CSV file containing metadata for the Zenodo records and the names of the data files to be uploaded. This file MUST be located in the same directory as the script. The filename is set in the global variables section of the script.

The script outputs a CSV file with the same metadata as the input file, but with additional columns for the Zenodo concept DOI and the Zenodo access URL. The filename is set in the global variables section of the script.

The script is run at the command line by entering:

```
python zenodo_upload_tool.py
```

NOTE: your implementation may require substituting `python3` for `python`. 

The API guide does not specify a rate limit. Uploading the data file to the load storage bucket seems to take enough time that the script is basically throlled by the time it takes to upload the file. The script does not have a built-in rate limit.

The upload time depends on the file size. With image size of 1 to 3 MB, about 1000 images were uploaded per hour.
