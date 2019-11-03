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

Because the Lambda will be running on its own rather than being run by a particular user, it is a good practice to restrict the Lambda's access to resources just as we did IAM users.  To do that, we need to create an IAM role for it.

<img src="../images/create-role1.png" style="border:1px solid black">

<img src="../images/create-role2.png" style="border:1px solid black">

<img src="../images/create-role3.png" style="border:1px solid black">

<img src="../images/create-role4.png" style="border:1px solid black">

<img src="../images/create-role5.png" style="border:1px solid black">

<img src="../images/create-role6.png" style="border:1px solid black">



## Create the Lambda

After you have logged in as the root user, go to the Services page and click on `Lambda`.  Check the availability zone in the upper right and make sure that it's the same as the one you've been using as your default for the IAM user (probably Ohio or N. Virginia).  

<img src="../images/create-lambda.png" style="border:1px solid black">

Click on the `Create function` button.

----
Revised 2019-11-03
