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

If you need superscripts in the page text, you can use the carat (`^`) character. It's supported in GitHub-flavored Markdown, but isn't part of basic Markdown. So the give the area of a circle, you can use

```
A = pi * r^2
```

which will be rendered as 

A = pi * r^2

However, there is no Markdown markup for subscript. So if you want to give the formula of water, you have to use the HTML tags like this:

```
water is H<sub>2</sub>O
```

which will be rendered as 

water is H<sub>2</sub>O



<img src="../images-pages/new_repo.png" style="border:1px solid black">



----
Revised 2021-09-13
