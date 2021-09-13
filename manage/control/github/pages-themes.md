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
A = pi * r ^2
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

There are many places online to find HTML tags. the [W3 Schools HTML tutorial](https://www.w3schools.com/html/) is nice because it's "Try it Yourself" editor lets you see the results of your markup.

## HTML markup to customize features available in Markdown

Sometimes Markdown has markup for the page feature you want, but it doesn't work the way you want. 

**Hyperlinks**

For example, when we wanted to add a link, we used Markdown's link syntax like this:

```
You can read more about them by going to their [Wikipedia page](https://en.wikipedia.org/wiki/Star-nosed_mole).
```

rendered like this:

You can read more about them by going to their [Wikipedia page](https://en.wikipedia.org/wiki/Star-nosed_mole).

However, it can be annoying if a link leads you away from the page you are reading. If you want the link to open in a new tab, you need to use HTML to create the link using an anchor (<a>) element with a `target` attribute, like this:

```
You can read more about them by going to their <a href="https://en.wikipedia.org/wiki/Star-nosed_mole" target="_blank">Wikipedia page</a>.
```

rendered like this:

You can read more about them by going to their <a href="https://en.wikipedia.org/wiki/Star-nosed_mole" target="_blank">Wikipedia page</a>.

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


----
Revised 2021-09-13
