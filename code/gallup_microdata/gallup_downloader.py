# gallup_downloader.py - Downloads Gallup microdata files from the Gallup SFTP server.
# (c) 2023 Vanderbilt University. This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf
# Date: 2023-11-27

# The credentials are provided by Gallup. They need to be stored in a plain text file stored
# in the user's home directory using the name specified in the CREDENTIALS_FILENAME constant.
# The first line of the file should be the username and the second line should be the password.
# There should be no leading or trailing spaces on the lines. It doesn't matter whether there
# is a trailing newline at the end of the file.

# For code development notes, see dev_gallup_downloader.ipynb in the same directory as this file.

# Imports
from pathlib import Path
import os
import pandas as pd
import paramiko
import datetime
import time
import shutil
import zipfile

# Constants
SFTP_HOST  = 'host1.gallup.com'
LOCAL_DOWNLOAD_DIRECTORY_RELATIVE_TO_HOME = '/Downloads/gallup/' # create before running
REMOTE_DIRECTORY_WITH_FILES_TO_DOWNLOAD = '/out/'
CREDENTIALS_FILENAME = 'gallup_credentials.txt'
GALLUP_BOX_DIRECTORY = '/Library/CloudStorage/Box-Box/VU Gallup Microdata/current_download/' # create before running

# Load credentials from file in user's home directory.
home = str(Path.home()) # gets path to home directory; works for both Win and Mac
full_credentials_path = home + '/' + CREDENTIALS_FILENAME
        
# Retrieve credentials from local file.
with open(full_credentials_path, 'rt') as file_object:
    line_list = file_object.read().split('\n')
username = line_list[0]
password = line_list[1]

# Set the current local working directory to the local download folder.
cwd = home + LOCAL_DOWNLOAD_DIRECTORY_RELATIVE_TO_HOME
os.chdir(cwd)

# Open the CSV file containing the record from the last download as a Pandas dataframe.
last_download_csv_path = home + GALLUP_BOX_DIRECTORY + '/gallup_last_download.csv'
# Check whether the file exists
if not os.path.exists(last_download_csv_path):
    # Create the file and write the header row
    with open(last_download_csv_path, 'wt') as file_object:
        file_object.write('filename,size_in_mb,last_modified_iso\n')

# Read the file into a dataframe
last_download_df = pd.read_csv(last_download_csv_path)
# Set the filename column as the index
last_download_df = last_download_df.set_index('filename')
#print(last_download_df)

# Establish a connection with the SFTP server.
# See example at https://stackoverflow.com/questions/12486623/paramiko-fails-to-download-large-files-1gb
ssh = paramiko.SSHClient() 
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
try:
    ssh.connect(SFTP_HOST, username=username, password=password, timeout=5.0)
    print('Connection succesfully established with server ... ')
except:
    print( 'Connection with server failed')
    # End the program.
    sys.exit(1)

# Initiate an SFTP session.
try:
    sftp = ssh.open_sftp()
    print('SFTP session succesfully established ... ')
except:
    print('Failed to start SFTP session')
    # End the program.
    sys.exit(1)
print()

# Switch to the remote directory holding the files to download (relative to /var/www/vhosts).
sftp.chdir(REMOTE_DIRECTORY_WITH_FILES_TO_DOWNLOAD)

# Print filenames in the directory.
file_list = sftp.listdir()
#print(file_list)

# Obtain structure of the remote directory.
directory_structure = sftp.listdir_attr()
#print(directory_structure)

# Process each file in the directory.
for attr in directory_structure:
    # Print the file name, size, and last modified date.
    filename = attr.filename
    size_in_bytes = attr.st_size
    last_modified_raw_time = attr.st_mtime
    # Convert the last modified time to a yyyy-mm-dd format.
    last_modified_iso = datetime.datetime.fromtimestamp(last_modified_raw_time).strftime('%Y-%m-%d')
    # Convert the size to MB, rounded to the nearest 0.1 MB
    size_in_mb = round(size_in_bytes / 1048576, 1)

    extract_folder = filename[:-4] # remove the .zip extension

    # Check whether the file has already been downloaded.
    if filename in last_download_df.index:
        # Check whether the file size and last modified date are the same as in the last download.
        if size_in_mb == last_download_df.loc[filename, 'size_in_mb'] and last_modified_iso == last_download_df.loc[filename, 'last_modified_iso']:
            # Skip this file.
            print('Skipping ' + filename + ' because it has already been downloaded.')
            continue
        else:
            # If the file has the same name but has been updated, add the ISO date to the extract_folder.
            # This will ensure that the newer version gets downloaded. NOTE: the code below that removes
            # redundant subfolders will not work if the extract_folder name has been changed.
            extract_folder = extract_folder + '_' + last_modified_iso

    print('filename: ' + filename, ', size: ' + str(size_in_mb), 'MB, last modified: ' + str(last_modified_iso))

    # Download the zip file.
    print('Downloading ...')
    # Save the start time.
    start_time = time.time()
    # Download the file to the previously established remote and local directories.
    sftp_file_instance = sftp.open(filename, 'r')
    with open(filename, 'wb') as out_file:
        shutil.copyfileobj(sftp_file_instance, out_file)
    
    # Calculate the elapsed time.
    elapsed_time = round(time.time() - start_time, 1)
    print('Download time: ' + str(elapsed_time) + ' seconds')

    # Set up local folder to hold the extracted files.
    extract_path = home + GALLUP_BOX_DIRECTORY + extract_folder + '/'
    # If the extract folder does not exist, create it.
    if not os.path.exists(extract_path):
        os.makedirs(extract_path)

    # Unzip the downloaded file and put the contents in the gallup_box_path.

    # NOTE about unzipping: I had no problem unzipping these container zip files. However, in several cases
    # the unzipped files were themselves zip files. I could have modified this code to unzip them. However, 
    # there were several files that would not unzip using the Python zipfile module. They also would not unzip 
    # using the Mac unzipping tool. However, if I downloaded them to a Windows machine and unzipped them there,
    # they unzipped without a problem. I have not fully investigated this to figure out what is the difference 
    # in the compressed file formats that causes the problem. So I have not added any additional code to unzip 
    # any contained zip files. They can just be downloaded and unzipped (on a Windows machine if necessary) when
    # a patron requests therm.
    
    path_to_zip_file = cwd + filename
    print('Unzipping ...')
    with zipfile.ZipFile(path_to_zip_file, 'r') as zip_ref:
        zip_ref.extractall(extract_path)
    print('Unzipping complete.')

    # Delete the zip file
    os.remove(path_to_zip_file)

    # If the unzipping resulted in a subdirectory with the same name as the containing directory, 
    # move the files up one level and delete the subdirectory. This works in most cases, although in some
    # the subdirectory has a different name.
    subfolder_path = extract_path + extract_folder + '/'
    if os.path.exists(subfolder_path):
        # Move the files up one level.
        for file in os.listdir(subfolder_path):
            shutil.move(subfolder_path + file, extract_path)
        # Delete the subfolder.
        os.rmdir(subfolder_path)

    print()

    # Update the last download dataframe.
    last_download_df.loc[filename, 'size_in_mb'] = size_in_mb
    last_download_df.loc[filename, 'last_modified_iso'] = last_modified_iso
    # Save the dataframe to the CSV file.
    last_download_df.to_csv(last_download_csv_path) # By default, the index is saved as a column.

print('File downloads complete.')

# Close connection
sftp.close()
print('Connection closed ...')

print('done')
