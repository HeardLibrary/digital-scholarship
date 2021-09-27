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

The exact mechanism for controlling the appearance of the theme depends on the specific theme. The GitHub repository for the theme should include an explanation of the files that need to be modified to customize the theme. In the example, the [Usage section](https://github.com/LeNPaul/academic#Usage) of the README.md page explains how the various components are controlled. 

The general principle is that a file on your website will replace the content of the corresponding file in the remote theme. So if I want to change something, I need to download the appropriate file from the theme repository and place it in the same place in the file navigation structure on my website repository.

Let's start with the home page. The usage information says that the file `_layouts/home.html` defines the homepage. If I navigate to [that page on GitHub](https://github.com/LeNPaul/academic/blob/gh-pages/_layouts/home.html), I see that most of the page is filled in by Jekyll using information from elsewhere (the stuff in curly brackets). For example, in this code:

```
<div class="row g-5 mb-5">
  <div class="col-md-6">
    <h3 class="fw-bold">Research</h3>
    {{ content }}
  </div>
  <div class="col-md-6">
    <img src="{{ site.github.url }}/assets/img/home.jpg" alt="Home" width="100%">
  </div>
</div>
```

The level 3 header `Research` is hard-coded here, so I could change that in the file. I also see that the homepage image is supposed to be in a subfolder on the path `/assets/img/`. I'll start by going to Finder/File Explorer and creating a subdirectory of my `docs` directory called `_layouts`. 

<img src="../images-pages/create_layouts_folder.png" alt="create layouts folder" style="border:1px solid black">

On the `home.html` page in the remote theme GitHub site, right click on the `Raw` button, then selecte `Save Link As...`.

<img src="../images-pages/home_layout_raw_button.png" alt="right-click raw button" style="border:1px solid black">

Save the file in the `_layouts` folder you just created.

I've decided to change the homepage title from "Research" to "Scholarship", so I opened the file and changed the `h3` text:

<img src="../images-pages/change_homepage_title.png" alt="change h3 header" style="border:1px solid black">

Save the file and push the changes to GitHub.

After a few moments, I see the change on the homepage.

<img src="../images-pages/rendered_homepage_label.png" alt="home page with new label" style="border:1px solid black">

There are two other major things that I want to fix on the home page. The content is still stuff from my practice website. To change that, I need to edit my `index.md` Markdown homepage file. I'll change it to this:

```
- Adventurer
- Scholar
- Ecologist
- Data nerd
```

To change the image, I need to make an `assets` and `img` folder, then put my homepage image into it with the name `home.jpg` as specified in the homepage layout HTML file.

<img src="../images-pages/homepage_image.png" alt="add splash image for homepage" style="border:1px solid black">

Here's the result:



[next page: TBD](../pages-themes/)

----
Revised 2021-09-27
