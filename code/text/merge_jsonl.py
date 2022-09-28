#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 27 10:46:57 2022

@author: baskausj
"""
import yaml
import os
import datetime

old_logs = []

path = './'
files_path = '../'
with open(path + 'log_batch1.yaml', 'r') as file_object:
    old_logs.append(yaml.safe_load(file_object))

with open(path + 'log_batch2.yaml', 'r') as file_object:
    old_logs.append(yaml.safe_load(file_object))

with open(path + 'log_batch3.yaml', 'r') as file_object:
    old_logs.append(yaml.safe_load(file_object))

directories = []
for old_log in old_logs:
    for directory in old_log['directories']:
        key = list(directory.keys())[0]
        value = directory[key]
        #print(key, value)
        dictionary = {'dir': key, 'subdirs': value}
        if value is not None:
            directories.append(dictionary)
#print(directories)

start_time = datetime.datetime.now()
with open(path +'merge_log.txt', 'at', encoding='utf-8') as log_file_object:
    log_file_object.write('start_time: ' + start_time.isoformat() + '\n')

for directory in directories:
    for subdirectory in directory['subdirs']:
        # During yaml load, the subdirs have lost their underscore before the final zero
        subdir = str(subdirectory)
        subdir = subdir[:-1] + '_' + subdir[-1:]
        dirs = str(directory['dir']) + '/' + subdir + '/'
        print(dirs)
        try:
            status = os.system('cat ' + files_path + dirs + 'joined_output.jsonl' + ' >> '+ files_path + 'merge.jsonl')
            if status == 0:
                with open(path +'merge_log.txt', 'at', encoding='utf-8') as log_file_object:
                    log_file_object.write(dirs + '\n')
            else:
                with open(path +'merge_errors.txt', 'at', encoding='utf-8') as errors_file_object:
                    errors_file_object.write(str(status) + ' ' + dirs + '\n')
        except:
            with open(path +'merge_errors.txt', 'at', encoding='utf-8') as errors_file_object:
                errors_file_object.write('system command error ' + dirs + '\n')
            
end_time = datetime.datetime.now()
elapsed_time = (end_time - start_time).total_seconds()
with open(path +'merge_log.txt', 'at', encoding='utf-8') as log_file_object:
    log_file_object.write('end_time: ' + end_time.isoformat() + '\n')
    log_file_object.write('elapsed_time: ' + str(elapsed_time) + '\n')
