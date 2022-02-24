---
permalink: /manage/control/github/pages-urls/
title: Using a custom domain name with your GitHub pages site
breadcrumb: custom URL
---

[return to: Creating a website with GitHub pages](../../../script/codegraf/043/)

# Using a custom domain name with your GitHub Pages website

If you have purchased your own domain name, then it doesn't matter what your account and repository names are. When you set up the redirect, it will point directly to the website's source directory and the custom domain name will be followed immediately by the path. 

It is a common practice to map both the apex domain name and the `www` subdomain so that they will lead to the home page of the website. The typical behavior is that if a user enters `example.com` into a browser, they are automatically redirected to `www.example.com`. Try it with <https://vanderbilt.edu> and <https://google.com>. It is highly recommended that you configure your GitHub pages site to behave in this way, unless you plan to use a subdomain other than `www` for your website (e.g. `blog.example.com`). 

The [instructions for using a custom domain name with a GitHub Pages site](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site) give the complete setup details. The particular details for configuring the `www` subdomain and the apex domain to point to the same page are [here](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site#configuring-an-apex-domain-and-the-www-subdomain-variant). 

In brief, after you have set up your GitHub pages website, go through the following steps. As an example, we will assume that our researcher has purchased the domain name `junitaschmidt.info` to use with the GitHub pages site set up in the `lab` repo of her `schmidtresearch` GitHub account. NOTE: Be sure to do the setup on GitHub (steps 1 and 2) first before you make any changes at your DNS provider's site (steps 3 to 5).

1\. Go to the settings page for your website's repository and click on the `Pages` link in the left navigation bar (the same place you went to set up the site in the first place.)

2\. In the `Custom domain` section, enter your domain name (without `www`). Juanita would enter `juanitaschmidt.info`. Then click `Save`.

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

After this step, your apex domain should be connected to your GitHub site (i.e. `juanitaschmidt.info` should lead to the website at `schmidtresearch.github.io/lab/`)

5\. To enable the `www` subdomain, continue editing records in your DNS provider's website. Create a `CNAME` record with a value that is the subdomain of the site. Juanita would use `schmidtresearch.github.io` (without the repo name subpath). After this is complete, both `junitaschmidt.info` and `www.juanitaschmidt.info` should cause the user to land on the GitHub pages site at `schmidtresearch.github.io/lab/`. 

6\. Go to GitHub Desktop and pull the repository to download the DNS configuration file to your local drive.

7\. You should enable *secure HTTP* (HTTPS) for your website. Near the bottom of the GitHub Pages settings page, there is a checkbox for `Enforce HTTPS`. When you first set up the custom domain, this option will be grayed out. After about an hour or so, it should become available. At that point check the box to enable it.  Typically, users just type the domain (or subdomain) name into a browser, but if they include the protocol prefix, they will use `https://` instead of `http://` once this option is enabled.

You may be wondering how the connection is made to the correct repository if it wasn't specified in the information given to the DNS provider. The information given to the DNS provider routes the browser to the general GitHub pages server. That server uses information that it has internally (provided from the settings web page) to direct the traffic to the correct user account and repository. Look in the `docs` directory of your site repository. You should see a file called `CNAME` (with no file extension). That file contains your custom domain name and was created when you provided it on the GitHub website. Do not delete or modify this file or your custom domain will stop working. 

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

[return to: Creating a website with GitHub pages](../../../script/codegraf/043/)

----
Revised 2022-02-23
