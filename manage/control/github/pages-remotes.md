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

In most cases, the theme info page will link to a demo page that will show you what the theme looks like and will have a link to the GitHub site hosting the theme. For example, [academic](https://jamstackthemes.dev/theme/jekyll-academic/) is a theme for an academic website. It has a [demo page](https://jamstackthemes.dev/demo/theme/jekyll-academic/) and the [GitHub site](https://github.com/LeNPaul/academic) contains information about installing and configuring the site. We will use this site in the examples that follow.

NOTE: to see the final configuration of the example files, see [this repository](https://github.com/baskaufs/example_website/). To see the website in rendered form go to [the homepage](https://baskaufs.github.io/example_website/).

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

```xml
<div class="row g-5 mb-5">
  <div class="col-md-6">
    <h3 class="fw-bold">Research</h3>
    {% raw  %} {{ content }} {% endraw  %}
  </div>
  <div class="col-md-6">
    <img src="{{ site.github.url }}/assets/img/home.jpg" alt="Home" width="100%">
  </div>
</div>
```

the level 3 header `Research` is hard-coded here, so I could change that in the file. I also see that the homepage image is supposed to be in a subfolder on the path `/assets/img/`. I'll start by going to Finder/File Explorer and creating a subdirectory of my `docs` directory called `_layouts`. 

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

<img src="../images-pages/redesigned_homepage.png" alt="add splash image for homepage" style="border:1px solid black">

The goal here is that once the website is set up, changes should easily be made by just changing content (the Markdown pages and images) without having to actually change any of the page templates.

## Changing included data

Metadata that's included in the site (email addresses, Twitter buttons, etc.) and the navigation structure are controlled by data in a YAML file rather than hard-coding it. The metadata are inserted in the appropriate spots when Jekyll builds the site. 

The Usage instructions say that contact information is defined in the `_data/settings.yml` file. In most remote themes, there is typically some YAML file like this in an obvious directory (e.g. "data") that controls such settings. As we did with the homepage layout file, create a `_data` folder, then download the `settings.yml` file [from the theme GitHub site](https://github.com/LeNPaul/academic/blob/gh-pages/_data/settings.yml). Open it with your text editor and change the settings to fit your circumstances.

```yaml
menu:
- {name: 'publications', url: '/publications'}
- {name: 'cv', url: '/cv'}
- {name: 'contact', url: '/contact'}

social:
- {icon: 'github', link: 'https://github.com/baskaufs'}
- {icon: 'twitter', link: 'https://twitter.com/baskaufs'}
- {icon: 'instagram', link: 'https://instagram.com/baskaufs'}

contacts:
- {name: 'Steve Baskauf', title: 'Data Science and Data Curation Specialist', department: 'Digital Scholarship and Communications (DiSC)', institution: 'Vanderbilt University Libraries', institution_address: 'Nashville, Tennessee, USA', phone: '(615) 123-4567', email: 'steve.baskauf@vanderbilt.edu', office: 'Eskind Biometical Library 111', image: 'assets/img/contact.jpg'}
```

Notice that since I don't have lab personnel or courses, I deleted that information from the data. Similarly, I don't use LinkedIn, so I deleted that line from the `social` settings.

In order to get the `contact` page to work, I need to download the skeleton `contact.md` page. It only consists of a YAML header and the rest will be built from the contact page template and the data I provided in the `settings.yaml` file. Similarly, the `cv` page is built from `cv.md` using data from YAML files defined in the `_data/cv` directory. 

<img src="../images-pages/add_necessary_files.png" alt="add skeleton pages and contact image" style="border:1px solid black">

Here's how the `contact` page looks after saving the settings and adding the skeleton `contact.md` file.

<img src="../images-pages/rendered_contact_page.png" alt="add skeleton pages and contact image" style="border:1px solid black">

According to the Usage instructions, publications can be defined using the `_data/publications.yml` file and PDFs can be served from the `publications` directory. (NOTE: for some reason, I didn't get the direct display of uploaded PDFs to work.)  The `index` section shows up on the `publications` page accessed through the `publications` tab. I think the `featured` category is supposed to show up on the homepage.

```yaml
featured:
- {name: 'Baskauf, SJ and JK Baskauf. 2021. Using the W3C Generating RDF from Tabular Data on the Web Recommendation to manage small Wikidata datasets. Semantic Web Journal (in press).', url: '/publications/swj2810.pdf'}
- {name: 'Groom, Q, P Desmet, L Reyserhove, T Adriaens, D Oldoni, S Vanderhoeven, SJ Baskauf, A Chapman, M McGeoch, R Walls, J Wieczorek, JRU Wilson, PFF Zermoglio, A Simpson. 2020. Degree of Establishment Controlled Vocabulary List of Terms. Biodiversity Information Standards (TDWG)', url: 'http://rs.tdwg.org/dwc/doc/doe/'}

index:
- {name: 'Baskauf, SJ and JK Baskauf. 2021. Using the W3C Generating RDF from Tabular Data on the Web Recommendation to manage small Wikidata datasets. Semantic Web Journal (in press).', url: '/publications/swj2810.pdf'}
- {name: 'Groom, Q, P Desmet, L Reyserhove, T Adriaens, D Oldoni, S Vanderhoeven, SJ Baskauf, A Chapman, M McGeoch, R Walls, J Wieczorek, JRU Wilson, PFF Zermoglio, A Simpson. 2020. Degree of Establishment Controlled Vocabulary List of Terms. Biodiversity Information Standards (TDWG)', url: 'http://rs.tdwg.org/dwc/doc/doe/'}
```

"Updates" can be provided by placing Markdown files named using a particular scheme demonstrated in the `_posts` directory (ISO date at beginning of filename). I can download and hack one of the example ones in order to get the correct YAML header, replacing the Lorem ipsum content with my own. Here's an example:

Filenames:

<img src="../images-pages/posts_directory.png" alt="add skeleton pages and contact image" style="border:1px solid black">

Markdown:

```
---
layout: post
title: "VanderBot workshop"
---

I conducted a workshop at the LD4 Conference on Linked Data called "Writing data to Wikidata using spreadsheets". You can watch a [video of the presentation on YouTube](https://youtu.be/ZukSQB8fki8).
```

The final rendered homepage looks like this, with the publications and updates being summarized as links there.

<img src="../images-pages/final_homepage.png" alt="final styled homepage" style="border:1px solid black">

## Troubleshooting

Although every theme operates differently, the general principles shown here tend to apply to most remote themes. However, you will generally have to play around with the settings to get the theme to work the way you want. Before you commit to a theme and putting a lot of work into creating content for it, you should make sure that you can get its important features to work. If you can't figure out how to get them to work, you may want to change themes.

One annoying aspect of the approach taken here was that we had to download each of the individual files that were needed to override the theme settings. It is possible to take the "nuclear option" and just download the entire theme locally on your computer. The advantage is that you will have every file that you need locally without having to download them one-by-one. One disadvangage is that there will be a lot of unnecessary files that will make it difficult to navigate around to find and change only the relevant files. Another disadvantage is that if the theme developer fixes bugs or improves the theme, you won't get the changes because you are overriding every file that the developer might change with the ones you include in the website repo. That might be a good thing if you like the theme the way it is and don't want it to change, but it prevents improvements.

To download the entire theme, first fork the repository to your account using the `Fork` button at the upper right of the theme's GitHub repository. Navigate to where the repository is forked on your account and change its settings to make it a GitHub Pages website. You can then clone the fork to your local drive, modify the files on your computer using a code editor, and push the changes to GitHub. (For more information on forking repositories, see [this page](https://heardlibrary.github.io/digital-scholarship/manage/control/github/fork/).)

# Changing the styling of a remote theme

One of the reasons for creating a GitHub Pages website is to be able to pick a theme that already has the styling you want and avoid coding CSS yourself. However, sometimes a theme may be almost exactly what you want but needs a slight tweek to the styling, such as changing the default font or colors for the theme.

For example, this website is built using the built-in theme [Leap Day](https://github.com/pages-themes/leap-day). However, if you look at [the theme preview], you will see that there are a number of changes that have been made to the theme -- most obviously the theme colors and font.  

Here is a simple homepage using the Leap Day theme that I'll use in the following examples:

<img src="../images-pages/bare_leap_day.png" alt="bare bones Leap Day homepage" style="border:1px solid black">

## Modifying the default stylesheet

The exact way to change the CSS depends on how complicated the theme is. The default styles are typically in a directory called `_sass`. There may be a number of files within that directory having `.sass` file extensions, so it can be a challenge to figure out which one to change. In the case of the Leap Day theme, there are relatively few in the [_sass directory](https://github.com/pages-themes/leap-day/tree/master/_sass) and the one that actually controlls things is [
jekyll-theme-leap-day.scss](https://github.com/pages-themes/leap-day/blob/master/_sass/jekyll-theme-leap-day.scss). 

To override the defaults, I add CSS code to a file in the [/assets/css/ directory](https://github.com/pages-themes/leap-day/blob/master/assets/css). In the case of Leap Day, there is only one file: [style.scss](https://github.com/pages-themes/leap-day/blob/master/assets/css/style.scss), so the choice is easy. 

The file as it currently stands has very little code in it:

```
---
---

@import 'jekyll-theme-leap-day';
```

I'll download a copy of it locally in the same directory structure. 

<img src="../images-pages/downloaded_scss.png" alt="location of downloaded scss file" style="border:1px solid black">

then edit it using my code editor. You can use the "inspect" feature of your browser to figure out what part of the CSS controls the different sections of the page.

<img src="../images-pages/edit_scss.png" alt="change default colors" style="border:1px solid black">

I chose the Vanderbilt brand colors black (#000000) and gold (#D8AB4C). After pushing the changes and reloading the page, the colors have changed.

<img src="../images-pages/homepage_new_colors.png" alt="homepage rendered with new colors" style="border:1px solid black">

If you want to change a value, you can set a new value in this file and it will override the defaults. However, if you want to remove a setting entirely, you need to use an `unset` value. For example, I think the font used in the body is hard to read. I can unset the font and leave it to the browser default, then change the font color to black using this CSS:

```
body {
    font: unset;
    color: #000000;
}
```

Now the page looks like this:

<img src="../images-pages/homepage_better_font.png" alt="homepage rendered with plain black font" style="border:1px solid black">

The entire CSS file now looks like this:

```
---
---

@import 'jekyll-theme-leap-day';

body {
    font: unset;
    color: #000000;
}

header {   
    background: #000000; 
    h1 {
        color: #D8AB4C;
    }
}

#banner { 
    background: #D8AB4C;
}
```

Finding the right file to change and digging into the CSS is not for the faint of heart. But if you can get help from someone with a little web design experience, it's possible to make small changes like this.

## Skins



[next page: TBD](../pages-themes/)

----
Revised 2021-09-27
