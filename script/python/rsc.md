---
permalink: /script/python/rsc/
title: RSC API project 
breadcrumb: API project
---

# Royal Society of Chemistry API project

## Preliminaries

Go to the RSC Developers Portal <https://developer.rsc.org/home> and register to get an account.  The account is free for up to 1000 API calls per month.

Log into your account (if necessary) and click on the `My Keys` tab.  Click on `Add a new Key`.  Copy the Consumer Key and paste it somewhere where you can find it.

## Part 1: Present choices

**Goal:** to present the user with options for the output that they want to get from the API.

**Specifics:** 
- Print the options to choose from.  "f" for formula, "w" for molecular mass, "c" for common name, and "3" for "3D structure" 
- The user types between 1 and 4 of these characters, then presses Enter.
- Print back to the user the string they typed in.  

## Part 2: Check whether the user typed anything

**Goal:** to end the program if the user didn't enter anything

**Specifics:**
- Start with the code above.  If the user pressed Enter without typing anything the value assigned to the string variable by the input function will be an empty string (represented by `''`).  
- Use an IF statement to check for the empty string.  If they entered the empty string then print an error message and execute the `quit()` function. 
- If they entered a string, then continue to the next part of the program and ask the user for the common name of the compound they want to search for.  Again, check whether they typed anything or not, and give an error message and quit the program if they didn't type anything.  If they did enter a compound, print both the compound they entered and the string of their option choices.  

## Part 3: Create the list of fields to return

**Goal:** to create a list of fields to return based on the option letters the user entered.

**Specifics:** 
- Create an empty list to hold the field list.
- Create a list of strings.  Each string is one of the four possible option letters they could pick.
- Iterate through each of the option strings in the list.
- In each loop, check whether the option string for that iteration is in the option choice string.  If it is, then add the appropriate field string to the field list.  Here are the strings: `Formula` for "f", `MolecularWeight` for "m", `CommonName` for "c", and `Mol3D` for "3".  Use the `.append()` method to add the field string to the list.
- Print the list that you created.

