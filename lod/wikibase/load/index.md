---
permalink: /lod/wikibase/load/
title: Loading data into a Wikibase
breadcrumb: load
---

# Loading data into a Wikibase using the VanderBot tool

[VanderBot](http://vanderbi.lt/vanderbot) is a Python script that can be used to upload CSV data to Wikidata or any other Wikibase instance. There are [several blog posts and tutorials](https://github.com/HeardLibrary/linked-data/blob/master/vanderbot/README.md#how-it-works) that explain how to use VanderBot to write data to the Wikidata test instance and to Wikidata itself. The focus of this page is using VanderBot to write to other Wikibase instances, such as those on [wikibase.cloud](https://www.wikibase.cloud/) or [Structured data on Commons](https://commons.wikimedia.org/wiki/Commons:Structured_data). 

With the advent of wikibase.cloud, the barrier to entry for setting up your own Wikibase instance has been significantly lowered over setting one up yourself using Docker. With only a few button clicks, you can have a fully functioning Wikibase with a functional Query Service to query its data. However, one of the drawbacks of setting up your own Wikibase is that it starts out empty, meaning that you need to create all of the properties and items yourself. The main purpose of this page is to show you how you can quickly create large numbers of items with VanderBot using data in a spreadsheet.

# The MediaWiki API

One of the reasons people like the Wikidata/Wikibase ecosystem so much is that it has a really great graphical interface for editing. However, it requires many button clicks to edit, so for mass editing many users graduate to some other tool like QuickStatements or OpenRefine. These tools all write to the underlying database that supports Wikibase via the [MediaWiki API](https://www.mediawiki.org/wiki/Wikibase/API) that exists for all Wikibase instances. It is quite painful to interact directly with the API without some software tool, but if you are interested in those sorts of details, see "The MediaWiki API" section of [this blog post](http://baskauf.blogspot.com/2019/06/putting-data-into-wikidata-using.html). We will avoid some of that pain by using the VanderBot script, which mediates the interactions with the API for you. (Another alternative is to use the Pywikibot Python library.  For more information about that option and the problems associated with it, see [this page](../pywikibot/))

## Set up a bot password

To write to any Wikibase, you need to have credentials that can be used to give you write permissions. The process of acquiring these credentials is called "creating a bot password" because they are used by people who create autonomous bots to perform automated editing. Even though we aren't performing automated editing, the process of generating those credentials is the same. NOTE: a bot password gives anyone the ability to make edits under your account! So never include the password in code that you publish or push the credentials to a public repository like GitHub. The advantage of using bot password can be revoked if it's compromised without having to shut down your whole account.

**Downloading the template credentials file**

Open [this page](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/wikibase/api/wikibase_credentials.txt) in a new tab in your browser.  Right-click on the `Raw` button in the upper right of the screen and select `Save Link As...`.  Navigate to the directory where you want to put the script and save the file there. These examples assume that you have stored the credentials in your home directory, so save it there unless you have reasons to do otherwise.

Using a text editor (like TextEdit on Mac, Notepad on Windows, or your favorite text or code editor that is NOT Microsoft Word), open the `wikibase_credentials.txt` file that you just downloaded. Leave the file open as you go to the next step.

**Create a bot password**

The screenshots here show how to create a bot on a Wikibase instance that was hosted on AWS (hence the `18.205.159.211:8181` IP address), but they are the same for any Wikibase.  Start by logging into whatever Wikibase you want to interact with. NOTE: API credentials go across the Wikimedia universe, so if you have an account for Wikipedia, Wikimedia Commons, or the real Wikidata, you can use it to log into any of them to create the credentials to write to any of those platforms (and the Wikidata test instance as well).

<img src="../../../host/wikidata/images/login-link.png" style="border:1px solid black">

1\. In the upper right, click on the login link. If you've set up an account on wikibase.cloud, as an administrator you should be able to create a user acount that's separate from your administrator account. You should use a regular user account when you set up the bot password. You can also create a user account by clicking on the button under `Don't have an account?`.

<img src="../../../host/wikidata/images/special-pages-link.png" style="border:1px solid black">

2\. After you have logged in, click on the `Special pages` link in the left menu.

<img src="../../../host/wikidata/images/special-pages.png" style="border:1px solid black">

3\. On the Special Pages page, click on the `Bot passwords` link. 

<img src="../../../host/wikidata/images/enter-bot-name.png" style="border:1px solid black">

4\. On the Bot passwords page, enter the name of your bot.  It is customary to include the text `bot` somewhere in the bot's name.  You don't need to worry about your bot's name colliding with other bot names because edits will actually be associated with your user account and not the bot name.

<img src="../../../host/wikidata/images/4grants-page.png" style="border:1px solid black">

5\. Check the boxes for permissions to give to your bot.  For the Wikidata test instance or a practice Wikibase instance, you can check all of the boxes.  For a real bot to edit something like Wikidata, you would need to read up on the options before choosing.  Click on the `Create` button. 

<img src="../../../host/wikidata/images/bot-pwd.png" style="border:1px solid black">

6\. A password will be created for your bot.  As the text indicates, there are actually two versions of the username and password.  Use the first one where the username contains "@".

In the credentials file that you left open before, copy and paste your bot's username in place of `User@bot` in the credentials file.  Copy and paste your bot's password in place of the example password in the credentials file.  Make sure that you don't have any trailing spaces after the username and password, or between the equals sign and the text you pasted in.  Save this file.  There is no way to recover credentials once you leave the page, so it might be good to save another copy of the file under a different file name in case you accidentlly write over or delete this one. Of course, you can also just delete this bot password and generate a new one if necessary.



**Figuring out what statement we want to create**

Since this lesson assumes that you already have some experience with editing Wikidata, it assumes that you already know about items and properties. Items have identifiers starting with "Q", like `Q2`.  In the real Wikidata, [the universe](https://www.wikidata.org/wiki/Q1) has the identifier `Q1`.  In the Wikidata test instance, [the universe](https://test.wikidata.org/wiki/Q188427) has the identifier `Q188427`.  Clearly, you cannot assume that there is any relationship between the identifiers assigned to an item in the real Wikidata and the test Wikidata instance.  The same is true for properties.  An important property in Wikidata is `P31` ([instance of](https://www.wikidata.org/wiki/Property:P31)), which is used to indicate what kind of thing the item is.  In the Wikidata test instance, [instance of](https://test.wikidata.org/wiki/Property:P82) is the property `P82`.  
The example bot script is set up in lines 129-131 to create the statement

```
Q188427 P82 Q1917
```

that is, "the universe is an instance of a cat".  Before you run the script, you need to go to the Wikibase test instance and check whether someone else who has run this script has already asserted that the universe is a cat.  If so, you should manually delete the statement by clicking on the `edit` link, then selecting `remove`.  Alternatively, you can change the script to assert something different about the universe.  Whatever the case, you should make sure that the statement you plan to create does not already exist, then use a text editor to edit lines 129-131 so that the subject, property, and object (`sub`, `prop`, and `obj`) have the appropriate values for the statement you want to make.



## Preliminaries

**Accessing Wikibase**

If you don't have access to an online instance of Wikibase, you can install a local instance on your own computer using [these instructions](../../../lod/install/#using-docker-compose-to-create-an-instance-of-wikibase-on-your-local-computer).  After you have access to an instance, go back to the [instructions for creating a bot](#set-up-the-bot) and generate a bot username and password there as you did for the Wikidata test instance. Then change the credentials.txt file to username and password, and change the value of `endpointUrl` to the URL of your Wikibase instance.  If you are running it locally on your own computer, the URL will probably be `http://localhost:8181`.

**Preparing the data to be added**

Go to [this page](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/wikibase/cartoons.csv) and download the file `cartoons.csv` into the same directory where you downloaded the first bot script.

Using your spreadsheet program, open the file.  

<img src="../images/csv-file.png" style="border:1px solid black">

In this table, each row represents an item that will be created in the Wikibase database.  When it is created, it will be assigned the next available item identifier (begins with `Q`).  Every item should have an English label (in the first column named `enLabel`) and an English description (in the second column named `enDescription`).  It is also possible to have zero to many additional labels and descriptions in other languages.  In this example, there is a second set of labels in Spanish in the `esLabel` column.  

The other columns contain the values for the properties used as the column headers. To see the available properties, go to `Special pages` then `List of properties` in the `Wikibase` section.

<img src="../images/list-properties.png" style="border:1px solid black">

The column header for a property should consist only of the property identifier (`P` followed by a number) and nothing else.  In the example spreadsheet, the fourth column is headed by `P6` and comparison with the list of properties shows that `P6` is "instance of".  

<img src="../images/instance-of.png" style="border:1px solid black">

Clicking on the P6 link takes us to the page for the `instance of` property.  An important thing to notice is that the Data type of the property is `item`.  **The value used in the table must match the Data type of the property!** Since P6 requires an item, all of the values in the P6 column are item identifiers (starting with `Q`): `Q3058`. As the script is currently written, only items can be give as values of properties. However, the script could be easily modified to allow string values or other types of values.  More on this in the comments at the end.

<img src="../images/search-box.png" style="border:1px solid black">

Q3058 is "cartoon character" and we can see its entry by starting to type "cartoon" in the search box at the upper right.  

<img src="../images/cartoon-character-page.png" style="border:1px solid black">

Wnen we click on the entry we want, its page will come up.  You can find the page for any Q identifier by changing the end of its URL to the appropriate identifier.

**Adding properties**

If a property that you want to assign to the items that you are creating with your bot doesn't exist, you will need to create the property by going to `Special pages`, then `Create a new property` in the Wikibase section. 

<img src="../images/partner-property.png" style="border:1px solid black">

Above is an example of a property that I could use to link Mickey Mouse to Minnie Mouse.  

<img src="../images/partner-property-created.png" style="border:1px solid black">

When I click `Create`, I see the page for the newly created property.

**Adding items**

The reason that you are using the bot is because you want to create a lot of items.  However, you may want to manually create items to be used as the values of properties.  For example, in the spreadsheet, property P9 is "part of universe" and is used to connect a cartoon character to its "universe" (Disney = Q3070, Looney Tunes = Q3076, etc.).  If I want to add another universe, such as Marvel, I need to go to `Special pages` then `Create a new item` in the Wikibase section.  

<img src="../images/create-new-item.png" style="border:1px solid black">

If I want to add another universe, such as Marvel, I need to go to `Special pages` then `Create a new item` in the Wikibase section. 

<img src="../images/marvel-universe.png" style="border:1px solid black">

After I enter the information and click `Create` I'll see the page for the new item and can get the item's Q identifier (Q3340 in this case) to use in the column in the spreadsheet.

**Note: be sure that you remember to save your spreadsheet in CSV format before moving on to the next section!**  If it was opened as a CSV, it should be saved in that format by default.



----
Revised 2023-02-07
