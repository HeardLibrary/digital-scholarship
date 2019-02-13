import requests
import csv

r = requests.get('https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv')
fileText = r.text.split('\n')
# take care of case where there is a trailing newline at the end of the file
if fileText[len(fileText)-1] == '':
    fileText = fileText[0:len(fileText)-1]
fileRows = csv.reader(fileText)
schoolData = []
for row in fileRows:
    schoolData.append(row)

inputSchoolName = input("What's the name of the school? ")

found = False
for school in range(1, len(schoolData)):
    if inputSchoolName.lower() in schoolData[school][3].lower(): # column 3 has the school name
        found = True
        # this section adds up the students in all of the grades
        totalEnrollment = 0
        # the grade enrollments are in columns 6 through 21
        for grade in range(6, 21):
            enrollment = schoolData[school][grade]
            # only add the column if it isn't empty
            if enrollment != '':
                totalEnrollment += int(enrollment) # csv.reader reads in numbers as strings, so convert to integers
        print(schoolData[school][3] + ' has a total of ' + str(totalEnrollment) + ' students.')
        
        for category in range(22, 32):
            if schoolData[school][category] != '':
                # turn strings into floating point numbers
                numerator = float(schoolData[school][category])
                # find fraction, get the percent, and round to 1 decimal place
                value = round(numerator/totalEnrollment*100, 1)
                print(schoolData[0][category] + ': ' + str(value) + '%')
        print()
if not found:
    print("Didn't find that school")