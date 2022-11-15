---
permalink: /script/codegraf/009b/
title: CodeGraf - Extracting and changing DataFrame data
breadcrumb: OO9b
---

Previous lesson: [DataFrame manipulation](../009a)

# Extracting and changing DataFrame data

The common theme in this lesson is passing integer ranges or boolean Series into the `.loc[]` or `.iloc[]` indexers to select multiple rows or columns of a DataFrame. This allows you to change many cells within the DataFrame in a single operation without needing to iterate through the rows. In some circumstances where this vectorized approach is not possible, the `.iterrows()` method can be used to iterate through the rows and perform operations on the rows one at a time.

**Learning objectives** At the end of this lesson, the learner will:
- slice rows using the `.head()` or `.tail()` method.
- slice rows using a range or list of label indices.
- slice a rectangular selection of a DataFrame by specifying both row and column ranges.
- slice columns by specifying no upper or lower bounds in the row range of a rectangular selection.
- delete rows or columns using `.drop()` and the `.index` or `.columns` attributes of a slice.
- slice rows based on logical conditions by passing a boolean Series into `.loc[]`.
- slice columns based on logical conditions by passing a boolean Series into `.loc[]` as the column selector and specifying no upper or lower bounds in the row range.
- change particular cell values in a DataFrame based on boolean conditions applied to a column.
- use the `.iterrows()` method to perform operations on rows in a DataFrame one at a time.

Total video time: 25m 29s

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/009/009b.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/1wG-wmvyIPbUaCt5EcKd9UqFx3hj7wHaB)

[Lesson slides](../slides/lesson009b.pdf)

# Introduction (1m02s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/va9KUu1krEY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

## Slicing rows (5m17s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/41QXKScIKbM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Rectangular slices and slicing columns (2m25s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Y2zk-1fhbdU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Dropping a range of columns or rows (2m53s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/FsnYYZSycr4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Slicing rows by boolean condition (7m00s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/8cbDPWhQwlo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Changing individual values by boolean condition (2m41s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/bQulpPz7xdc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Iterating through DataFrame rows (4m11s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4x6C2VLtDoU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

# Practice exercises

Under construction

----

Optional lesson: [Summarizing and rearranging DataFrames](../009c)

Next regular lesson: [Introduction to plotting](../010)

----
Revised 2022-11-14
