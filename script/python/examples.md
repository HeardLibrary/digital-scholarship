---
permalink: /script/python/examples/
title: Python code examples
breadcrumb: Examples
---

# Some code examples to try

## Simple script to input, calculate, and output

```
# Note: if you copy and paste this script into an IDE like Thonny,
# you will need to save the script as a file somewhere.
# You can call the file something like intro.py

# The lines that start with hash characters (#) are comments and will be ignored by Python

# Here we set up the data needed to run the calculation
pi = 3.14159
print(pi)
diameter = float(input('Enter the diameter: '))   # when this line runs you need to enter a number
print('Diameter = ', diameter)

# The data need to be transformed into a usable form
radius = diameter/2
print('Radius = ', radius)

# We have all of the information necessary to complete the calcuation
print('The area of the circle is ',pi*radius**2)
```

## Uses the "turtle" drawing tool to make a shape

```
import turtle

def drawSquare(myTurtle,maxSide):
    for sideLength in range(1,maxSide+1):
        myTurtle.forward(100)
        myTurtle.right(170)

t = turtle.Turtle()
drawSquare(t,40)
```

## Playing with Nashville schools data

View the source file at https://github.com/HeardLibrary/digital-scholarship/blob/master/data/gis/wg/Metro_Nashville_Schools.csv

```
# import two necessary modules
import csv
import urllib.request

# load a CSV file with data on Nashville schools from the Internet
url = 'https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv'
response = urllib.request.urlopen(url).read().decode('utf-8')
fileText = response.split('\n')

# remove empty final line
if fileText[len(fileText)-1] == '':
    fileText = fileText[0:len(fileText)-1]

# turn the data into a table
fileRows = csv.reader(fileText)
schoolData = []
for row in fileRows:
    schoolData.append(row)
    
# Show the header and first row of the table
print(schoolData[0])
print(schoolData[1])
print()

# print the IDs and names of all of the schools
print(schoolData[0][2] + '\t' + schoolData[0][3])
for school in range(1, len(schoolData)):
    print(schoolData[school][2] + '\t' + schoolData[school][3])

# calculate the total number of students per school and fraction white students for each row
schoolData[0].append('total students')
schoolData[0].append('fraction white')
for school in range(1, len(schoolData)):
    totalStudents = int(schoolData[school][27]) + int(schoolData[school][28])
    fractionWhite = int(schoolData[school][26]) / totalStudents
    schoolData[school].append(str(totalStudents))
    schoolData[school].append(str(fractionWhite))

# save the data as a spreadsheet
fileObject = open('school-data.csv', 'w', newline='', encoding='utf-8')
writerObject = csv.writer(fileObject)
for row in schoolData:
    writerObject.writerow(row)
fileObject.close()

print('Finished writing the CSV spreadsheet file')
```

----
Revised 2020-01-17