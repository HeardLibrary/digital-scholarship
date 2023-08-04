---
permalink: /pubs/omeka/
title: Omeka on AWS
breadcrumb: Omeka
---

# Building an Omeka website on Amazon Web Services (AWS)

Warning: although this tutorial is designed for non-professionals, it is not for the faint of heart. If these instuctions are followed exactly, you should be able to build a functioning Omeka instance under the August 2023 AWS configuration. However, there are many steps that must be followed exactly, making the process tedious. At some point I may figure out how to set up a CloudFormation template for the process, which could simplify the process.

The following skills and abilities are assumed:
- basic proficiency with the Linux shell (command line), including navigating among directories and using the Nano editor. For an introduction, I recommend [The Unix Shell lessons](https://swcarpentry.github.io/shell-novice/) by Software Carpentry.
- access to an AWS account and a basic understanding of what S3 buckets and Elastic Compute Cloud (EC2) servers are.
- know how on your operating system to use SSH to log into a remote server
- basic familiarity with CSV spreadsheets and experience with editing and saving in the CSV format. Although it is possible to use Excel for this, it is highly recommended to use the open source [Libre Office](https://www.libreoffice.org/) Calc instead, since it avoids all of the common gotchas that are typically experienced by new users who uses Excel to manage CSVs.
- if automating upload of files to AWS S3, ability to run Python scripts from the command line. 

As a general reference, I made heavy use of [some general instructions on The Programming Historian](https://programminghistorian.org/en/lessons/installing-omeka) with modifications for use in AWS as described below. 

**Intended users**

This tutorial is intended for users who want to set up a single digital archive or create a relatively simple digital online exhibit using Omeka Classic. Larger users may be better off with the multi-site Omeka S product (not covered in this tutorial). When you have finished the tutorial, you will have a real functioning website and not a test or "toy" instance. The tutorial includes enabling editing access to the site by multiple users.

The cost to run the site should be around US$10 per month, excluding costs for a custom domain name.

The tutorial only covers installation, setup, and loading files. It does not cover styling or creating custom web pages. Using International Image Interoperability Framework (IIIF) features is covered to some extent.

**Steps in the process**

The following steps are necessary to create a fully functional Omeka site on AWS. Under some circumstances, it may be possible to skip some of the steps, particularly if you are only interested in testing. However, if you want to actually run a production site long-term, you probably will need to complete all of the steps.

1. S3 setup.
2. Set up IAM users.
3. Create the EC2 web server.
4. Allocate an Elastic IP address to the EC2 server.
5. Install and configure Omeka Classic.
6. Map the EC2 IP address to a domain name.
7. Enable HTTPS.
8. Set up AWS Simple Email Service (SES). Optional, but required for multiple users.
9. Download and enable plugins.
10. Configure file storage to use S3.
11. Establish efficient workflow. Optional, but recommended if many image files will be uploaded.
12. Enable IIIF tools.

Each one of these steps will be described in detail in the following sections. In most cases, I've included one or more links to references I used to figure out that step. 

## S3 Setup

The instructions in this step are based in part on [an article from Reclaim Hosting](https://support.reclaimhosting.com/hc/en-us/articles/1500005621161-Setting-up-S3-storage-with-Omeka-Classic#setting-up-s3-storage-with-omeka-classic-0-0).

1\. Log in to AWS and create a bucket for Omeka file storage. In these examples I'm using a bucket called `bassett-omeka-storage``. 
- I chose to create the project in `us-east-1`. If you chose another zone it's possible that some features may not be available.
- You MUST choose ACLs enabled in order for Omeka to write to this bucket.
- To make the images accessible via the web, uncheck “Block all public access”.
- To actually make the objects in the bucket public, after creating the bucket, click the `Permissions` tab, edit the Bucket policy, and add this JSON:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicRead",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::bassett-omeka-storage/*"
        }
    ]
}
```

Substitute the name of your bucket for “bassett-omeka-storage” and save the changes. Refreshing the bucket list should show a red “Public” value in the Access column.

2\. If you are going to upload all of your content manually, you can skip this step. However, if you plan to do larger scale uploads using the CSV import plugin, repeat the process to create another bucket to hold the raw images that will be used as a data source. I called this one “bassettassociates” so that it will look sensible in the URL, which will be exposed to users.

## Set up IAM users with permissions to write to the two buckets



## Create the web server

1\. Set up an EC2 instance on AWS called “omeka”, provisioned with Ubuntu and using system defaults (64-bit x86, t2.micro, 1x8 GB storage). Created a new RSA key called omeka_project.pem and used it. Let it create a new security group. Allow SSH traffic from anywhere. Check the Allow HTTPS traffic and Allow HTTP traffic. Then click Launch Instance.

Instructions in the next two steps are for Linux (i.e. Mac command line). For other operating systems like Windows, you may need to modify them. 

2\. Copy the pem key in the home directory. Then use the command line to change the permissions using:

```
chmod 0400 omeka_project.pem
```

3\. Find the Public IPv4 DNS on the instance list. Put that DNS after the “@” in the following line and use it in the command line to SSH into the server (“ubuntu” is the default user account).

```
ssh -i "omeka_project.pem" ubuntu@ec2-18-207-226-15.compute-1.amazonaws.com
```

Note that once you connect to the remote server using SSH, the commands you are giving are on the server and not your local computer. If the remote connection breaks or is shut down due to inactivity, you'll need to reconnect using the `ssh` command above.

4\. The following commands need to be done as the root user. To avoid having to prefix them all with `sudo`, give the following command to default to the root user:

```
sudo su root
```

5\. Update the system:

```
apt-get update && apt-get upgrade	
```

Answer in the affirmative to any questions.

6\.  Install the LAMP server stack:

```
apt-get install lamp-server^
```

Be sure to include the trailing `^`. Answer the affirmative to any questions. 

7\. Test the Apache server by going to the DNS address given for the EC2 instance, e.g.: 

```
http://ec2-18-207-226-15.compute-1.amazonaws.com
```

Alternatively, you can also go directly to the IP address, e.g. 

```
http://18.207.226.15/
```

You should see the “It works!” Apache2 default page. Note: make sure you include the `http://` and not just the domain name (since that will probably default to `https://`). 

8\. Enable the Apache mod_rewrite module:

```
a2enmod rewrite && service apache2 restart
```

9\. Restart using the new configuration

```
systemctl restart apache2
```

10\. Log in to the MySQL database program as the root user. (Note: contrary to the instructions in the Programming Historian, there isn’t any password required for the root MySQL account in this setup.)

```
mysql -u root
```

11\. Set up a MySQL database called “omeka”

```
CREATE DATABASE omeka CHARACTER SET utf8 COLLATE utf8_general_ci;
```

12\. Create a database user account for Omeka with a username the same as the database name and your chosen password replacing `%8)&2P^TFR2C`:

```
CREATE USER 'omeka'@'localhost' IDENTIFIED by '%8)&2P^TFR2C';
```

13\. Grant the new user access to the new database

```
GRANT ALL PRIVILEGES ON omeka.* TO 'omeka'@'localhost'; FLUSH PRIVILEGES;
```

14\. Exit mysql:

```
exit
```

## Allocate an Elastic IP address to the EC2

An AWS Elastic IP address will keep your IP address stable. For example, if you have to recreate your EC2 instance, you can transfer the Elastic IP to it without disrupting other resources linked to that IP. An Elastic IP is free as long as it is associated with a running EC2 instance. Since you will be changing the IP address, you need to exit your SSH connection with the EC2. Enter `exit`` twice to exit the root user and close the SSH.

1\. In the AWS console, go to EC2, Network & Security, Elastic IPs. Click the `Allocate Elastic IP address` button. 

2\. Select the `Network Border Group` for your EC2 instance, then click Allocate.

3\. From the Elastic IP addresses page, check the box by the address, then drop down Actions and select Associate Elastic IP address.

4\. Click the Instance radio button. Click on Instance and select your running instance. 

5\. Click on the Associate button. At this point, the former public IP is replaced with the elastic IP (in this example, 54.243.224.52).

6\. Go to the EC2 console and click on your instance to find the new DNS address and IP address. Test that they work by loading the Apache Default Page:

```
http://ec2-54-243-224-52.compute-1.amazonaws.com/
```

or

```
http://54.243.224.52/
```

7. The SSH connection command will be different now, based on the new IP. Connect to it:

```
ssh -i "omeka_project.pem" ubuntu@ec2-54-243-224-52.compute-1.amazonaws.com
```

then change to the root user

```
sudo su root
```

## Install and configure Omeka

1\. Navigate to the html directory:

```
cd /var/www/html
```

2\. Go to <https://omeka.org/classic/> . Click on the download button, then on the download page right click on the `get` button and select `copy link`. In this example, the latest version is 3.1.1, but the most recent version may be something else (requiring a corresponding change in the commands). Fetch the compressed file using:

```
wget https://github.com/omeka/Omeka/releases/download/v3.1.1/omeka-3.1.1.zip
```

3\. Install the unzip utility:

```
apt-get install unzip
```

4\. Instal php-xml:

```
apt-get install php-xml
```

5\. Unzip the downloaded installation package:

```
unzip omeka-3.1.1.zip
```

6\. Change directory name to whatever name you want to use for Omeka as the first level path in your URLs. For example, if I want the path to be `bassettassociates.org/archive/` I would use:

```
mv omeka-3.1.1 archive
```

7\. Delete the zip

```
rm omeka-3.1.1.zip
```

8\. Change to the new omeka directory, make the files in the files directory and all subdirectories writable, and change the owner of the omeka installation using the following commands:
```
cd archive
chmod -R 777 files
chown -R www-data:www-data .
```

Don’t miss the trailing dot on the last command.

9\. Edit the db.ini file using the nano editor:

```
nano db.ini
```

10\. Change the values of the first four settings to those you set up earlier:

```
host     = "localhost"
username = "omeka"
password = "%8)&2P^TFR2C"
dbname   = "omeka"

Be sure to replace the fake password above with the real one that you used. Save and exit the file.

11\. I am not sure if this step is required, but I installed Image Magick using directions [these instructions](https://www.linuxcapable.com/how-to-install-imagemagick-on-ubuntu-linux/):

```
apt install libpng-dev libjpeg-dev libtiff-dev
apt install imagemagick
```

12\. Append `/archive/install/install.php` to the IP address to go to the setup URL:
http://54.243.224.52/archive/install/install.php
13\. Fill out the configuration form. (I used baskauf and the same password as the database access password). For the ImageMagic Directory Path, use
/usr/bin
Note: there are some unspecified requirements for the password. You can’t use “pwd”, so use something longer and more complicated.
14\. Change to the Apache directory and edit the Apache2 configuration file:
cd /etc/apache2
nano apache2.conf
Scroll down to the directory access section and for /var/www/ change to 
AllowOverride All
Reboot the server using:
service apache2 restart
15\. Go to the admin page:
http://54.243.224.52/archive/admin/
The first time, you will be redirected to a login page. On that page, give the username and password you set up for the super user.
16. You can also view the site as a user by going to 
http://54.243.224.52/archive/

17\. It probably is a good idea to turn on error messages, at least while setting up.
cd /var/www/html/archive
nano .htaccess

Uncomment:
SetEnv APPLICATION_ENV development

18\. Restart the server:
service apache2 restart



----

Questions? Comments? [Contact Steve Baskauf](mailto:steve.baskauf@vanderbilt.edu)

----
Revised 2023-08-03
