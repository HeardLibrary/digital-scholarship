# generate_collections_json.py, a Python script for generating IIIF v3 Collections JSON files from a CSV file with manifest data

# (c) 2023 Vanderbilt University. This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf

script_version = '0.1.0'
version_modified = '2023-11-30'

# ----------------
# Module imports
# ----------------

import sys
import pandas as pd
import yaml
import json

# ----------------
# Global variables
# ----------------

# Support command line arguments

arg_vals = sys.argv[1:]
# see https://www.gnu.org/prep/standards/html_node/_002d_002dversion.html
if '--version' in arg_vals or '-V' in arg_vals: # provide version information according to GNU standards 
    # Remove version argument to avoid disrupting pairing of other arguments
    # Not really necessary here, since the script terminates, but use in the future for other no-value arguments
    if '--version' in arg_vals:
        arg_vals.remove('--version')
    if '-V' in arg_vals:
        arg_vals.remove('-V')
    print('generate_collections_json', script_version)
    print('Copyright ©', version_modified[:4], 'Vanderbilt University')
    print('License GNU GPL version 3.0 <http://www.gnu.org/licenses/gpl-3.0>')
    print('This is free software: you are free to change and redistribute it.')
    print('There is NO WARRANTY, to the extent permitted by law.')
    print('Author: Steve Baskauf')
    print('Revision date:', version_modified)
    print()
    sys.exit()

if '--help' in arg_vals or '-H' in arg_vals: # provide help information according to GNU standards
    # needs to be expanded to include brief info on invoking the program
    print('For help, see the generate_collections_json landing page at https://github.com/HeardLibrary/linked-data/tree/master/commonsbot/README.md')
    print('Report bugs to: steve.baskauf@vanderbilt.edu')
    print()
    sys.exit()

# Code from https://realpython.com/python-command-line-arguments/#a-few-methods-for-parsing-python-command-line-arguments
opts = [opt for opt in arg_vals if opt.startswith('-')]
args = [arg for arg in arg_vals if not arg.startswith('-')]

DATA_FILE_PATH = 'manifest_data.csv' # Set default path to CSV file if not provided.
if '--datafile' in opts:
    DATA_FILE_PATH = args[opts.index('--datafile')]
if '-D' in opts: 
    DATA_FILE_PATH = args[opts.index('-D')]

LANG = 'en' # Set default language if not provided.
if '--lang' in opts:
    LANG = args[opts.index('--lang')]
if '-L' in opts: 
    LANG = args[opts.index('-L')]

BASE_URL = 'https://iiif-manifest.library.vanderbilt.edu/gallery/collections/' # Set default collection base URL if not provided.
if '--baseurl' in opts:
    BASE_URL = args[opts.index('--baseurl')]
if '-B' in opts:
    BASE_URL = args[opts.index('-B')]

config_path = 'collections_config.yml' # Set default path to configuration file if not provided.
if '--config' in opts: #  set path to configuration file
    config_path = args[opts.index('--config')]
if '-C' in opts: 
    config_path = args[opts.index('-C')]
# Load configuration values
with open(config_path, 'r') as file:
    CONFIG_VALUES = yaml.safe_load(file)

# ----------------
# Main script
# ----------------

manifest_df = pd.read_csv(DATA_FILE_PATH, na_filter=False, dtype = str)

# Create the collections metadata dictionary
collections_dict = {}
collections_dict['@context'] = 'http://iiif.io/api/presentation/3/context.json'
collections_dict['id'] = BASE_URL + CONFIG_VALUES['collection_json_filename']
collections_dict['type'] = 'Collection'
collections_dict['label'] = {}
collections_dict['label'][LANG] = [CONFIG_VALUES['collection_label']]
collections_dict['summary'] = {}
collections_dict['summary'][LANG] = [CONFIG_VALUES['collection_summary']]
collections_dict['requiredStatement'] = {}
collections_dict['requiredStatement']['label'] = {}
collections_dict['requiredStatement']['label'][LANG] = ['Attribution']
collections_dict['requiredStatement']['value'] = {}
collections_dict['requiredStatement']['value'][LANG] = [CONFIG_VALUES['attribution']]

# Generate a list of manifest dictionaries from the Pandas DataFrame of manifest data
manifests_list = []
for index, row in manifest_df.iterrows():
    manifest_dict = {}
    manifest_dict['id'] = row['manifest_id']
    manifest_dict['type'] = 'Manifest'
    manifest_dict['label'] = {}
    manifest_dict['label'][LANG] = [row['manifest_label']]
    manifest_dict['thumbnail'] = []
    manifest_dict['thumbnail'].append({})
    manifest_dict['thumbnail'][0]['id'] = row['thumbnail_id']
    manifest_dict['thumbnail'][0]['type'] = 'Image'
    manifest_dict['thumbnail'][0]['format'] = 'image/jpeg'
    manifests_list.append(manifest_dict)

# Add the list of manifests to the collections metadata dictionary
collections_dict['items'] = manifests_list

# Write the collections metadata dictionary to a JSON file
with open(CONFIG_VALUES['collection_json_filename'], 'w') as outfile:
    json.dump(collections_dict, outfile, indent=2)

# End of program
print('done')
