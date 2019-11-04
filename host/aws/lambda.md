---
permalink: /host/aws/lambda/
title: Creating a serverless application using AWS Lambda
breadcrumb: lambda
---

# Creating a serverless application using AWS Lambda

In [the previous lesson](../translate/) we ended by creating a Python script that would invoke the Amazon Translate service when we ran it on our local computer.  This required that the user have permissions to use the Transcribe service and required installation of Python and the `boto3` module on the user's computer.  In this lesson, we'll create the same script, but rather than having it run on the user's computer, we will have it run in the ASW cloud.

## What's a Lambda?

Traditional multiuser computing required that a server be acquired, provisioned, and kept running all of the time that the content provider expected that an application on the server might be used.  That might be efficient if there is heavy usage, but if the application on the server was only used infrequently, that's a big waste of money and resources.

An alternative is serverless computing.  In serverless computing, rather than having tasks being managed by a large application that runs all the time, the code for each task is broken down into smaller bits that only run when their particular function is required.  The rest of the time, they are inactive.  The activation of the code bits (called "Lambdas" by AWS) is triggered by some event.  Examples might be a file landing in an S3 bucket, achieving some particular time interval (the end of a day, or hour, or week), or the completion of a task by another lambda.  Complex systems can be build when a series of Lambdas are turned on and off by each other, with Lambdas sometimes chosing the next Lambda to be activated based on the outcome of their own script.

In AWS, Labmbdas can be written in several programming languages.  In our example, we'll use Python since it's easy and we can hack the example from the previous lesson.

## Setting up for AWS Lambda

Because getting the Lambda to work will require using a number of kinds of resources, we need to log in to the AWS web console as the root user instead of the IAM user we created to have restricted privileges.  If you are signed into the web console as that IAM user, drop down the user options in the upper right and select `Sign Out`.  Then log in again.  If the log in screen looks like this:

<img src="../images/root-login.png" style="border:1px solid black">

Click the link below the sign in button to go to a log in screen that will allow you to enter your email address and password.

## Create a permissions role for the Lambda

Because the Lambda will be running on its own rather than being run by a particular user, we will create an IAM security role for it in the same way we created security restrictions for our IAM user. Creating the most restrictive role that will still allow a Lambda to do its job is a best practice.

<img src="../images/create-role1.png" style="border:1px solid black">

After you have logged in as the root user, from the IAM dashboard screen, select Roles

<img src="../images/create-role2.png" style="border:1px solid black">

From the Role screen, click `Create role`.

<img src="../images/create-role3.png" style="border:1px solid black">

The first step in creating the role is to designate the type of service that will use the role.  Select `Lambda` from the large list of services, NOT from where it is listed on the upper left.  That will cause it show up in the `Select your use case` list at the bottom.  Click `Lambda` there, then the `Next Permissions` button.  

<img src="../images/create-role4.png" style="border:1px solid black">

In the `Filter policies` box, enter `s3`.  Check the box for `AmazonS3FullAccess`.

<img src="../images/create-role5.png" style="border:1px solid black">

In the `Filter policies` box, enter `translate` and check the box for `TranslateFullAccess`.

<img src="../images/create-role5a.png" style="border:1px solid black">

Then in the `Filter policies` box, enter `cloudwatchlogs` and check the box for `CloudWatchLogsFullAccess`.

<img src="../images/create-role6.png" style="border:1px solid black">

On the final screen, give the role a name.  `lambda_s3_cloudwatch` would be good.  Click the `Create role` button.

## Create and test a Lambda

Go to the Services page and click on `Lambda`.  Check the availability zone in the upper right and make sure that it's the same as the one you've been using as your default for the IAM user (probably Ohio or N. Virginia).  

<img src="../images/create-lambda.png" style="border:1px solid black">

Click on the `Create function` button.

<img src="../images/create-function-dialog.png" style="border:1px solid black">

Using the `Author from scratch` option, enter a name for your function.  Select `Python 3.6` as the `Runtime` option. Click the triamgle to drop dow the `Choose or create an execution role` selection.  Click the `Use an existing role` radio button.  Select the IAM role that you created earlier.  Then click the `Create function` button.

<img src="../images/create-function-dialog.png" style="border:1px solid black">

After some time, the Lambda designer screen should show up.  

The `Function code` section in the lower part of the screen allows you to edit the code that gets executed when the Lambda runs.  When the Lambda is executed, the `lambda_handler()` function is invoked. Two things can be passed into the function: the `event` parameter, which can include information passed to the function from whatever event triggers it, and the `context` parameter, which includes technical information about the launching of the Lambda.  If anything is returned by the `lambda_handler()` function, it is sent to the client that invokes the function.  It is also possible to use the `print()` function. Ouptput from `print()` is displayed in the log.    

One can create other functions in the lambda that can be called from within the `lambda_handler()` function. You can also instantiate instances of AWS services (such as S3 buckets) outside of the `lambda_handler()` function. When instatiated there, those instances will persist for the lifetime of the lambda.

The default function just outputs some JSON to the log.  We can test the function as-is by clicking on the `Test` button at the top of the screen and creating a test event.  

<img src="../images/useless-test-event.png" style="border:1px solid black">

Give a name to the test event, then click `Create`.  

<img src="../images/ready-to-test.png" style="border:1px solid black">

I can now test the Lambda by clicking the `Test` button.

<img src="../images/test-results.png" style="border:1px solid black">

After clicking `Test`, I see that the Lambda worked and the output was the useless JSON that the function returned.

<img src="../images/modified-test-event.png" style="border:1px solid black">

Now I'm going to try changing the JSON that gets passed into the function as the `event` parameter by editing my test event.

I'm also going to change the `lamda_function` itself by editing the text in the `Function code` pane, then clicking `Save`.

<img src="../images/edited-lambda.png" style="border:1px solid black">

Now when I click the `Test` button, I see two new results.  Since my new code passed the incoming `event` JSON straight out again as the return value, I see it listed as the Response in the `Execution results` pane.  I also see in the Function Log entry that the string I printed out (the value of `event['Name']` which was `George Washington`).  Printing some results that will show up on the event log is a useful way to figure out what is happening in the Lambda when it gets triggered for real rather than by a test event where you can see the Response on the Function code editing screen.  

## Triggering the Lambda

We want to trigger the Lambda to execute when we drop a text file that needs to be translated into an S3 bucket.  I'll create a new bucket called `baskauf-translate` in the `us-east-2` (Ohio) region to be used for that purpose.  

After creating the bucket, I've returned to my Lambda configuration screen and clicked on the `+ Add trigger` button on the left of the screen.  

<img src="../images/edited-lambda.png" style="border:1px solid black">

That takes me to the trigger selection screen.  Select the `S3` option.

<img src="../images/add-trigger-options.png" style="border:1px solid black">

Select the bucket to be used for the trigger and use "All object create events" for `Event type`.  I'm also restricting the triggering only to files that go into the bucket with the extension of `.txt`.  Click `Add`

<img src="../images/trigger-configured.png" style="border:1px solid black">

The trigger now shows up on the Configuration screen. Click on the `translatLambda` box to return to the Function code screen.  In order to see what's getting passed into the function when it's triggered, I've added different code to print the input JSON in prettified form:

```
import json

def lambda_handler(event, context):
    
    eventString = json.dumps(event, sort_keys=True)
    print(eventString)
    
    return event
```

<img src="../images/upload-to-trigger.png" style="border:1px solid black">

To trigger the event, I've uploaded the `translate.txt` document we were using in a previous exercise to my `baskauf-translate` S3 bucket.  

How do I know if anything happened?  The Lambda Configuration screen won't show me anything this time because I didn't trigger the Labda by a test.  However, if I click on the `Monotiring` tab at the top of the screen, I can find out what happened.

<img src="../images/monitoring-screen.png" style="border:1px solid black">

The monitoring screen has a `View logs in CloudWatch` button.  Clicking on that button takes me to a new tab showing the CloudWatch log for the Lambda.

<img src="../images/log-list.png" style="border:1px solid black">

In the log list, click on the most recent event.

<img src="../images/event-printing.png" style="border:1px solid black">

Recall that I told the scipt to print the JSON that was passed into the function.  There is a lot of useless information, but an important piece of information is the name of the file that triggered the event.  The path to that value would be `event['Records'][0]['s3']['object']['key']`

Now to test whether I can get the file name from the event string, I'll change the script to:

```
import json

def lambda_handler(event, context):
    
    name = event['Records'][0]['s3']['object']['key']
    print(name)
    
    return event
```

and trigger it again by deleting and re-uploading the file to the S3 bucket.  If I refresh the CloudWatch log listing page, then click on the latest execution, I see the new printed results:

<img src="../images/event-print-name.png" style="border:1px solid black">

Success!  We have the file name now.  Now we can use it in our code to pass the file to Amazon Translate

## Inputting the uploaded file and invoking Translate

Here's a code snippet that retrieves the file text string from the uploaded file:

```
in_file = boto3.resource('s3').Bucket(inBucketName).Object(inPath) # create file object
fileBytes = in_file.get()['Body'].read() # this gets all the text in the file as a byte stream
textString = fileBytes.decode('utf-8') # decode the byte stream as UTF-8 characters.
```

Here's a code snippet that will write a string to an S3 bucket:

```
boto3.resource('s3').Bucket(outBucketName).put_object(Key=outPath, Body=outputText)
```

We can combine these code snippets with code from our earlier Translate Python script to create the final Lambda:

```
import boto3
import json
import datetime

def lambda_handler(event, context):
    # Settings
    sourceLanguage = 'en'
    targetLanguage = 'zh'
    inSubfolder = ''
    inBucketName = 'baskauf-translate'
    outSubfolder = ''
    outBucketName = 'baskauf-junk-123'

    # Get the file name from the event parameter
    inputFileName = event['Records'][0]['s3']['object']['key']
    inPath = inSubfolder + inputFileName

    # Make the output file name start with the input file name
    firstPart = inputFileName.split('.')[0]
    outputFileName = firstPart + '-translated.txt' 
    outPath = outSubfolder + outputFileName

    # input the text to be translated from the file that dropped in the S3 bucket
    in_file = boto3.resource('s3').Bucket(inBucketName).Object(inPath) # create file object
    fileBytes = in_file.get()['Body'].read() # this gets all the text in the file as a byte stream
    textString = fileBytes.decode('utf-8') # decode the byte stream as UTF-8 characters.

    # carry out the translation
    translate = boto3.client(service_name='translate', use_ssl=True)
    result = translate.translate_text(Text=textString, SourceLanguageCode=sourceLanguage, TargetLanguageCode=targetLanguage)
    outputText = result.get('TranslatedText')

    # output the translated text to a file in an S3 bucket
    boto3.resource('s3').Bucket(outBucketName).put_object(Key=outPath, Body=outputText)
        
    print('Translation completed at ', str(datetime.datetime.now()))
```

In the Lambda Function code editor, replace the previous script with the one above and click `Save`.  Delete the previous text file from the trigger bucket and re-upload it.  

<img src="../images/cloudwatch-log.png" style="border:1px solid black">

Now when I refresh the CloudWatch log and look at the most recent event, I see the message I printed from the script: `Translation completed at 2019-11-04 03:43:05.360862`.  

<img src="../images/output-file.png" style="border:1px solid black">

When I check the output bucket that I specified in the script (click refresh), I see an output file named as I specified in the script.

<img src="../images/translation.png" style="border:1px solid black">

When I download and open the file, I see the translation in the language I requested in the script.

## Triggering the Lambda via the CLI

One of the advantages of running the script as a Python Lambda in the cloud rather than a desktop Python script is that a IAM user can trigger the Lambda simply by uploading a file to the S3 bucket and getting the result by downloading a file from an S3 bucket.  The IAM user does not have to have any other permissions besides full S3 permissions.  The user can also be set up to be restricted to accessing only the particular S3 buckets required for the operation of the script.  

Creating very restricted access like this allows workers to assist with carrying out an AWS analysis without the need for you to grant them access to your account online.  They also would be unable to modify the Lambda script while using it.  

<img src="../images/console-output.png" style="border:1px solid black">

In the example above, my IAM user with only S3 privileges used CLI commands to upload the file `translate.txt` to the trigger bucket, then download the results and delete both files.  The Windows `type` command (`cat` in Linux) was used to display the contents of the translation.  Since the Command Prompt application can't display UTF-8 characters, it's mostly gibberish - I need to use some other application to actually look at the output.

## Other useful stuff

This was a very minimal example of using a Lambda.  Lambdas can be set up to send you a notification email when they run (usefully for rarely-triggered events).  They can also be used to obtain the data from an API rather than from an S3 bucket.  In that case, the trigger can be a Cron job scheduled to harvest data from the API at regular intervals.  AWS also has easily used cloud databases that can be used to store the output data rather than putting it in a file in a bucket.  

Another useful possibility is to string multiple Lambdas sequentially.  For example, Amazon TExtract could be used to extract text from an image by one Lambda.  The output of that Lambda could then trigger Amazon Translate to translate into another language, Amazon Comprehend to do sentiment analysis, or Amazon Polly to convert the text into speech.

----
Revised 2019-11-03
