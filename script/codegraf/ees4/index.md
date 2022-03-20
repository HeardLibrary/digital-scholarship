---
permalink: /script/codegraf/ees4/
title: EES 2580 - Conditional execution
breadcrumb: ees4
---

Previous lesson: [Dictionaries and loops](../ees3)

# Conditional execution - EES 2580

In this lesson we will learn several ways to control the flow through statements in your code. We will use variations on `if` statements to do general conditional execution and use `try` ... `except` ... statements to trap errors. We will also examine how flags can be used to track conditions in the script and to assist in the decision-making process.

**Learning objectives** At the end of this lesson, the learner will be able to:
- compare the procedural and vectorized approaches to programming.
- use `if`, `elif`, and `else` to control execution of code blocks in a script.
- explain how indentation affects the execution of code blocks.
- create names for variables to hold boolean values that indicate the state that the variables describe.
- use a flag to determine whether a condition ever occurred during a loop, or whether a condition never occurred during a loop.
- use `try` and `except` to control the behavior of a script when errors occur in particular lines of code.

Total video time: 44 m 08 s

## Links

[Lesson Colab notebook](https://colab.research.google.com/drive/1euO9JyAfVD4pUHjquQbgJjf8cKT4iB6L?usp=sharing)


# Procedural vs. vectorized paradigm (4m 10s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/joHgR4vtnuY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

# Conditional execution

## if statements (9m 29s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/12r7CQzshHw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Code example and notes:

```python
name = 'Fred Flintstone'

# Evaluate the boolean value of is_micky based on the comparison of name and 'Mickey Mouse'
is_micky = name == 'Mickey Mouse'
print(name)
print(is_micky)

if is_micky:
    print('You are a Disney character')
print('That is all!')
```

Notes:
1. The double equals sign `==` is a comparison operator to test for equality.  When `name == 'Micky Mouse'` is evaluated, the resulting boolean value is assigned to the variable `is_micky`.  Other conditional operators are: `!=` (not equal), `>` (greater than), `<=` (less than or equal to), etc.
2. The `if` statement controls whether the code block following the colon is executed or not (don't forget the colon!).  If the value following the keyword `if` has a value of `True`, then the code block is executed.  If the value is `False`, the code block is not executed. 
3. As with code blocks in functions, the code block here is demarcated by indentation (of the standard four spaces).  In this example, there is only one line in the indented code block, but there could be many.
4. The `print 'That is all!'` statement is not included in the code block, so it will be executed regardless of the condition.


----

## else and elif (7m 35s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/1yoVZQfkxTY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`else` code example and notes:

```python
name = input('What is the name of the character? ')
print(name)

if name == 'Mickey Mouse':
    print('You are a Disney character')
    print('You are almost ready to go out of copyright!')
else:
    print('You are not a Disney character')
print('That is all?')
```

Notes:
1. The input statement allows users to enter their choice of name.
2. If the input name is equivalent to `Mickey Mouse`, the indented block after the `if` clause is executed.
3. Otherwise, the indented code block after the `else` clause is executed.
4. The unindented code of the last line is always executed.

We could nest `if` statements inside `else` clauses like this:

```python
name = input('What is the name of the character? ')

if name == 'Mickey Mouse':
    print('You are a mouse')
else:
    if name == 'Donald Duck':
        print('You are not a mouse')
    else:
        if name == 'Minnie Mouse':
            print('Your boyfriend is getting old')
        else:
            print('You are not a Disney character')
print("That's all folks!")
```

Each of the subsequent `if` clauses is executed only if the previous ones were `False`. One problem with this structure is that it results in a complicated structure that is hard to read because of the many indentation levels. 

The structure can be simplified by replacing elses that are followed immediately by ifs with a different keyword: `elif`. Each `elif` clause is only executed if the previous clauses are `False`. 

`elif` code example and notes:

```python
name = input('What is the name of the character? ')

if name == 'Mickey Mouse':
    print('You are a mouse')
elif name == 'Donald Duck':
    print('You are not a mouse')
elif name == 'Minnie Mouse':
    print('Your boyfriend is getting old')
else:
    print('You are not a Disney character')
print("That's all folks!")
```

----

# Flags (9m 37s)

Sometimes we use a programming device called a *flag* to keep track of the state of some condition. In Python, it is convenient for a flag to contain a boolean and for the name of the flag to be some indication of the state that is being tracked. For example, if our script is monitoring the status of a door, we might use the variable name `door_open`, and assign it a value of `True` or `False`.

<iframe width="1120" height="630" src="https://www.youtube.com/embed/DCxP-Us7hpQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

*Note to all English majors:* I should have said "None of your numbers **were** even." but I didn't want to redo the whole video!

A typical use of a flag is to determine that a certain condition happened or never happened during a loop. In this example, we want to check a list of numbers and report if any of them were even. Try making some of them even or none of them even. When you are clear about how the code works, you can delete `print(number % 2)` or "comment it out" (make it stop working by putting a # in front of it).

```python
numbers = [3, 4, 453, 99, 19, 50]
was_an_even = False

for number in numbers:
    # The % (modulo) operator gives the remainder after a division.
    # Even numbers have no remainder when divided by 2.
    if number % 2 == 0:
        was_an_even = True

if was_an_even:
    print('At least one of your numbers was even')
else:
    print('None of your numbers were even')
```

Note: 
1. When writing boolean values in your code, make sure that you do not include them inside quotes. `True` is a boolean literal. `'True'` is a string.
2. The % (modulo) operator gives the remainder after a division. Even numbers have no remainder when divided by 2. So `number % 2` will be zero for even numbers and one for odd numbers.

When using a flag, we set the flag to the boolean state that indicates that the condition has never happened. Then when it happens in the code, we change the value to the boolean state that indicates that it did happen. Note that the naming of the flag can indicate change whether we expect the state to be `True` or `False`. For example, we could change the name of the flag in the code above like this:

```python
numbers = [3, 4, 453, 99, 19, 50]
no_evens = True

for number in numbers:
    if number % 2 == 0:
        no_evens = False

if no_evens:
    print('None of your numbers was even')
else:
    print('At least one of your numbers was even')
```

----

## Complex flag example (6m 11s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/1yN_zjZQbJE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Here is a more complicated example where we want to know if there were no matches when we checked a list of items. In this case, we only care about giving feedback if we got all the way through the list without a match.

```python
character_name = ['Mickey Mouse', 'Donald Duck', 'Minnie Mouse', 'Fred Flinstone', 'Daffy Duck', 'Elmo Jetson']
character_company = ['Disney', 'Disney', 'Disney', 'Hanna-Barbera', 'Warner Brothers', 'Hanna-Barbera']

no_characters = True
my_company = input('What film company do you want to check? ')

for company_number in range(len(character_company)): # if no starting number given, 0 is assumed.
    if character_company[company_number] == my_company:
        no_characters = False
        print(character_name[company_number], 'works at', character_company[company_number])
        
if no_characters:
    print('No characters work for your company')
```

**Note about using `range()`**

When we use `range()`, we can specify the start and end of the range like this:

```
range(0, 4)
```

which can be used to iterate through the numbers 0, 1, 2, and 3. If we omit the first number, a starting number of 0 is assumed, so

```
range(4)
```

will iterate through the same series of numbers as before. Recall that the end of the range is one number larger than the last number in the iteration. So if I want to iterate through a list with four items:

```
animals = ['cat', 'slug', 'bee', 'sponge']
```

by their indices, I would need to iterate through items 0, 1, 2, and 3. Therefore I could generate this sequence using `range(4)`. Since the number of items in the list (`len(animals)`) is 4, I can use 

```
range(len(animals))
```

to generate the range of indices for the list. This is a generalized solution for a list of any length, so it is better than hard-coding the number of items in the `range()` expression. If the number of items in the list changes or is not known in advance, this expression will always generate the indices of every list item.

----

# Error trapping (7m 06s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/xKbfRXNMDNk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

If a user enters the wrong type of object, it can cause an error that will interrupt the execution of the script. We can guard against this using `try` ... `except`. The indented block following the `except` clause is executed when an error is thrown. Here is an example:

```python
from math import pi
typed_in = input('What is the diameter of your circle? ')
try:
    diameter = float(typed_in)
    print('The circumference is:', diameter * pi)
except:
    print("Sorry, you didn't enter a number.")
```

Here is another example to handle the situation where the script tries to access a dictionary item whose key does not exist:

```python
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
part_number = input("What part do you want to order? ")
try:
    print('You have ordered a ' + catalog[part_number])
except:
    print("Sorry, that part isn't available.")
print("It's been a pleasure doing business with you!")
```

----

# if ... in ... (optional)

Another condition we can test for is whether a particular item is included in an iterable object using the `in` keyword. Consider the following code:

```python
test = int(input())
if test in range(0,5):
    print(True)
else:
    print(False)
```

If the number entered is 0, 1, 2, 3, or 4, `True` will be printed. Here's another example:

```python
animal = input()
if animal in ['dog', 'cat', 'snake', 'bird']:
    print(True)
else:
    print(False)
```

If the input animal name is one of those in the list, `True` will be printed.

This approach provides an alternative way to make sure that a dictionary key exists before trying to retrieve its value. There are several methods associated with dictionary items: `.keys()`, `.values()`, and `.items()`. Each of these methods produces an iterable data structure containing parts of the dictionary. For example, `catalog.keys()` will enumerate all of the keys in the dictionary and `catalog.values()` will enumerate all of the values. Here's how we can use that information to avoid a "KeyError" error:

```python
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
print(catalog.keys())

part_number = input("What part do you want to order? ")
if part_number in catalog.keys():
    print('You have ordered a ' + catalog[part_number])
else:
    print("Sorry, that part isn't available.")
print("It's been a pleasure doing business with you!")
```

The structure of this code is similar to what we used in the `try...except...` example, except that instead of trying to retrieve the value of the input key and handling the exception (i.e. error) if it fails, we check whether the key exists using an `if...in...` statement and handle the `False` condition with the `else:` code block. 

# Tuples (optional)

*Tuples* are a sequential data structure similar to lists. The items in a tuple can be referenced by indices, just like lists, but those items cannot be changed once the tuple is created. Literal tuples can be created by placing a list of objects in parentheses, like this:

```
animals_tuple = ('dog', 'cat', 'snake', 'bird')
print(animals_tuple[0])
print(animals_tuple[3])
```

The `.items()` dictionary method generates an iterable object consisting of a sequence of tuples where each tuple is a pair consisting of a key and its corresponding value. We can use this code to explore how the `.items()` dictionary method works:

```python
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
print(catalog.items())
for item in catalog.items():
    print(item, type(item))
```

We can *unpack* a tuple by assigning it's parts to a sequence of variable names. The number of variable names must be the same as the number of items in the tuple. Here's an example:

```
number, string = (1, 'xyz')
print(number, string)
```

If we iterate through the item tuples that result from the `.items()` method, we can unpack them into separate `number` and `part` variables. Those variables can be used to print out the catalog to help users make a choice.

```python
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
print('number', 'part')
print('-----------')
# Assign each key and value from the dictionary item to its own variable
for number, part in catalog.items():
    print(number, part)
print()

part_number = input("Enter the number of the part you want to order: ")
print()
if part_number in catalog.keys():
    print('You have ordered a ' + catalog[part_number])
else:
    print("Sorry, that part isn't available.")
print("It's been a pleasure doing business with you!")
```


# Practice exercises

**Instructions:** Go to the [practice assignment Colab notebook](https://colab.research.google.com/drive/1COsWYZ_32OXk3FZm_PxMXtDZ4TOh-V7M?usp=sharing) and make a copy in your own drive as you did the practice notebook. Put you name in the first text cell and save the notebook.

1. Yale University has an awesome website known as "Is it chicken tenders day?".  The website is at <http://www.isitchickentendersday.com/> and you can read about it [here](https://yaledailynews.com/blog/2011/09/08/is-it-chicken-tenders-day-question-answered-in-new-website/).  Using the website, you can determine whether it is chicken tenders day (i.e. Thursday) in the Yale residential dining halls. The `date` object from the `datetime` module has a *method* that determines the day of the week as a number (0=Monday, 1=Tuesday, etc.).  It's `date.today().weekday()`. From the `datetime` module import the `date` object. Begin your script by printing the question "Is it chicken tenders day?". Then use `if` and `else` to print `yes` if it's chicken tenders day and`no` for any other day.

2. Create a list containing the names of the days of the week. Start with Monday and end with Sunday to match the numbering produced by the `.weekday()` method. Modify the program above by adding a line to tell the user what the day of the week is today. You can use the output of the `.weekday()` method as the index number when referring to your list.

3. Have the user input two numbers. Set the value of a flag called `is_zero` to have a boolean value of `True` if they entered a `0` character for the second number and `False` if they didn't. Convert the two numbers to a floating point number using the `float()` function. Calculate the first number multiplied by the second number and report the answer to the user. Calculate the first number divided by the second number.  Since dividing by zero generates an error, only print the result of this calculation if the value of `is_zero` is not `True`.  Note: you can test for the negative of a condition by saying `if not is_zero:`. Another alternative syntax is `if not(is_zero):`. Print the answer to the division only if it's not division by zero.

4. Write a second version of the previous script. Instead of using a flag, let the error occur and handle it using `try ... except ...` . Enclose the division calculation in a `try:` code block. Handle the division by zero case in the `except:` code block.

5. Create a flag called `has_dash` and set its value to boolean `False`. Ask the user to enter a name string like `Huang Li` or `Lord Baden-Powell`. Use a `for` loop to iterate through all of the characters in the string. For each character, check whether it is a dash or not. If a dash is discovered, change the value of the `has_dash` flag to true. At the end of the script, if the name includes a dash, print `That is a hyphenated name.`

6. In the error trapping examples, we have "gracefully" handled user input errors by printing some kind of message rather than letting the script crash. However, it would be better to let the user try again to enter correctly. The next several exercises will give you a chance to develop "bullet-proof" input code that gives the user a do-over if they make a mistake. **Part 1.** Use an input statement to let the user enter a number as a string. In a `try:` code block, convert the entered string to a floating point number using `float()`. Follow the conversion statement with a statement that prints the number. In the `except:` code block, print a warning to the user that they didn't enter a number. 

7. Important note: If you create an infinite loop in a cell of a Jupyter notebook, you can make it stop by clicking on the black square "stop" button at the top of the notebook. In a Colab notebook, a code cell that is running can be stopped by clicking again on the same button you used to start the cell running. While it is running, that button should have a "stop" square in the middle of it. **Part 2.** We can use a `while` loop to keep repeating code blocks until some condition changes from `True` to `False`. In this example, the code block to be repeated is the input code that you just wrote. It should be repeated an indefinite number of times until the user enters correctly. Set up the while loop by highlighting the code you've already written, then press `tab` to indent the whole block 4 spaces. The condition we will evaluate is the state of a flag variable named `try_again`. Since the while loop will only be executed when a condition is true, set the value of `try_again` to be `True` at the top of your code. Then just before the indented code block, insert the statement `while try_again:`. As the code stands now, the indented code block will be executed an infinite number of times because the flag `try_again` has no way to change from `True` to `False`. When the code block is finished, execution will return to the `while` statement and since `try_again` hasn't changed, the indented code will be executed again (and again, and again, ...). So we need to insert `try_again = False` somewhere in the code. Where can we put it so that the flag will be changed after we know that the input was correct? After you've figured out where to put the `try_again = False` statement, test your code. When you are convinced that it works, delete the statement that prints the number. At the top of your code, add an statement that imports `pi` from the `math` module. At the end of your code, calculate and print the circumference assuming that the entered number is a diameter. 

8. **Part 3.** The code we created in the last exercise is a bit rude because you must either correctly enter a number, or be forced to keep trying again and again until you get it right. A more "polite" script would give the user an option to quit without entering any number. Modify your code from the previous exercise by adding after the input statement an `if` statement that checks whether the user entered an empty string (`''`) by pressing the `Return` or `Enter` key without typing anything. Since the `if` statement is in the middle of a `while` loop, we have to break out of the loop. You can do that by issuing the single word statement `break`. Unfortunately, if you break out of the loop without entering anything, your statement printing the circumference of the circle won't make sense. So before the `break` statement, you could set another flag called something like `no_print` equal to `True`. (Of course, that would mean that at the start of the script you would need to set `no_print` equal to `False`.) Then at the end of the script, you can make the printing of the circumference conditional depending on whether `no_print` were `True` or not.

----

This is the end of the EES 2580 Beginning Python module. 

If you want to continue on with lessons on vectorized programming with Pandas, you can begin the lesson on [NumPy arrays](../007)

Continue to the intermediate series on [files and tables](../020)

----

Revised 2022-02-28