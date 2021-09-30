---
permalink: /manage/control/github/pages-urls/
title: Controlling the URL of your GitHub pages site
breadcrumb: Pages URLs
---

[previous page: Remote themes and controlling CSS](../pages-remotes/)

# Controlling the URL of your GitHub pages site

Creating an effective website is only one important aspect of reaching your audience. The URL of your website is part of its branding and makes it easier for users to access the site. A good URL for a website is both memorable and easy to type. In this lesson, we'll talk about ideas for creating a good URL for your GitHub Pages website.

## Terminology

**Domain name** The domain name is the last two pieces in the first part of a URL. For example, `vanderbilt.edu` is the domain name for Vanderbilt University's websites and it's composed of the *primary domain* `vanderbilt` and the *top-level domain* `.edu`.

**Subdomain** A subdomain is an optional third piece in the first part of a URL. For example, the subdomain `library` is a subdomain of `vanderbilt.edu` used to form the subdomain name `library.vanderbilt.edu`. A common subdomain for websites is `www` (for World Wide Web) and it usually is used for the primary website of an organization, for example `www.vanderbilt.edu`. Domain name owners have the ability to create many subdomains. In the GitHub pages system, the subdomain is assigned as the user account name and appended to `github.io`. 

**DNS** DNS stands for Domain Name System. It's a decentralized system that associates domain and subdomain names with Internet Protocol (IP) addresses. Because the system is decentralized, it may take some time (up to an hour) for changes made by your DNS provider to proliferate throughout the network. Thus, changes that you make will not immediately be visible when you test them in a browser.

**DNS provider** A DNS provider is a company that manages domain names for users. When you "buy" a domain name, your DNS provider takes care of the technical details of associating your domain name and any subdomains with the actual place where the website is hosted. For example, you may have acquired a domain name from GoDaddy and are hosting your website on GitHub. You would go into the GoDaddy system to map your domain name to the actual website location at GitHub. In some cases, the same provider will host the website and manage the DNS. 

# Site URL options

There are three options for controlling the URL of your GitHub Pages website:

- Using the default URL based on the repository name.
- Using a special repository name that allows you to drop the repository name from the URL.
- Using a custom domain name that you have purchased from a DNS provider.

Each of these options will be discussed below.

## The default site URL

In the first lesson, we saw that there was a relationship between the repository name and the URL at which the website pages will be displayed. Here's the pattern:

Repository URL pattern `https://github.com/accountname/repository/blob/branch/path`

Website URL pattern `https://accountname.github.io/repository/path`

The implication is that if you are going to have a meaningful URL for your site without paying for a custom domain, you would like to have both account and repository names that tell the users something about your site. For example, if your name was Junita Schmidt and you were creating you lab website, you might try to get the GitHub account name "schmidtresearch" and set up your website in a repo named "lab". That would make the URL for your web homepage: `https://schmidtresearch.github.io/lab/`.

This is not optimal, since it requires users to include the subpath `/lab/` in addition to the subdomain name.

## Simplifying the URL by dropping the repository name

It's possible to use only the subdomain name as the root URL for the website, and eliminate the subpath for the repository name. 

The trick is to name the repository as the eventual subdomain name when the website is rendered. Here is an example. I have a repository named `baskaufs.github.io`: 

<https://github.com/baskaufs/baskaufs.github.io>

To go to the website homepage, I can simply enter <https://baskaufs.github.io> without any additional path.  If I want to go to the page within the repo that has the path [/civil-war/about.htm](https://github.com/baskaufs/baskaufs.github.io/blob/master/civil-war/about.htm) within that repository, I can simply use the URL <https://baskaufs.github.io/civil-war/about.htm>, that is, the subdomain name followed directly by the path.

Since you can only have one repository named `account.github.io`, you can drop only drop the repository name for one website in the account. 

If you are using this method, then you would want to have a GitHub account name that is memorable for users. In the previous lab website, Dr. Schmidt might try to set up a GitHub account named `schmidtlab` so that her website homepage could be at the URL `https://schmidtlab.github.io`.


## Using a custom domain name

If you have purchased your own domain name, then it doesn't matter what your account and repository names are. When you set up the redirect, it will point directly to the website's source directory and the custom domain name will be followed immediately by the path. 

It is a common practice to map both the apex domain name and the `www` subdomain so that they will lead to the home page of the website. The typical behavior is that if a user enters `example.com` into a browser, they are automatically redirected to `www.example.com`. Try it with <https://vanderbilt.edu> and <https://google.com>. It is highly recommended that you configure your GitHub pages site to behave in this way, unless you plan to use a subdomain other than `www` for your website (e.g. `blog.example.com`). 

The [instructions for using a custom domain name with a GitHub Pages site](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site) give the complete setup details. The particular details for configuring the `www` subdomain and the apex domain to point to the same page are [here]. 

** NOTE:** *The following instructions are boiled down from the GitHub Pages help pages and have not been thoroughly tested. So if things don't work as described below, please fall back to the full GitHub pages instructions linked above.*

In brief, after you have set up your GitHub pages website, go through the following steps. As an example, we will assume that our researcher has purchased the domain name `junitaschmidt.info` to use with the GitHub pages site set up in the `lab` repo of her `schmidtresearch` GitHub account. NOTE: Do the setup on GitHub first before you make any changes at your DNS provider's site.

1\. Go to the settings page for your website's repository and click on the `Pages` link in the left navigation bar (the same place you went to set up the site in the first place.)

2\. In the `Custom domain` section, enter your domain name (without `www`). Juanita would enter `junitaschmidt.info`. Then click `Save`.

3\. Log in to your DNS provider. Navigate to the place where you can manage your DNS (page names will differ depending on the provider). 

4\. There are two possible ways your provider may offer to link your domain name to the GitHub pages site. 

- If there is an `ALIAS` or `ANAME` record option, create a record with a value that is the subdomain name of your GitHub pages site. For Juanita, she would use `schmidtresearch.github.io`. She should NOT include the subpath `/lab/` even through that's the last part of the website URL.
- If there is an `A` record option, create four records with the IP address values 

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

After this step, your apex domain should be connected to your GitHub site (i.e. `junitaschmidt.info` should lead to the website at `schmidtresearch.github.io/lab/`)

5\. To enable the `www` subdomain, continue editing records in your DNS provider's website. Create a `CNAME` record with a value that is the subdomain of the site. Juanita would use `schmidtresearch.github.io` (without the repo name subpath). After this is complete, both `junitaschmidt.info` and `www.junitaschmidt.info` should cause the user to land on the GitHub pages site at `schmidtresearch.github.io/lab/`. 

6\. Go to GitHub Desktop and pull the repository to get the DNS configuration updated on your local drive.

7\. You should enable *secure HTTP* (HTTPS) for your website. Near the bottom of the GitHub Pages settings page, there is a checkbox for `Enforce HTTPS`. When you first set up the custom domain, this option will be grayed out. After about an hour or so, it should become available. At that point check the box to enable it.  Typically, users just type the domain (or subdomain) name into a browser, but if they include the protocol prefix, they will use `https://` instead of `http://` once this option is enabled.

You may be wondering how the connection is made to the correct repository if it wasn't specified in the information given to the DNS provider. The information given to the DNS provider direct the user to the general GitHub pages server. That server uses information that it has internally (provided from the settings web page) to direct the traffic to the correct user account and repository. Look in the `docs` directory of your site repository. You should see a file called `CNAME` (with no file extension). This file contains your custom domain name and was created when you provided it on the GitHub website. Do not delete or modify this file or your custom domain will stop working. 

## Troubleshooting

The GitHub Pages documents has a [troubleshooting page](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/troubleshooting-custom-domains-and-github-pages) that might help. 

One way to get more information about what is going on with your domain name is to use the `dig` command from the terminal on a Mac. The following two commands will provide information about the `A` and `CNAME` settings that are in place for your domain:

```
dig a junitaschmidt.info
dig cname junitaschmidt.info
dig cname www.junitaschmidt.info
```

## What happens if you stop paying for your domain name?

Even if you map a custom domain name to the website, the default URLs we have been using all along will still work. So if you stop paying for the domain name, your website will still work as long as you link to the default URLs. 

For example, if Juanita stops paying for `junitaschmidt.info`, her website will still be available at `schmidtresearch.github.io/lab/`

----
Revised 2021-09-30
