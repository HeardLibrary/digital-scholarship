---
permalink: /manage/control/github/pages-remotes/
title: Using remote themes and controlling CSS
breadcrumb: Pages remote themes
---

[previous page: Using themes and HTML markup with GitHub Pages](../pages-themes/)

# Remote themes

The built-in themes provided by GitHub itself are few and not very sophisticated. However, there are [over a thousand freely available themes](https://github.com/topics/jekyll-theme) that have been created by others, and many of them have more features than the built-in themes. These themes are called *remote themes* because their styling is controlled by configuration details that are not included within the user's website. The theme developers maintain the themes and may update them periodically.

## Finding a theme

The [Jekyll documentation website](https://jekyllrb.com/) has a [themes page](https://jekyllrb.com/docs/themes/) that provides links to four other websites that have extensive galleries showing what available themes look like when they are rendered. 

In most cases, the theme info page will link to a demo page that will show you what the theme looks like and will have a link to the GitHub site hosting the theme. For example, [academic](https://jamstackthemes.dev/theme/jekyll-academic/) is a theme for an academic website. There is a [demo page](https://jamstackthemes.dev/demo/theme/jekyll-academic/) and the [GitHub site](https://github.com/LeNPaul/academic) contains information about installing and configuring the site). We will use this site in the examples that follow.

## Specifying a theme

To switch to the remote theme, you need to change the `_config.yml` file to replace the built-in theme that you were using before. First, get the path to the remote theme. Go to the [GitHub site for the theme](https://github.com/LeNPaul/academic).

<img src="../images-pages/remote_url.png" alt="URL for GitHub repo for remote theme" style="border:1px solid black">

Copy the last part of the URL after `https://github.com/`. Open the `_config.yml` file, which should be located within the `docs` folder of your website repo. Delete the line for the theme you had before and replace it with the key `remote_theme` and paste the last part of the URL that you copied as the value.

![YAML file with remote theme](../images-pages/remote_yaml.png)

Save the file, then use GitHub Desktop to push the changes to GitHub. 

After some time has passed, go to the website URL and refresh the page. Eventually, you should see the new theme applied to the web page you had before. 

<img src="../images-pages/unmodified_remote_theme.png" alt="website rendered using remote theme" style="border:1px solid black">

Since this theme has more features than just the styling, I will need to make additional changes to the configuration.

## Configuring the theme



[next page: TBD](../pages-themes/)

----
Revised 2021-09-27
