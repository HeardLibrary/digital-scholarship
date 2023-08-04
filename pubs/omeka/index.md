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

1. [S3 setup](#s3-setup).
2. [Set up AWS user credentials](#set-up-credentials-to-write-to-the-two-buckets).
3. [Create the EC2 web server](#create-the-web-server).
4. [Allocate an Elastic IP address to the EC2 server](#allocate-an-elastic-ip-address-to-the-ec2).
5. [Install and configure Omeka Classic](#install-and-configure-omeka).
6. [Map the EC2 IP address to a domain name](#mapping-the-ec2s-elastic-ip-to-a-domain-name).
7. [Enable HTTPS](#enabling-https).
8. [Set up AWS Simple Email Service (SES)](#set-up-simple-email-service-ses). Optional, but required for multiple users.
9. [Download and enable plugins](#downloading-and-enabling-plugins).
10. [Configure file storage to use S3](#configuring-file-storage).
11. [Establish efficient workflow](#establish-an-efficient-work-flow). Optional, but recommended if many image files will be uploaded.
12. [Enable IIIF tools](#enable-iiif-tools).

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

## Set up credentials to write to the two buckets

In order to write objects to the S3 buckets and to delete them programatically, you need to set up security credentials. The preferred method for doing this is to set up Identity and Access Management (IAM) users that have very restricted access policies attached to them, i.e. only able to write to and delete objects from particular S3 buckets. However, I was not able to get restricted user credentials to work from Omeka, despite the credentials working fine when tested in Python with the boto3 package for accessing AWS. So I had to use the full root user credentials from my AWS account. This would normally be considered extremely risky, since if those credentials were stolen or accidently exposed they could be used to perform any operation on the AWS account. However, given that the credentials are only being used in a configuration file inside the EC2 server, they should be secure as long as SSH access to the EC2 is guarded. One must be cautious and make sure that no copies of the configuration file are stored in a publicly-accessible place like GitHub.

If you are going to upload content to S3 manually, then you can skip creating an IAM user to upload the files to S3 from your local computer. However, if you are going to use a Python script to do the uploading as part of a streamlined workflow, you should use credentials from a restricted IAM user rather than your full root user credentials to avoid the risk of them being accidentally stolen or exposed by being present on your hard drive. 

1\. **Creating a root user key for access from Omeka**. Click on your username in the upper right of the AWS online console and select `Security Credentials`. 

2\. Under Access keys, click `Create access key`. On the warning page, check the box and click `Create access key`. 

3\. You will have one opportunity to copy or download the `Access key` and `Secret access key` values. Click the `Download .csv file` button and save the file in a secure location where it will NOT be publicly accessible. You will substitute the values in this file for `your_access_key_id` and `your_secret_key` in the configuration file example in the [Configuring file storage](#configuring-file-storage) section of these instructions.

4\. **Creating IAM credentials for automating S3 upload from your computer**. Go to the IAM section of the AWS online console. Click on `Policies` from the left menu.

5\. Click on `Create policy`. Click on the JSON button and erase the existing text.

6\. Paste in the following text:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::bassettassociates/*"
        }
    ]
}
```

In the last line of text, replace `bassettassociates` with the name of the S3 bucket you will use to store the raw images that will be used as a data source.

Click `Next`.

7\. On the next screen enter a policy name and description. I called mine `write-to-bassettassociates-storage`. Click the `Create` button.

8\. Click `Users` in the left menu then click the `Add users` button.

9\. Enter the User name and leave the checkbox unchecked. Click `Next`.

10\. Select the `Add policies directly` button. Under the Permissions policies section, paste the name of the policy that you created in the search box. Check the box at the left of the name of your policy. Click `Next`.

11\. On the review screen, click `Create`. 

12\. On the Users page, click on the name of the user you created. Click on the `Security credentials` tab. Scroll down to the Access keys section and click `Create access key`. 

13\. The next page is designed to scare you away from using the access key. Click on the `Local code button`. Click the Confirmation check box, then click the `Next button`. Give the access key a description, then click `Create access key`. 

14\. You will have one opportunity to copy or download the `Access key` and `Secret access key` values. Click the `Download .csv file` button and save the file in a secure location where it will NOT be publicly accessible. You will use these values later in the instructions for the [Establish efficient workflow](#establish-an-efficient-work-flow) section. 

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
```

Be sure to replace the fake password above with the real one that you used. Save and exit the file.

11\. I am not sure if this step is required, but I installed Image Magick using directions [these instructions](https://www.linuxcapable.com/how-to-install-imagemagick-on-ubuntu-linux/):

```
apt install libpng-dev libjpeg-dev libtiff-dev
apt install imagemagick
```

12\. Append `/archive/install/install.php` to the IP address to go to the setup URL, e.g.:

```
http://54.243.224.52/archive/install/install.php
```

13\. Fill out the configuration form. The username and password given here are important as they will be used to log into the website. For the ImageMagic Directory Path, use `/usr/bin`. **Note:** there are some unspecified requirements for the password, so use something relatively long and complicated.

14\. Change to the Apache directory and edit the Apache2 configuration file:

```
cd /etc/apache2
nano apache2.conf
```

In the configuration file, scroll down to the directory access section and for the `/var/www/`` setting, change to:

```
AllowOverride All
```

Reboot the server using:

```
service apache2 restart
```

15\. Go to the admin page:

```
http://54.243.224.52/archive/admin/
```

The first time, you will be redirected to a login page. On that page, give the username and password you set up for the super user. You can also view the public site by going to

```
http://54.243.224.52/archive/
```

16\. It probably is a good idea to turn on error messages, at least while setting up. From the server command line:

```
cd /var/www/html/archive
nano .htaccess
```

Uncomment the line:

```
SetEnv APPLICATION_ENV development
```

17\. Restart the server:

```
service apache2 restart
```

At this point, you can experiment with uploading a file, but do not upload many files since they will be lost when the S3 storage adapter is installed later. 

## Mapping the EC2's Elastic IP to a domain name

The easiest way to attach a custom domain name is by registering it through AWS's [Route 53 domain registration system](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-ec2-instance.html). 

1\. From the AWS control panel, go to Route 53, select and register a domain name. In the remaining examples, I'm using the domain name `bassettassociates.org`. Monitor the status using the Requests page under Domains. When the domain is registered, the `Status` in the `Domains`, `Requests` page will change to Successful. You should also receive a confirmation email at the email address you used to register the domain. 

2\. Get the IP address for your Elastic IP from the EC2 control panel if you don't already have it.

3\. At the [Route 53 dashboard](https://console.aws.amazon.com/route53/), click on `Hosted zones`, then the link with the name of your zone. Click on `Create record`.

4\. If you want to use a subdomain (such as "www") in front of your domain name, type it in the Record name box. Otherwise, leave it blank to use only the domain name. Leave the Record type at it's default "A" value. In the `Value` box, enter the IP address you got from step 3. Leave the Routing policy at its default, `Simple routing`. Click `Create records`.

5\. It should take about a minute for the changes to proliferate in the system. After a minute, you can click the View status button at the top of the page. A status of `INSYNC` means it's ready to go. You can try out the domain name by going to the domain name using an http:// URL:

```
http://bassettassociates.org/archive/
```

which should take you to the Omeka landing page.

## Enabling HTTPS

Although the site is usable with only HTTP enabled, it is important to enable secure HTTP (HTTPS). The simplest reason is that when a domain name is typed into a browser (e.g. `bassettassociates.org`), the browser will automatically prepend `https://` to form the URL. If only HTTP is enabled, this will result in a file not found error, confusing potential users. The other security-related reason is that with only HTTP enabled, it's possible to intercept usernames and passwords during the login process. Although this is probably unlikely to happen, it is a best practice to carry out login operations using HTTPS to avoid the possibility of compromising login integrety.

If you read online about setting up HTTPS on AWS, you will see all kinds of suggestions, including setting up a load balancer or implementing an Nginx front-end server. Fortunately, these complicated and potentially costly methods are unnecessary to run an Omeka site that is likely to have little traffic. It is relatively easy to set up HTTPS using [Let's Encrypt](https://letsencrypt.org/), a free service that provides security certificates. The following instructions are modified from [a blog post](https://linuxhint.com/secure-apache-lets-encrypt-ubuntu/) and [this article](https://medium.com/jungletronics/aws-letsencrypt-bfce27decd52). Important note: do NOT enable the UFW firewall as indicated in the blog! This is unnecessary given the existing AWS firewall and will result in making it impossible to SSH into the EC2 server.

1\. While logged in as the root user, update again just in case:

```
apt update
```

2\. Install Certbot and python3-certbot-apache:

```
apt install certbot python3-certbot-apache
```

Check that it worked:
```
certbot --version
```

3\. Get the SSL certificate using Certbot:

```
certbot --apache -d bassettassociates.org
```

substituting your domain name for `bassettassociages.org`.

4\. Restart the server:

```
service apache2 restart
```

It may be that this is sufficient for HTTPS to fully work. However, before I installed Let's Encrypt, I had experimented with using Open SSL to create a self-signed certificate using instructions from [this blog post](https://linuxhint.com/enable-https-apache-web-server/). Setting up the self-signed certificate involved editing the same Apache configuration file that is modified by installing Let's Encrypt. So when I examined the configuration file after installing Let's Encrypt, I wasn't sure what modifications were made by the Let's Encrypt installations and which were left over from my Open SSL experiment. Whatever the case, this is the final form of the file `000-default.conf` in the  `/etc/apache2/sites-enabled/` directory (minus comments): 

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    RewriteEngine on
    RewriteCond %{HTTPS} !=on
    RewriteRule ^/?(.*) https://%{SERVER_NAME}/$1 [R=301,L]

    RewriteCond %{SERVER_NAME} =bassettassociates.org
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>

<VirtualHost *:443>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    SSLEngine on
    ServerName bassettassociates.org
    SSLCertificateFile /etc/letsencrypt/live/bassettassociates.org/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/bassettassociates.org/privkey.pem
    Include /etc/letsencrypt/options-ssl-apache.conf
</VirtualHost>
```

The configuration is set up so that if a user enters the `http://` version of a URL, it will automatically be redirected to the `https://` version. If your site does not have this desired behavior, you may want to edit your Apache configuration file to be analogous to what is listed above.

## Set up Simple Email Service (SES)

If you are only planning to use the default Super User to edit the site and upload content, then you don't need to enable email for the site. However, if you want to allow other users with their own passwords to perform tasks on the site, you should set up AWS's Simple Email Service (SES). In theory, you should be able to add other users and their passwords via the Users tab in the admin console. However, users that I set up by manually assigning a password could not log in. It appears that a confirmation email is required to enable the user to set up their own password.

When you initially set up SES, you are in its sandbox environment. The sandbox has a limit of 200 emails per day, but the real limitation is that in sandbox mode you can only send emails to verified addresses. The verification process is clunky and I had problems getting it to work. So it is better to just go ahead and apply for production access. That may take up to a day since a human apparently has to review the application. But I was able to get production access with no problem.

1\. Go to SES in the AWS online console and click on Verify identity. Enter your email address.

2\. Click on the link in the verification email.

3\. The Account dashboard should show that you are initially in Sandbox mode with 200 sends per day. Click on SMTP settings in the upper left. Click the "Create SMTP credentials" button.

4\. You will have one chance to see and download the security credentials. Click the `Download Credentials` button to save them. The important information is the SMTP Username and the SMTP Password. 

5\. On the SMTP settings page, the SMTP endpoint is given as 

```
email-smtp.us-east-1.amazonaws.com
```

You will need this for the Omeka configuration.

6\. While connected to the EC2 by SSH and logged in as the root user, edit the Omeka configuration file:

```
cd /var/www/html/archive/application/config
nano config.ini
```

Scroll to the Mail section, uncomment (by removing the leading `;`), and edit as follows:

```
mail.transport.type = "Smtp"
mail.transport.host = "email-smtp.us-east-1.amazonaws.com"
mail.transport.port = 587     ; Port number, if applicable.
mail.transport.name = "localhost"      ; Local client hostname, e.g. "localhost"
mail.transport.auth = "login" ; For authentication, if required.
mail.transport.username = "your_smtp_username"
mail.transport.password = "your_smtp_password"
mail.transport.ssl = "tls"       ; For SSL support, set to "ssl" or "tls"
```

Replace the username and password above with yours and set the host to whatever SMTP endpoint was shown on the SMTP settings page.

7\. On the SES website, request production access. You will have to explain how you will use the emails, steps you will take to be a good citizen, etc. I simply said that I needed to send a very small number of confirmation emails to add users to my site, and I didn't have any problem.

8\. When you are approved, you will get an confirmation email with a URL to click on to confirm that you are authorized to use the return email address that you provided. Once you confirm, your Omeka site should be able to send confirmation emails when you add a new user.

## Downloading and enabling plugins

In this section we will install the S3 storage adapter plugin, necessary to use AWS S3 instead of internal EC2 storage. We will also install plugins that will allow you to import and export data about multiple items using CSV files. CSV import is optional, but is useful to avoid the drudgery of manually uploading many files. CSV export is also optional but is useful for obtaining a summary of metadata added for items.

1\. While connected to the server via SSH and working as the root user, change to the plugins directory:

```
cd /var/www/html/archive/plugins
```

2\. **Install the S3 storage adapter.** Go to <https://github.com/EHRI/omeka-amazon-s3-storage-adapter/releases>. Under the most recent release, and “Assets”, locate the zip link. Right click and select `Copy link`. At the command line, type “wget” then paste the link, like this:

```
wget https://github.com/EHRI/omeka-amazon-s3-storage-adapter/releases/download/v1.1.0/omeka-amazon-s3-storage-adapter-1.1.0.zip
```

Unzip the downloaded file:

```
unzip omeka-amazon-s3-storage-adapter-1.1.0.zip
```

Delete the zip file:

```
rm omeka-amazon-s3-storage-adapter-1.1.0.zip
```

3\. **Install the CSV Import and CSV Export plugins.** Go to <https://omeka.org/classic/plugins/> , scroll down to `CSV Import``, right click on the download button, and select `Copy link``. At the server command line, paste the link you copied after `wget` like this:

```
wget https://github.com/omeka/plugin-CsvImport/releases/download/v2.0.7/CsvImport-2.0.7.zip
```

Go to <https://omeka.org/classic/plugins/CsvExport/>, right click the download button, and paste the link after wget:

```
wget https://github.com/utlib/CsvExport/releases/download/v1.1.2/CsvExport.zip
```

Unzip the two zip files:

```
unzip CsvImport-2.0.7.zip
unzip CsvExport.zip
```

Delete the two zip files:

```
rm CsvImport-2.0.7.zip
rm CsvExport.zip
```

4\. Go to the admin web page if you don’t already have it open and log in if necessary. In my case, the URL is:

```
http://bassettassociates.org/archive/admin/
```

5\. Click on the plugins tab. Click on the Install buttons for Amazon S3 Storage Adapter, CSV Import, CSV Export Format, Simple Pages, and Exhibit Builder (if you are interested in using the last two). Click on CSV Export Format. Check the box if you want it to use the original source URLs or leave it unchecked to use the Omeka-generated URLs for the imported original files. If you are using the CSV import from an S3 bucket, you may want to use the original source URL. Otherwise, you will probably want to use the Omeka-generated ones.

## Configuring file storage

Since we are going to use AWS S3 storage, there isn’t really any reason to restrict the file size. It’s possible that if pyramidal TIFFs are uploaded, the files could be very large, so I set the maximum size to 100 MB. As a practical matter, a T2 micro EC2 instance has problems processing image files larger than 50 MB, so 100 MB seems fine as a limit.

1\. Set the maximum file upload size and S3 source in the Omeka configuration file. 

```
cd /var/www/html/archive/application/config
nano config.ini
```

In the Storage section, uncomment (remove prepended “;”) and change to:

```
storage.adapter = "Omeka_Storage_Adapter_AmazonS3"
storage.adapterOptions.accessKeyId = your_access_key_id
storage.adapterOptions.secretAccessKey = your_secret_key
storage.adapterOptions.bucket = bassett-omeka-storage
```

Add the line:

```
storage.adapterOptions.region = us-east-1
```

In the Upload section, uncomment (remove prepended “;”) and change:

```
upload.maxFileSize = "100M"
```

2\. Set the upload limits in the Apache PHP configuration file:

```
cd /etc/php/8.1/apache2/
nano php.ini
```

Change values to:

```
post_max_size = 100M
upload_max_filesize = 100M
```

Note: do not set post_max_size to 0M. Although this disables the maximum for file uploads, it will prevent uploading in other circumstances.

## Establish an efficient work flow



## Enable IIIF tools



----

Questions? Comments? [Contact Steve Baskauf](mailto:steve.baskauf@vanderbilt.edu)

----
Revised 2023-08-04
