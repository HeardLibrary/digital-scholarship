import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
import requests
import csv

# hacked from https://heardlibrary.github.io/digital-scholarship/script/python/inout/#reading-from-csv-files-from-the-web
r = requests.get('https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv')
fileText = r.text.split('\n')
fileRows = csv.DictReader(fileText)
schoolData = []
for row in fileRows:
    schoolData.append(row)

# created from knowledge of Python lists, dictionaries, and tuples
schoolIDs = ['450', '290', '497']
schoolNameList = []
aamList = []
whitelist = []

for dispaySchool in schoolIDs:
    for school in schoolData:
        if school['School ID'] == dispaySchool:
            schoolNameList.append(school['School Name'])
            aamList.append(int(school['Black or African American']))
            whitelist.append(int(school['White']))
schoolNameTuple = tuple(schoolNameList)
aamTuple = tuple(aamList)
whiteTuple = tuple(whitelist)

# hacked from https://matplotlib.org/gallery/lines_bars_and_markers/bar_stacked.html#sphx-glr-gallery-lines-bars-and-markers-bar-stacked-py
N = 3
ind = np.arange(N)    # the x locations for the groups
width = 0.35       # the width of the bars: can also be len(x) sequence

p1 = plt.bar(ind, aamTuple, width)
p2 = plt.bar(ind, whiteTuple, width,
             bottom=aamTuple)

plt.ylabel('students')
plt.title('Distribution by race')
plt.xticks(ind, schoolNameTuple)
plt.yticks(np.arange(0, 1200, 100))
plt.legend((p1[0], p2[0]), ('Black or African American', 'White'))

plt.show()
