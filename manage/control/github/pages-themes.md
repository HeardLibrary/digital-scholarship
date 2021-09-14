---
permalink: /manage/control/github/pages-themes/
title: Using themes and HTML markup with GitHub Pages
breadcrumb: Pages themes
---

[previous page: Managing a website with GitHub Pages](../pages/)

# Using HTML markup in GitHub Pages

It is easy to create basic web page elements using Markdown and let Jekyll turn them into the HTML necessary to render the styled web page. However, the ability to control the formatting of a page using only Markdown is somewhat limited.

For that reason, Jekyll will support including HTML tags in the text of pages. In fact, it's possible to just paste HTML for a whole page directly into a document to be included in the website, although this would somewhat defeat the purpose of having a simple system like GitHub Pages to manage a static website. It's more typical to include HTML if the markup feature isn't available in Markdown, or if the styling of the element needs to be controlled more than is possible using simple Markdown markup. We will take a look at examples of both kinds.

## HTML markup not available in Markdown

If you need superscripts in the page text, in some versions you can use the carat (`^`) character. So the give the area of a circle, you would use

```
A = pi * r^2
```

However, carat is not supported in GitHub-flavored Markdown and there is no Markdown markup for subscript. So if you want to write the area of a circle or give the formula of water, you have to use the HTML tags like this:

```
A = pi * r<sup>2</sup>

water is H<sub>2</sub>O
```

which will be rendered as 

water is H<sub>2</sub>O 

A = pi * r<sup>2</sup> 

**Newlines (line breaks)**

In the last lesson, we saw that the Markdown that we used for the image credit didn't turn out well. Since text on adjacent lines (without an intervening newline) are mushed together, this markup:

```
![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)
[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)
```

rendered like this:

![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)
[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)

A simple solution to this problem is to follow the end of the line where you want the newline to occur with an HTML `<br/>` tag, like this:

```
![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)<br/>
[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)
```

rendered like this:

![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)<br/>
[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)

You could also force a newline by putting a blank line between the image and the credit line, but usually we want the credit to be small and right under the image.

(It's also possible to force a newline at the end of the line by putting two trailing spaces at the end of a line, but one of the principles of Markdown is that you should easily be able to look at the raw text and know what's going on. So that's why putting an explicit break tag is probably better.)

As we've marked this up now, the credit line is normal text. If we want it to be smaller, we can use the HTML tag `<small>`. That would change the markup to this:

```
![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)<br/>
<small>[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)</small>
```

rendered like this:

![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)<br/>
<small>[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)</small>

A better approach would probably be to apply a style for credit lines using CSS, but that's too advanced for this lesson.

There are many places online to find HTML tags. the [W3 Schools HTML tutorial](https://www.w3schools.com/html/) is nice because its "Try it Yourself" editor lets you see the results of your markup.

## HTML markup to customize features available in Markdown

Sometimes Markdown has markup for the page feature you want, but it doesn't work the way you want. 

**Hyperlinks**

For example, when we wanted to add a link, we used Markdown's link syntax like this:

```
You can read more about them by going to their [Wikipedia page](https://en.wikipedia.org/wiki/Star-nosed_mole).
```

rendered like this:

You can read more about them by going to their [Wikipedia page](https://en.wikipedia.org/wiki/Star-nosed_mole).

However, it can be annoying if a link leads you away from the page you are reading. If you want the link to open in a new tab, you need to use HTML to create the link using an anchor (`<a>`) element with a `target` attribute, like this:

```
You can read more about them by going to their <a href="https://en.wikipedia.org/wiki/Star-nosed_mole" target="_blank">Wikipedia page</a>.
```

rendered like this:

You can read more about them by going to their <a href="https://en.wikipedia.org/wiki/Star-nosed_mole" target="_blank">Wikipedia page</a>.

and makes it more apparent where the screenshot begins and ends.

**Images**

If we want to insert an image, we can use the Markdown markup for images like this:

```
![screenshot from Wikipedia](../images-pages/screenshot.png)
```

which renders like this:

![screenshot from Wikipedia](../images-pages/screenshot.png)

However, for images like screenshots, it can be confusing if the image isn't outlined. To add a black line around the image, we can use HTML markup:

```
<img src="../images-pages/screenshot.png" alt="screenshot from Wikipedia" style="border:1px solid black">
```

which renders like this:

<img src="../images-pages/screenshot.png" alt="screenshot from Wikipedia" style="border:1px solid black">

**Tables**

GitHub flavored Markdown can be use to construct tables. For example: 

```
First Header | Second Header
------------ | -------------
Content cell 1 | Content cell 2
Content column 1 | Content column 2
```

Renders like this:

First Header | Second Header
------------ | -------------
Content cell 1 | Content cell 2
Content column 1 | Content column 2

However, if you don't want the default formatting with lines around the cells, you can use HTML instead. 

NOTE: some aspects of tables, such as their default width, may be set by the CSS of the theme that's styling the page. For example, the CSS for the page theme on this website sets table widths to 100% of the page width, which is how it appears above. That won't be the case if you use the same code in an unstyled web page.

```
<table style="border: none; width: unset">
<tr style="border: none;"><th style="border: none;">First Header</th><th style="border: none;">Second Header</th></tr>
<tr style="border: none;"><td style="border: none;">Content cell 1</td><td style="border: none;">Content cell 2</td></tr>
<tr style="border: none;"><td style="border: none;">Content column 1</td><td style="border: none;">Content column 2</td></tr>
</table>
```

which renders like this

<table style="border: none; width: unset">
<tr style="border: none;"><th style="border: none;">First Header</th><th style="border: none;">Second Header</th></tr>
<tr style="border: none;"><td style="border: none;">Content cell 1</td><td style="border: none;">Content cell 2</td></tr>
<tr style="border: none;"><td style="border: none;">Content column 1</td><td style="border: none;">Content column 2</td></tr>
</table>

In the style for the table element, I unset the width to remove the width setting set by the theme CSS.

Although it is not a best practice for accessibility, borderless tables can be used to organize content on the page. Here's an example:

```
<table style="border: none; width: unset">

<tr style="border: none;">
<td style="border: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Two_hugging_cats.jpg/128px-Two_hugging_cats.jpg"></td>
<td style="border: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Jezebel%2C_a_black_and_white_cat.jpg/128px-Jezebel%2C_a_black_and_white_cat.jpg"></td>
</tr>

<tr style="border: none;">
<td style="border: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Cat_wearing_sunglasses.jpg/128px-Cat_wearing_sunglasses.jpg"></td>
<td style="border: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Cat_portrait_%2829484396147%29.jpg/256px-Cat_portrait_%2829484396147%29.jpg"></td>
</tr>

</table>
```

Rendered:

<table style="border: none; width: unset">

<tr style="border: none;">
<td style="border: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Two_hugging_cats.jpg/128px-Two_hugging_cats.jpg"></td>
<td style="border: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Jezebel%2C_a_black_and_white_cat.jpg/128px-Jezebel%2C_a_black_and_white_cat.jpg"></td>
</tr>

<tr style="border: none;">
<td style="border: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Cat_wearing_sunglasses.jpg/128px-Cat_wearing_sunglasses.jpg"></td>
<td style="border: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Cat_portrait_%2829484396147%29.jpg/256px-Cat_portrait_%2829484396147%29.jpg"></td>
</tr>

</table>

Notice that when I put the images inside the table, I had to use HTML markup to display the image, not the Markdown markup.

# Using a canned page theme

When we turned on GitHub Pages in the repository settings, we opted not to set a page theme. The easiest way to apply one of the canned GitHub Pages themes is to return to the settings page and select one of the themes. 

## Choosing a canned theme in Settings

Go to Settings, then Pages, and click `Choose a theme` if you don't already have one or `Change theme` if you already have one and want to change it. See [these instructions](https://docs.github.com/en/pages/getting-started-with-github-pages/adding-a-theme-to-your-github-pages-site-with-the-theme-chooser) if you need screenshots.

When you click on one of the theme options at the top of the selection page, it will show you the style of the theme in the lower part of the page. Here's an example:

<img src="../images-pages/theme_example.png" alt="screenshot of Architect theme" style="border:1px solid black">

Click on the `Select theme` button to apply it to your website. Here's how my home page looked without a theme:

<img src="../images-pages/no_theme.png" alt="no-theme homepage" style="border:1px solid black">

Here it is with the Architect theme:

<img src="../images-pages/architect_theme.png" alt="Architect theme homepage" style="border:1px solid black">

Since the page styling is all handled by the theme, it is very simple to just go back into the theme chooser and pick another one. Here's the page with the Merlot theme:

<img src="../images-pages/merlot_theme.png" alt="Merlot theme homepage" style="border:1px solid black">

If we examine the commit history, we see that selecting or changing the theme resulted in a commit that added or changed a file within the `docs` folder: `_config.yml`.

<img src="../images-pages/add_config_yml.png" alt="config commit" style="border:1px solid black">

The theme and other configuration settings are controlled by this file. 

## Editing site settings in _config.yml

Since it is just a text file, you can edit it and [change the theme without going to the settings page](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-a-theme-to-your-github-pages-site-using-jekyll). The format of the settings page is [YAML](https://yaml.org/), which stands for "YAML Ain't Markup Language". It is a commonly used format for configuration files and is very simple. The settings generally include a `key` (or `variable`), then a colon, then the `value` for that key. For example:

```
theme: architect
```

Depending on your theme, there may be other page settings that you can make to change the appearance of the site as well as site metadata. On the theme preview page in Settings, you can right-click on the `View project on GitHub` button and open the link in a new tab.

<img src="../images-pages/theme_link.png" alt="screenshot showing link to theme website" style="border:1px solid black">

That will take you to the GitHub site where the theme is maintained. Scroll down the README.md page until you find the `Customizing` section. It will tell you what variables can be set to customize your theme.

<img src="../images-pages/customizing_instructions.png" alt="instructions for customizing" style="border:1px solid black">

Adding an `author` variable may also add that information to the page metadata in the HTML head section. 

You can also navigate to the theme's `_config.yml` file to see how the options are listed there.

<img src="../images-pages/theme_repo_files.png" alt="theme file list" style="border:1px solid black">

<img src="../images-pages/theme_config_example.png" alt="theme _config.yml file" style="border:1px solid black">

Here's what it looked like when I edited my `_config.yml` file

<img src="../images-pages/editing_config_yml.png" alt="edited config file" style="border:1px solid black">

After I committed and pushed the changed configuration file to GitHub, then waited a little while, here's how my homepage looked:

<img src="../images-pages/configured_styled_homepage.png" alt="homepage after new configuration" style="border:1px solid black">


----
Revised 2021-09-13
