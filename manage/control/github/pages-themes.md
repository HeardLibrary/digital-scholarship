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


<img src="../images-pages/new_repo.png" style="border:1px solid black">



----
Revised 2021-09-13
