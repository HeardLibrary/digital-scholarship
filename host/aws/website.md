---
permalink: /host/aws/website/
title: Static website on AWS
breadcrumb: website
---

# Accessing bucket objects via HTTPS

To allow access to an object in a bucket through HTTPS, you must make both the bucket and the object within it publically accessible.

## Unblock public access to bucket

You can edit public access for bucket when creating the bucket or afterwards.

Uncheck "Block all public access".

## Make an object publically available

Upload an image:

Select the image, but click `Next` rather than `Upload`.

<img src="../images/grant-access.png" style="border:1px solid black">

In the Set permissions step, grant public read access.

<img src="../images/set-properties.png" style="border:1px solid black">

In the Set permissions step, set the Content-Type header to an appropriate value and click Save. (You might be able to get away with skipping this step depending on the type of file.)

Then click upload.

<img src="../images/image-listing.png" style="border:1px solid black">

Click on the name of the image in the file listing.

<img src="../images/object-url.png" style="border:1px solid black">

Copy the Object URL and paste it into a new tab of your browser.  The image should display in the browser.

## Making a web page

Using a text or code editor (TextEdit for Mac, Notepad for Windows, or a code editor like VSCode), paste the following:

```
<html>
  <body>
    <h1>My Awesome Website</h1>
    <img src="logo.jpg"/>
    <p>My organization has a great logo.</p>
  </body>
</html>
```

Substitute the name of the image you uploaded in place of "logo.png". Save the file somewhere where you can find it.

Upload the `index.html` file as you did the image, except for the Content-Type header use `text/html`.

Find the object URL as you did before and paste into your browser.

<img src="../images/web-page.png" style="border:1px solid black">

Your web page should show up in the browser window.

# Creating a more sophisticated website

This is just a quick and dirty web page.  For creating a real static website using S3, you will probably want to do some more sophisticated things like associating a domain name with the site, redirects from similar subdomains, tracking usage, etc.  AWS has built in capabilities for doing all of these things.  See [this page](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) to get started.  See also [this blog post](https://douglasduhaime.com/posts/s3-lambda-auth.html) for information about allowing access to a static website using authentication.

----
Revised 2019-11-03
