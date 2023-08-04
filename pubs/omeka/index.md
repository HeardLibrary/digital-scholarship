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

The cost to run the site should be around US$10 per month, excluding costs for a custom domain name. One reason that the cost is so low is that with the setup below, files are stored in AWS S3 buckets rather than in the file storage allocated to the EC2 instance. S3 storage is very inexpensive and can expand without limit, so the file storage attached to the EC2 server can be minimal. When the Omeka server is running, it requires few resources, so a relatively inexpensive, minimally provisioned EC2 type (t2.micro) can be used.

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

1\. Log in to AWS and create a bucket for Omeka file storage. In these examples I'm using a bucket called `bassett-omeka-storage`. 
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

Since we are going to use AWS S3 storage, there isn’t really any reason to restrict the file size. It’s possible that if pyramidal TIFFs are uploaded, the files could be very large, so I set the maximum size to 100 MB. As a practical matter, a t2.micro EC2 instance has problems processing image files larger than 50 MB, so 100 MB seems fine as a limit.

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

3\. Restart the server:

```
service apache2 restart
```

Now when you upload files, they will not be saved in the EC2 file storage, but rather be stored in the S3 bucket you set up in the [S3 setup](#s3-setup) section (`bassett-omeka-storage` in my examples). It is therefore possible to access the files directly from their S3 URLs independently of the Omeka EC2 server. However, the file names are based on opaque IDs assigned by Omeka, so without knowing the IDs, accessing the files is not practical. In the next section, we'll see how to capture the ID numbers after upload.

## Establish an efficient work flow

Once the S3 file storage is set up, you can manually upload items and enter their metadata by typing into boxes in the Omeka graphical interface. That's fine if you will only have a few objects. However, if you will be uploading many objects, uploading using the graphical interface is very tedious and requires many button clicks. 

The workflow described here is based on assembling the metadata in the most automated way possible, using file naming conventions, a Python script, and programatically created CSV files. Python scripts are also used to upload the files to S3, and from there they can be automatically imported into Omeka. 

After the items are imported, the CSV export plugin can be used to extract the ID numbers assigned to the items by Omeka. A Python script then extracts the IDs from the resulting CSV and inserts them into the original CSVs used to assemble the metadata.

**Notes about TIFF image files**. If original image files are available as high-resolution TIFFs, that is probably the best format to archive from the preservation standpoint. However, there are two considerations. Most browsers will not display TIFFs natively, while JPEGs can be displayed onscreen. The practical implication of this is that image thumbnails are linked directly to the original highres image file. So when a user clicks on the thumbnail of a JPEG, the image is displayed in their browser, but when a TIFF thumbnail is clicked, the file downloads to the user's hard drive without being displayed. When an image is uploaded, Omeka makes several JPEG copies at lower resolution so that they can be displayed onscreen.

The other thing to consider is that if the TIFFs will be used in a IIIF viewer, it is best for them to be saved in [tiled pyramidal form](https://cantaloupe-project.github.io/manual/3.3/images.html#Multi-Resolution). So if TIFFs are used, it is best to pre-process them to generate tiled pyramidal versions of them. In the workflow that follows, there is an additional first step that only applies to TIFFs. 

**Note about file sizes**. In the file configuration settings (previous section), we set a maximum file size of 100 MB. Virtually no JPEGs are ever that big, but some large TIFF files may exceed that size. As a practical matter, the upper limit on file size in this installation is actually about 50 MB. I have found from practical experience that original TIFF files between 50 and 100 MB can generate errors that will cause the server to hang. I have not been able to isolate the actual source of the problem, but it may be related to the process of generating the lower resolution JPEG copies. The problem may be isolated to using the CSV import plugin because some files that hung the server when using the CSV import were then able to be uploaded manually after creating the item record. In one instance, a JPEG that was only 11.4 MB repeatedly failed to upload using the CSV import. Apparently its large pixel dimensions (6144x4360) were the problem (it also was successfully uploaded manually).

The other thing to consider is that when TIFFs are converted to tiled pyramidal form, there is an increase in size of roughly 25% when the low-res layers are added to the original high-res layer. So a 40 MB raw TIFF may be at or over 50 MB after conversion. I have found that if I keep the original file size below 35 MB, the files usually load without problems.

The CSV import plugin requires that all items imported as a batch be the same general type. Since this process is build to handle images, that shouldn't be a problem -- all items will be Still Images. As a practical matter, it is convenient to assign all images in a batch to the same collection. If images intended for several collections are uploaded together in a batch, they will have to be assigned to collections manually after upload.

1\. If the files are TIFFs, use the script [convert_to_pyramidal_tiled_tiff.py](https://github.com/baskaufs/bassettassociates/blob/main/code/convert_to_pyramidal_tiled_tiff.py) to convert raw TIFFs to tiled pyramidal TIFFs. See the script comments for setup. Non-TIFF files (e.g. JPEGs) should be placed directly in the output directory.

2\. If you want to automate upload of the images, create a file called `credentials` (no file extension) that contains the following text:

```
[default]
aws_access_key_id = your_access_key
aws_secret_access_key = your_secret_access_key
```

Where `your_access_key` and `your_secret_access_key` are the credentials you saved after creating the IAM user for uploading to S3 from your computer. Save the file in a subdirectory of you home directory called `.aws` (note the dot in front of the name -- this will be a hidden directory). This is the correct location for Macs; I'm not sure if it's right for Windows. As noted before, do not expose this information publicly, although because of the security role given to the AIM user, the keys can only be used for uploading or deleting in the one S3 bucket.

3\. The Python script [omeka_upload_data.py](https://github.com/baskaufs/bassettassociates/blob/main/code/omeka_upload_data.py) uses some coding to automatically generate tags and original format types. The coding is also used to generate unique IDs for the items and file names corresponding to the IDs. The meaning of the codes is set in [the global variables section](https://github.com/baskaufs/bassettassociates/blob/8f5b139ede9a4c2107c8879668c2e52b0d04db3e/code/omeka_upload_data.py#L27-L92) of the script. 

The ID is composed of segments separated by underscores. The first one or two segments specifies any tags to be applied to the item. The next to last segment specifies the original format. The final segment is numeric and used to differentiate between items of the same type. If there are more than four segments, segments from the third to the third from last are ignored. 

Here are some examples:

----

Item identifier: [cmp_blu_pl_09](https://bassettassociates.org/archive/items/show/228)

Tags assigned: campus (from cmp) and Bluffton (from blu)
Original format: plan (from pl)
Sequence: 09 (from among Bluffton campus plans)

Optionally, the creator of the item can be assigned based on the original format code used as a key in the CREATOR_MAP. In this example, the creator is assigned as "Bassett Associates" whenever the original format type is plan.

----

Item identifier: [zoo_kcz_chimp_sk_01](https://bassettassociates.org/archive/items/show/410)

Tags assigned: zoo (from zoo) and Kansas City (from kcz)
Original format: sketch (from sk)
Sequence: 01 (from among Kansas City Zoo chimp exhibit sketches)
Creator: James H. Bassett (from original format of sketch)

In this example the `chimp` segment is ignored - it is just used to differentiate from among the several exhibits featured in the archive.

----

The Dublin Core Language value is assigned based on the [LANGUAGE_MAP](https://github.com/baskaufs/bassettassociates/blob/8f5b139ede9a4c2107c8879668c2e52b0d04db3e/code/omeka_upload_data.py#L52-L56). If an original media type is not in the map, it will not be assigned a language value. 

The identifiers created for the works should be put in a column with the header `identifier` in a CSV spreadsheet called `identifiers.csv`. There must also be two empty columns named `item_id` and `omeka_id`. (Note: it is assumed that there will be one media item per item. More are allowed by Omeka, but the workflow would need to be modified to account for this.). There may be additional columns that will be ignored by the Python scripts. See [this file](https://github.com/baskaufs/bassettassociates/blob/main/data/identifiers.csv) for an example. 

4\. The files should be renamed so that the first part (before the extension) of their name matches the assigned code. The extensions should correspond to those in the [FORMAT_MAP of the script](https://github.com/baskaufs/bassettassociates/blob/8f5b139ede9a4c2107c8879668c2e52b0d04db3e/code/omeka_upload_data.py#L27-L32) so that the Dublin Core Format values can be set automatically to the correct media type (MIME type) for the file. Note: the script was created to process images, so if non-image file types are used, an error will be generated [when the script tries to determine the pixel dimensions](https://github.com/baskaufs/bassettassociates/blob/8f5b139ede9a4c2107c8879668c2e52b0d04db3e/code/omeka_upload_data.py#L181-L184).

5\. Once the files have been renamed, run the `omeka_upload_data.py` script from the command line. Some metadata values are [hard-coded in the script](https://github.com/baskaufs/bassettassociates/blob/8f5b139ede9a4c2107c8879668c2e52b0d04db3e/code/omeka_upload_data.py#L165-L168), so they should be changed before the script is run. NOTE: it is important that a path argument be given after the script name in the command. This argument is used as the subpath for both the local storage location for the files and the subdirectory path in the S3 bucket. For example:

```
python3 omeka_upload_data.py zoo/kcz/chimp/
```

would append `zoo/kcz/chimp/` to the local storage directory path to make

```
/Users/baskausj/Downloads/bassett_raw_images/zoo/kcz/chimp/
```

and to generate the S3 bucket base URL:

```
https://bassettassociates.s3.amazonaws.com/zoo/kcz/chimp/
```

The script does three things:
1. Moves the files from the pyramidal TIFF output directory to the appropriate local storage location.
2. Uploads the files to the S3 raw image source bucket.
3. Create a metadata CSV file called `upload.csv` filled in based on the codes in the ID and values hard-coded in the script. The CSV is saved in the data directory specified by the `DATA_PATH` constant in the script.

6\. Open the `upload.csv` file using a spreadsheet editor like Libre Office Calc. Check that the Dublin Core:Language value is correct. Some automatically assigned types (e.g. sketch) may not actually have writing on them and should have the value deleted. Add the Dublin Core:Title value to all item records. It is best if the titles are unique and succinctly descriptive, although uniqueness is not required by Omeka. Add the Dublin Core:Date and Dublin Core:Description values if available. Examine the tags list (comma separated) and add or remove any as appropriate. Save the file in CSV format with UTF-8 encoding. Here is an [Example](https://github.com/baskaufs/bassettassociates/blob/1ebeee057edd22f8f71067a1028f3e46d0fba487/data/upload.csv) of a completed metadata upload file. 

7\. Before doing the CSV import for the first time, check to make sure that one of the `upload_url` values actually retrieves the designated file. If it does not, make sure the file has actually been uploaded into S3 using the AWS online console. Check that the `Object URL` for the file matches the value in the CSV and that the bucket is identified as having Access: Public.

8\. Log in to the Omeka site as an administrator or Super User. Add a public collection for the images if there isn't already one. 

9\. Click on the CSV Import option on the left pane. Browse to the `upload.csv` file and select it. Select "Still Image" as the item type. Select the collection you just created. Check the "Make All Items Public?" checkbox. Click `next`.

10\. Because the column headers in the CSV match the standard metadata field names, they should all be matched except for two. For upload_url, check the "Files?" checkbox. For the tags, check the "Tags?" checkbox. Click the Import CSV File button.

11\.You can refresh periodically to watch the upload progress. If the number of files in a batch are few and the file sizes are relatively small (<20 MB), the import usually works without any problems. If the process crashes or hangs, you may need to go into AWS and reboot the EC2 instance. In the EC2 control panel, check the box for the instance and select `Reboot instance` from the `Instance state` dropdown. Be patient and eventually the site will come up again. Check the items and delete items from the incomplete upload. Then start the upload again. The status of the incomplete upload will stay at "In Progress" forever but don't worry about it. 

12\. At this point, the items should be created and assigned to a collection, with the image file uploaded and viewable on the item page. The original image and the derived lower-resolution JPEG images will be in the S3 Omeka storage bucket you set up (`bassett-omeka-storage` in the examples). The versions will be stored in folders called `fullsize`, `original`, `square_thumbnails`, and `thumbnails`. As noted previously, the files will be named using an opaque identifier assigned by Omeka (e.g. `04864eefe984b71b50412faa2e65606d.jpg`). The files that you uploaded to the raw image source bucket (`bassettassociates` in this example) will still be there. In theory, you don't need them any more and could delete them. However, S3 storage costs are so low that you probably will just want to leave them there. Since they have meaningful file names and a subfolder organization of your choice, they would make a pretty nice cloud backup system that is independent of the Omeka instance. After your archive project is complete, you could change the raw image source bucket over to one of the cheaper, low-access types (like Glacier) that have even lower storage costs than a standard S3 bucket. Because both buckets are public, you can use them as a means of giving access to the original high-res files by simply giving the Object URL to the person wanting a copy of the file. 

13\. If you want to maintain an association between the original identifiers/file names and the opaque identifiers assigned by Omeka, you can optionally add a final step to your workflow. The CSV Export Format plugin allows you to export metadata about items as a CSV downloaded to your local computer. The annoying aspect of this is that you can only export data about items that are viewable on a single page of items (the `Select all x results` button does not seem to work for me). You can improve the situation by increasing the number of items displayed per page by going to the Appearance menu of the admin page, clicking on the Settings tabe, and then increasing the number for `Results Per Page (admin)`. To download the metadata, scroll to the bottom of the page containing the items you care about and click on the `csv` link after `Output Formats:`. It doesn't matter if other items that you don't care about are included. Put the resulting `export.csv` file into your local data directory. 

14\. Run the script [extract_omeka_csv_export_data.py](https://github.com/baskaufs/bassettassociates/blob/main/code/extract_omeka_csv_export_data.py). It will extract the item numbers and Omeka image IDs for the uploaded images and put them in the empty columns of the `identifiers.csv` file that you created earlier. It will also concatenate the newly written items from the `upload.csv`` file to the end of a file called `items.csv`. NOTE: you should run this script after each batch is uploaded since the `omeka_upload_data.py` script overwrites any previous `upload.csv` file. 

15. **Backing up data**. There are two mechanisms for backing up your data periodically. 

The most straightforward is to create an Amazon Machine Image (AMI) of the EC2 server. Not only will this save all of your data, but it will also archive the complete configuration of the server at the time the image is made. This is critical if you have any disasters while making major configuration changes and need to roll back the EC2 to an earlier (functional) state. To create an image, go to the EC2 control panel, check the box to the left of your instance name, then from the `Actions` menu, click `Images and templates`. Then select `Create image`. This will create both an "image" and a "snapshot". Give the image a name and detailed description and leave all of the other settings at their defaults. Click `Create image`. If you ever need to restore an image, click `AMIs` from the menu on the left (under `Images`). Select the checkbox of the image you want, and click the `Launch instance from AMI` button.

A simpler way to back up the item metadata is to push the `items.csv` and `identifiers.csv` files to GitHub after each CSV import. Any set of rows from the `items.csv` file can be saved as `upload.csv` and be used to re-upload those items onto any Omeka instance as long as the original files are still in the raw source image S3 bucket. The `identifiers.csv` file documents the link between the file identifiers you assigned and the opaque IDs assigned to the media items by Omeka. This information would be especially useful if you did not keep the originally uploaded files, since it would allow you to find the appropriate files in the `original` folder of the S3 Omeka storage bucket. Of course, if you make manual edits to the metadata, the metadata in the `items.csv` file would be stale.

## Enable IIIF tools

There are two Omeka plugins that add International Image Interoperability Framework (IIIF) capabilities. 

The [UniversalViewer plugin](https://omeka.org/classic/plugins/UniversalViewer/) allows Omeka to serve images like a IIIF image server and it generates IIIF manifests using the existing metadata. That makes it possible for the Universal Viewer player (included in the plugin) to display images in a rich manner that allows pan and zoom. This plugin was very appealing to me because if it functioned well, it would enable IIIF capabilities without needing to manage any other servers. I was able to install it and the embedded Universal Viewer did launch, but the images never loaded. Despite spending a lot of time messing around with the settings, disabling S3 storage, and launching a larger EC2 image, I was never able to get it to work, even for a tiny JPEG file. I read a number of Omeka forum posts about troubleshooting, but eventually gave up. If I had gotten it to work, there was one potential problem with the setup anyway. The t2.micro instance that I'm running has very low resource capacity (memory, number of CPUs, drive storage), which is OK as I've configured it because the server just has to run a relatively tiny MySQL database and serve static files from S3. Presumably this plugin would also have to generate the image variants that it's serving on the fly and that could max out it out quite easily. I'm disappointed that I couldn't get it to work, but I'm not confident that it's the right tool for a budget installation like this one.

I had more success with the [Iiif Toolkit plugin](https://omeka.org/classic/plugins/IiifItems/). It also provides an embedded Universal Viewer that can be inserted various places in Omeka. The major downside is that you must have access to a separate IIIF server to actually provide the images used in the viewer. I was able to test it out by loading images into the Vanderbilt Libraries' Cantaloupe IIIF server and it worked pretty well. However, setting up your own Cantaloupe server on AWS does not appear to be a trivial task and because of the resourcing issues I just described, it would probably cost a lot more per month to operate than the Omeka site itself. (Vanderbilt's server is running on a cluster with a load balancer, 2 vCPU, and 4 GB memory. All of these increases over a single t2.micro instance involve a significantly increased cost.) So in the absence of an available external IIIF server, this plugin probably would not be useful for an independent user with a small budget. 

One nice feature that I was not able to try was pointing the external server to the `original` folder of the S3 storage bucket. That would be a really nice feature since it would not require loading the images separately into dedicated storage for the IIIF server separate from what is already being provisioned for Omeka. Unfortunately, we have not yet got that working on the Libraries' Cantaloupe server as it seems to require some custom Ruby coding to implement.

**Installation instructions for the IIIF Toolkit**

Based on [instructions on the plugin page](https://omeka.org/classic/plugins/IiifItems/)

1\. While connected to the EC2 server via SSH and logged in as the root user:

```
cd /var/www/html/omeka/plugins
```

2\. Issue the command:

```
git clone https://github.com/utlib/IiifItems.git
```

git should be installed on the EC2 by default. There is no zip file to unzip or delete since the directories are being cloned directly from GitHub.

3\. Restart the server:

```
service apache2 restart
```

4\. From the Omeka admin page, go to the Plugins tab. Under IIIF Toolkit, click the `Install` button. 

5\. There are two other plugins that you may want to install that can make use of the IIIF Toolkit: Exhibit Builder and Simple Pages. They are included in the basic installation of Omeka, so no downloading is required. Just click their install buttons.

6\. There are two ways to get IIIF content into Omeka pages. One is to simply load an existing manifest into an Exhibit Builder page. After creating an exhibit, add a page. For content, select IIIF Manifest as the layout type, then click `Add new content block`. In the Content area, enter a manifest URL in the field to the right of the `Manifest` dropdown value. The IIIF manifest is simply rendered as is in an embedded viewer on the page. No items or metadata are added to the Omeka collection itself.

7\. A more useful function is to import canvases in order to add their content as Omeka items. Click on `IIIF Toolkit` in the left menu, then go to the `Import Items` tab. There are three import types. I explored importing `Manifest` and `Canvas` types since I had those data available. 

Manifest is the most straightforward, but the import was messy and always created a new collection for each item imported. In theory, this could be avoided by selecting an existing collection using the `Parent` dropdown, but this never worked for me. 

I concluded that importing canvases was the only feasible method. Unfortunately, canvas JSON usually doesn't exist in isolation -- it usually is part of the JSON for an entire manifest. The `From Paste` option is useful if you are capable of the tedious task of searching through the JSON for a whole manifest and copying just the JSON for a single canvas from it. I found it much more useful to just create a script that would generate minimal canvas JSON for an image and save it as a file, which could either be uploaded directly, or pushed to the web and read in through a URL. 

The script that I used to do this was [minimal_manifest.py](https://github.com/baskaufs/bassettassociates/blob/main/code/manifests/minimal_manifest.py). See the notes at the top of the script for use. In a nutshell, it gets the pixel dimensions from the image file, with labels and descriptions taken from a CSV file (the import does not use more information than that). These values are inserted into a JSON canvas template, then saved as a file. The script will loop through an entire directory of files, so it's relatively easy to make canvases for a number of images that were already uploaded using the CSV import function (just copy and paste labels and descriptions from the metadata CSV file). An example labels.csv file is [here](https://github.com/baskaufs/bassettassociates/blob/main/code/manifests/labels.csv). 

8\. Once the manifests have been generated, either upload them or paste their URLs (if they were pushed to the web). See [this example](https://s3.amazonaws.com/iiif-manifest.library.vanderbilt.edu/bassett/canvas/exhibit_pike_po_00.json) canvas file generated by the script from the CSV data above. Do not bother to check the `Set as Public?` checkbox because it does not work. For `Local Preview Size` and `Annotation Preview Size`, select Maximum. Click `Import`. 

9\. You will be taken to the Status panel. When the Status bar goes to "Completed", the item has been imported and you can look at it under items. See [this item created from the example data above](https://bassettassociates.org/archive/items/show/512). 

10\. Because there is no way to do this as a batch, nor to import metadata beyond the title and description, each item needs to be imported one at a time and the metadata added manually, or using the Bulk Metadata Editor plugin if possible. This makes uploading many items somewhat impractical. However, for very large images whose detail cannot be seen well in a single image on a screen, the ability to pan and zoom is pretty important. So for some items, like large maps, this tool can be very nice despite the extra work. For a good example, see the [panels page](https://bassettassociates.org/archive/exhibits/show/artspace/panels) from an Omeka exhibit. It is best viewed by changing the embedded viewer to full screen.

One thing that should be noted is that like other images associated with Omeka items, image import using the IIIF Toolkit generates thumbnail, square_thumbnail, and fullsize versions of the image. A IIIF import also generates an "original" JPEG version that is much smaller than the pyramidal tiled TIFF uploaded to the IIIF server. This means that it is possible to create items for TIFF images that are larger than the 50 MB recommended above. An example is the [Binder Park Master Plan](https://bassettassociates.org/archive/items/show/418). If you scroll to the bottom of its page and zoom in, you will see that an incredible amount of detail is visible because the original TIFF file was huge (347 MB). So using IIIF import is a way to display and make available very large image files that exceed the practical limit of 50 MB discussed above.



----

Questions? Comments? [Contact Steve Baskauf](mailto:steve.baskauf@vanderbilt.edu)

----
Revised 2023-08-04
