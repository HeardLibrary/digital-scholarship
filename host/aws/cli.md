---
permalink: /host/aws/cli/
title: AWS Command Line Interface (CLI)
breadcrumb: CLI
---

[previous lesson on setting up a static website using an S3 bucket]](../website/)

# AWS Command Line Interface (CLI)

The CLI allows you to carry out AWS operations remotely from your desktop without logging in to the AWS web interface.  It uses the normal console for your operating system (Command Prompt for Windows, Terminal for Mac, Shell for Linux).

## Installing the CLI

There are multiple ways to install the CLI that vary depending on your operating system.  The normal way is to install it using the Python package manager PIP.  If you already have in independent distribution of Python installed or have installed the Anaconda distribution, you are ready to install the CLI.  [Instructions for installing in independent distribution of Python](../../../script/python/install/) - on Windows pay attention to the checkbox for adding Python to PATH!  [Information about Anaconda with a link to the installation page](../../../script/anaconda/).  If you are a power Python user and are concerned about potential conflicts with tools, you can install the CLI in a virtual environment.

If you don't want to install Python, it is also possible to install the CLI using an installer.  That method is simpler if you don't already have Python, but it is difficult to upgrade the CLI, so the PIP method is preferred.

For detailed installation instructions, see [this page](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).

To test whether the installation was successful, open your console window (Terminal on Mac, Command Prompt on Windows) and enter

```
aws --version
```

If version information is displayed, then you are ready to go.  If you get a message saying that `aws` is an unknown command (or something similar), then the most likely reason is that the CLI is not in your system PATH.  For instructions on how to add the CLI to your PATH, follow [these instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html#post-install-path).  For more information about the system PATH, see [this page for Windows](https://heardlibrary.github.io/digital-scholarship/computer/command-windows/#the-system-path) or [this page for Mac](https://heardlibrary.github.io/digital-scholarship/computer/command-unix/#the-system-path).

## Configuring the CLI

In order for the CLI to have the authority to carry out AWS commands on your behalf, it needs to know the access keys that you set up when you opened your account.  It's also convenient to set some defaults for the CLI so that you don't have to type them with every command.

Find the access keys that you saved earlier.  Probably you downloaded them as a CSV file that you saved somewhere.  Open that CSV so that you are able to copy and paste the keys.

There are two ways to make your keys available to the CLI and set the defaults.  The simplest is to use the `configure` command.  This method is fine if you are likely to only use one set of IAM user keys.  To use the `configure` command, just enter

```
aws configure
```

and enter your keys when prompted.  For the default region name, enter one that is close to you.  For Vanderbilt, that's `us-east-1` (northern Virginia) or `us-east-2` (Ohio).  Often it's not critical which one you chose, but you should use your chosen region consistently. In some cases, particular services are only available in some of the regions, so [check out the availability of the services in which you are interested](https://docs.aws.amazon.com/general/latest/gr/rande.html) before chosing.  For the default output format, select `json`.

The more complicated method is to directly edit the `config` and `credentials` files. That method requires finding those files in the hidden directory `aws` in your user home directory ([see unhide directories on Windows](../../../computer/files-windows/#unhiding-file-extensions) or on Mac press `command` and `shift` then `.` in Finder to see hidden folders).  

Here's what my credentials file looks like:

![credentials file](../images/credentials-file.png)

I have a record of the keys for each of the IAM users from the various AWS accounts I use.  The particular user can be specified when giving a command, but its easier to just copy the keys for the currently relevant user and paste them under `default` to avoid the extra typing.  When switching to a different project involving a different IAM user, just change the keys listed under `default` to the new IAM user.

For details on configuring the CLI, visit [this page](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

Because these powerful keys live on the drive of your computer, they can be compromised if an unauthorized user accesses your computer (by stealing it, using the computer when you forgot to lock it, etc.).  Fortunately, it's easy to revoke them in the web interface by going to the IAM user page, then deleting the old keys and generating new ones.  

## Issuing a CLI command

Although the AWS web interface is convenient for learning about and testing AWS services, in every day use, the CLI is a much more efficient way to work.  Every ASW service can be managed and invoked using the CLI.

In an earlier lesson, we went through a multi-step process to upload a file into an S3 bucket using the web interface.  It's much easier to manage files in S3 buckets using the CLI.  The full reference for S3 commands in the CLI is on [this page](https://docs.aws.amazon.com/cli/latest/reference/s3/).  We'll just use a few.

To list the S3 buckets accessible by the default IAM user, give the command:

```
aws s3 ls
```

This command follows the general pattern for CLI commands: invoking the CLI (`aws`) followed by the service to be used (`s3`), followed by the specific command to be carried out.

![file listing](../images/s3-listing.png)

To list the contents of a specific bucket, add the bucket identifier (`s3://baskauf-website` in this example) to the end of the previous commmand:

```
aws s3 ls s3://baskauf-website
```

The same two files that I uploaded in [an earlier lesson](../website/) are listed:

![file listing](../images/web-interface-listing.png)

To copy a file from s3 to my local computer, or from my local computer to s3, issue the `cp` command followed by the source file path, then the destination file path.  In the following example, I'm copying the file `states.csv` that's located in the current working directory of the console to an S3 bucket called `baskauf-junk-123`:

```
aws s3 cp states.csv s3://baskauf-junk-123/states.csv
```
The `--recursive` option for `cp` can be used to copy all files in a directory.  

Another very useful `s3` command is `sync`, which recursively copies new and updated files from the source directory to the destination.  This command can be really useful when you want to automatically backup your work in a particular local directory to S3, or if you want to move all of the output that's been stored in an S3 bucket as the result of some operation to a directory in your local computer.  

If you are managing a static website on S3, you can use `cp` or `synch` to mirror a local version of the website from your hard drive to the S3 bucket that hosts the actual site.  See the `cp` [options list](https://docs.aws.amazon.com/cli/latest/reference/s3/cp.html#options) for information about setting the media type (Content-Type) for files and controlling public access.

To delete a file, use the `rm` command.  The following command deletes the file that I previously uploaded:

```
aws s3 rm s3://baskauf-junk-123/states.csv
```

You can verify that the deletion has occurred by refreshing the S3 bucket listing page in the web interface.

[next lesson on scripting an AWS service using Lambda](../lambda/)

----
Revised 2019-11-05
