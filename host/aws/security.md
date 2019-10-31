---
permalink: /host/aws/security/
title: Security on AWS
breadcrumb: security
---

# Security on AWS

One of the key features of AWS is that it incorporates security features throughout the features it offers.

## The root account

The root account is created at the time an account is established with AWS.  By default, it's associated with the email address used to create the account.

By default, the root account has full privileges for most actions possible in AWS.  For that reason, it would be disasterous for it to be hacked.  There are several actions that should be taken to keep the root account secure:

1. Have a strong password
2. Use multifactor authentication (MFA)
3. Delete the access keys associated with the root account.
4. Create and routinely use other Identity and Access Management (IAM) users.

<img src="../images/security.png" style="border:1px solid black">

When accessing a newly created account, AWS will suggest that you take these actions and provide links for doing so.

## Access keys

Access keys are long, random strings assigned to users that allows them to access resources and perform functions directly through the Internet rather than through the ASW web interface.  For example, with access keys, a user can issue commands using the command line interface (CLI) on a local computer to make things happen remotely on AWS.  Anything that can be done by logging in to the AWS website can also be done with the access keys.  

Clearly access keys are a powerful thing that can be misused if they are stolen.  The good thing is that they can be revoked and regenerated at any time.  

The best practice is to delete the powerful access keys of the root user and create access keys for IAM users with limited privileges that are specific to a particular project. 

## Creating an IAM user

To create a user for a specific task, click on Services, then search for IAM.  

<img src="../images/security.png" style="border:1px solid black">



----
Revised 2019-10-31
