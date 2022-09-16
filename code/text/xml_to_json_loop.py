"""
Original author: David Lee https://github.com/davlee1972/xml_to_json
Modifications made by Rohit Khurana https://github.com/Rkhurana19/xml_jsonl_converter/blob/master/xml_to_json.py
hacked to hard code arguments by Steve Baskauf 2022-09-16
"""

import os
import datetime

from xml_to_json.convert_xml_to_json import convert_xml_to_json
from join_jsonl import merge_jsonl

def convert_xml(target_directory):
    xsd_file = './xml_to_json/Record_v1.0.xsd'
    output_format = 'jsonl'
    server = None
    target_path = None
    zip = False
    xpath = None
    attribpaths = None
    excludepaths = None
    multi = 1
    no_overwrite = False
    verbose = 'INFO'
    log = None
    delete_xml = None
    input_files = [target_directory + '/*.xml']

    join_jsonl = target_directory
    final_output_name = 'joined_output.jsonl'

    convert_xml_to_json(xsd_file=xsd_file, output_format=output_format, server=server, target_path=target_path, zip=zip, 
        xpath=xpath, attribpaths=attribpaths, excludepaths=excludepaths, multi=multi, no_overwrite=no_overwrite, verbose=verbose, 
        log=log, delete_xml=delete_xml, xml_files=input_files)

    if (join_jsonl != None):
        # Note: the many JSONL files will go into the output subdirectory. 
        # The joined JSONL file will be in the directory with the source files.
        output_directory = os.path.join(target_directory, 'output')
        print('output_path=', output_directory)
        if not os.path.exists(output_directory): # Only create the directory if it doesn't already exist
            os.mkdir(output_directory)
        merge_jsonl(target_directory, final_output_name, output_directory)

# Create a YAML log file to record which directories have been completed (in case the script crashes)
start_time = datetime.datetime.now()
with open('log.yaml', 'at', encoding='utf-8') as log_file_object:
    log_file_object.write('start_time: "' + start_time.isoformat() + '"\n')
    log_file_object.write('directories:\n')

base_path = '..'
count = 0
directories = os.listdir(base_path + '/')
# directory outer loop
for directory in directories[:2]: # delete the index (square brackets and contents) to do all
    if directory =='xml_jsonl_converter-master': # skip this directory, which doesn't have files to be processed
        continue
    if os.path.isdir(base_path + '/' + directory):
        try:
            subdirectories = os.listdir(base_path + '/' + directory)
            with open('log.yaml', 'at', encoding='utf-8') as log_file_object:
                log_file_object.write('  - ' + directory + ':\n')

            # subdirectory inner loop
            for subdirectory in subdirectories[:2]: # delete the index (square brackets and contents) to do all
                target_directory = base_path + '/' + directory + '/' + subdirectory
                if os.path.isdir(target_directory):
                    try:
                        #convert_xml(target_directory)
                        with open('log.yaml', 'at', encoding='utf-8') as log_file_object:
                            log_file_object.write('    - ' + subdirectory + '\n')

                    except:
                        # Log errors such as directories where access is denied
                        with open('errors.txt', 'at', encoding='utf-8') as errors_file_object:
                            errors_file_object.write(target_directory + '\n')

                    count += 1
                    print(count)
                    # The progress.txt file just records the number of subdirectories done.
                    # This is a way to monitor progress if it takes many hours.
                    with open('progress.txt', 'wt', encoding='utf-8') as progress_file_object:
                        progress_file_object.write(str(count) + '\n')
        except:
            # Log errors such as directories where access is denied
            with open('errors.txt', 'at', encoding='utf-8') as errors_file_object:
                errors_file_object.write(directory + '\n')

end_time = datetime.datetime.now()
elapsed_time = (end_time - start_time).total_seconds()

with open('log.yaml', 'at', encoding='utf-8') as log_file_object:
    log_file_object.write('end_time: "' + end_time.isoformat() + '"\n')
    log_file_object.write('elapsed_time: ' + str(elapsed_time) + '\n')

print()
print('done')
