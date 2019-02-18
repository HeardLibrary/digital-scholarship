---
permalink: /script/python/hack/
title: Practical problem solving
breadcrumb: Hacking
---

Note: this is the sixth and final lesson in a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[prevous lesson on input and output](../inout/)

Answers for last week's challenge problems:

1\.a. [Print school data](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/schools_a.py)

  b. [School data, case insensitive](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/schools_b.py)

  c. [School data, partial search string](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/schools_c.py)

2\.a. [Advanced cartoon checker](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoon_checker_a.py)

  b. [Cartoon checker with Wikidata search](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoon_checker_b.py)

  c. [Super cartoon checker with Wikidata search and GUI ](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/pylesson/challenge4/cartoon_checker_c.py)


# How to Hack (a.k.a. practical problem solving)

The primary goal of these lessons has been to give you the skills necessary to solve practical problems using Python (as opposed to teaching you to be a Python developer).  Since there is a virtually limitless number of possible problems, there is no way to provide a simple method for attacking them.  However, there are some strategies that you can use to help you solve problems in an efficient way.

## Google searches

As with most other computer users in the 2010's, my first inclination when faced with a technical problem is to conduct a Google search.  However, I've had varying levels of success depending on how I frame the queries.

One tip is to begin the query with "Python 3" (e.g. "Python 3 use API").  This helps screen out search results for languages other than Python and results that are based on Python 2.  If the problem you are trying to solve involves an error, copy and paste the exact error message into the search bar.  About 90% of the time, someone else will have had the same problem as you and the solution often will be clear.

You will commonly get a variety of kinds of results that may include blog posts, Stack Overflow questions and answers, YouTube videos, reference materials, and courses and tutorials.  You can usually tell from the results titles how useful the results might be.  I generall skip over the first "sponsored" search results since someone paid for them to be there, not because they are most helpful. 

If you can find a good blog post where the writer is talking about solving your exact problem, that is usually the most helpful because a good post will often outline the issues and also provide code examples.  Stack Overflow questions/answers can also be very helpful IF the problem is exactly the same as yours.  Often the Stack Overflow question from the Google search result is somewhat different, but listed under the question are related questions and you can often find another question that is nearly identical to the problem you are trying to solve.  The other issue with Stack Overflow is that the answers may be over your head if you are a Python beginner.  For example, sometimes answers will involve complex object-oriented approaches.  But other answers (or other questions' answers) may provide a different code example that is less elegant, but easier to understand.  So don't give up!

I generally do not like YouTube videos because they take to long to assess whether they will actually be helpful or not.  

## Authoratative websites and reference materials

An obvious source of information is an authoritative website (for example the official Python documentation at <https://docs.python.org/3/>).  The answer that you want is almost always there.  However, because reference materials tend to be comprehensive, there is also information about many other things that are NOT the problem you are trying to solve.  So it may take more time to find what you want than just finding a blog post or Stack Overflow question.  Nevertheless, the official documentation is often helpful if you want to know things like all of the possible parameters and settings associated with a certain function.  

In the case of packages, the package developer will often have instructions specific to the package at either GitHub or at readthedocs.org .  These instructions range from extremely helpful and clear (with examples) to terse and obtuse.  So it's worth giving them a look and then deciding whether it's worth your time to plow through them.  

In some cases, your question may involve some kind of standard.  Usually standards documents are very technical and dense, so they usually aren't the best place to look for help.  However, they are sometimes accompanied by a companion "primer" document with examples and simplified explanations.  Those are usually really helpful.

## Resorting to lessons

Depending on your learning style, you might opt for trying to find a tutorial or lesson that will help you systematically learn about the topic you are trying to hack.  I am usually too impatient for lessons, but if you are feeling less confident, they might be right for you.  I find W3School-style lessons (e.g. <https://www.w3schools.com/python/>) very helpful because they are usuall broken down into small chuncks that are focused on particular topics, usually provide easy-to understand examples, and sometimes have a "TryIt" editor that will allow you to actually run and modify the sample code.  This can be really helpful if you are trying to understand the basic concepts that underly your problem.  

There are also good YouTube lessons out there, but they require a greater time investment to check out.

I will also confess to actually having paper books for reference.  I am often too impatient to look things up in them when Googling is an option, but sometimes books are the best solution, especially when you need a sequential explanation from simpler to more complex aspects of a problem.  I am partial to books in the O'Reilly series because they often oriented towards beginners and are not thick reference books that contain so much information that it's difficult to find what you want.  Of course, you have to pay for them...

Finally, I should mention that there are good online courses that you can pay to take.  I generally do not want to spend the time or money on them, but if you feel that you need a strong background in an entire area of programming, they might be an option for you.  However, they may be geared towards people trying to upskill to a coding career, and might be more comprehensive than is necessary for someone who simply wants to use Python to solve a particular problem.

# Example: Understanding API authorization

In trying to use several APIs, I was struggling with understanding how the OAuth2 authorization protocol worked in Python.  

After reading and being confused by many web pages, I found two blog posts that helped me discover the information I needed. [The first post](https://medium.com/google-cloud/understanding-oauth2-and-building-a-basic-authorization-server-of-your-own-a-beginners-guide-cf7451a16f66) had easy-to-understand diagrams with step-by-step explanations for each diagram.  [The second post](https://aaronparecki.com/oauth-2-simplified/) had example HTTP requests that corresponded to each of the diagrams in the first post, and had a very clear explanation (with pictures) of the circumstances under which you'd use each kind of OAuth2 authentication.  By comparing the two blog posts, I was able to understand that the simplest "[Application access](https://aaronparecki.com/oauth-2-simplified/#others)", a.k.a. "client credentials" authentication was what I needed and I could ignore the more complicated authentication systems designed for mobile apps and websites.

After reading a number of Stack Overflow questions, it was clear to me that among the various Python packages that could do OAuth2 authentication, the "Requests-OAuthlib" library was the most commonly used.  It also had a pretty good [readthedocs instruction page](https://requests-oauthlib.readthedocs.io/en/latest/) with actual Python code examples.  After comparison of its examples with the two blog posts, it became clear to me that the "[Backend Application Flow](https://requests-oauthlib.readthedocs.io/en/latest/oauth2_workflow.html#backend-application-flow)" example was actually the same as "Application access" and "client credentials" systems.  So I was able to hack their example code to retrieve data from the Twitter API using a Twitter ID and secret that I had acquired from Twitter.  Here's the code I ended up with:

**Code to get an access token**

```Python
from oauthlib.oauth2 import BackendApplicationClient
from requests_oauthlib import OAuth2Session

clientKey = 'client key goes here'
clientSecret = 'client secret goes here'
requestTokenUrl = 'https://api.twitter.com/oauth2/token'

clientObject = BackendApplicationClient(client_id=clientKey)
oauth = OAuth2Session(client=clientObject)
accessToken = oauth.fetch_token(token_url=requestTokenUrl, client_id=clientKey, client_secret=clientSecret)
# access token should be cached/saved and used repeatedly rather than making many requests fo a new token
print(accessToken)
```

**Code to retrieve Tweets from a user's timeline**

```Python 
import requests   # best library to manage HTTP transactions

bearerAccessToken = 'access token from first program goes here'
# GET statuses / user_timeline Returns a collection of the most recent Tweets posted by the indicated by the screen_name or user_id parameters.
resourceUrl = 'https://api.twitter.com/1.1/statuses/user_timeline.json'
paramDict = {'screen_name' : 'put twitter handle here', 'count' : '3', 'exclude_replies' : 'true', 'include_rts' : 'false'}
r = requests.get(resourceUrl, headers={'Authorization' : 'Bearer '+ bearerAccessToken}, params = paramDict)
data = r.json()
print(data)
```

This took a lot of time and effort to achieve, and it required basic understanding about JSON, HTTP, dictionaries, and the requests module.  But with some digging and sorting out the helpful information from the giant mass of confusing information, I was able to solve the problem.  And now I have some basic code that I can reuse any time I need to retrieve data from an API that uses OAuth2 authentication.  

Revised 2019-02-18
