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
- basic familiarity with CSV spreadsheets and experience with editing and saving in the CSV format. Although it is possible to use Excel for this, it is highly recommended to use the open source [Libre Office](https://www.libreoffice.org/) Calc instead, since it avoids all of the common gotchas that are typically experienced by new users who uses Excel to manage CSVs.
- if automating upload of files to AWS S3, ability to run Python scripts from the command line.

## Intended users

This tutorial is intended for users who want to set up a single digital archive or create a relatively simple digital online exhibit using Omeka Classic. Larger users may be better off with the multi-site Omeka S product (not covered in this tutorial). The tutorial includes enabling editing access to the site by multiple users.

The cost to run the site should be around US$10 per month, excluding costs for a custom domain name.

The tutorial only covers installation, setup, and loading files. It does not cover styling or creating custom web pages. Using International Image Interoperability Framework (IIIF) features is covered to some extent.

## Steps in the process

The following steps are necessary to create a fully functional Omeka site. Under some circumstances, it may be possible to skip some of the steps, particularly if you are only interested in testing Omeka. However, if you want to actually run a production site long-term, you probably will need to complete all of the steps.

1. 

----

Questions? Comments? [Contact Steve Baskauf](mailto:steve.baskauf@vanderbilt.edu)

----
Revised 2023-08-03
