---
permalink: /script/python/authenticate/
title: Authenticating to use an API
breadcrumb: Authenticate
---

Note: this is an addendum lesson to a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[prevous lesson on data from the Internet](../internet/)

# Get a Twitter developer account

![](../twitter/accept.png)

Accept the user agreement.

![](../twitter/dropdown.png)

Go to the menu in the upper right and select `Apps`.

![](../twitter/createApp.png)

Click on the `Create an app` button.

![](../twitter/describe.png)

Fill in the App name and description.  The name has to be unique, so include your Twitter handle in it.  For the description, you can say that it is a classroom project to learn how to use an API in Python.  For the Website URL, you can use your website or the Python Working Group web page.  Do not enable Sign in with Twitter.  Leave the rest of the stuff blank except for the required "Tell us how this app will be used" box.  Again, you can explain that it is a class project to learn how to use an API.  Your explanation has to be at least 100 characters.

Read the next popup, then click `Create`.

![](../twitter/clickkeys.png)

Click on the Keys and tokens tab.

![](../twitter/keys.png)

Copy your API key and API secret key from the next screen.  You will need them for the next part of the exercise.  Don't use the ones in this picture because they have been revoked and new keys have been regenerated.

**Note:** When the class is over, I'm going to boot you off the team.  You will be able to continue to use the App you've created, but won't be able to create a new one without applying for your own developer account.

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
 

-----
Revised 2019-04-18
