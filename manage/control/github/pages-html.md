---
permalink: /manage/control/github/pages-html/
title: HTML markup with GitHub Pages
breadcrumb: Pages HTML
---

[return to: Creating a website with GitHub pages](../../../script/codegraf/043/)

# Using HTML markup in GitHub Pages

It is easy to create basic web page elements using Markdown and let Jekyll turn them into the HTML necessary to render the styled web page. However, the ability to control the formatting of a page using only Markdown is somewhat limited.

For that reason, Jekyll will support including HTML tags in the text of pages. In fact, it's possible to just paste HTML for a whole page directly into a document to be included in the website, although this would somewhat defeat the purpose of having a simple system like GitHub Pages to manage a static website. It's more typical to include HTML if the markup feature isn't available in Markdown, or if the styling of the element needs to be controlled more than is possible using simple Markdown markup. We will take a look at examples of both kinds.

## HTML markup not available in Markdown

If you need superscripts in the page text, in some versions of Markdown you can use the carat (`^`) character. So the give the area of a circle, you would use

```
A = pi * r^2
```

However, carat for superscripts is not supported in GitHub-flavored Markdown and there is no Markdown markup at all for subscript. So if you want to write the area of a circle or give the formula of water, you have to use the HTML tags like this:

```
A = pi * r<sup>2</sup>

water is H<sub>2</sub>O
```

which will be rendered as 

A = pi * r<sup>2</sup> 

water is H<sub>2</sub>O 

**Newlines (line breaks)**

In the last lesson, we saw that the Markdown that we used for the image credit didn't turn out well. Since text on adjacent lines (without an intervening newline) are mushed together, this markup:

```
![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)
[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)
```

was rendered like this with the caption to the right of the image:

![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)
[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)

A simple solution to this problem is to follow the end of the line where you want the newline to occur with an HTML `<br/>` tag, like this:

```
![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)<br/>
[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)
```

which will be rendered like this:

![front view of a star-nosed mole](https://upload.wikimedia.org/wikipedia/commons/e/ef/Condylura.jpg)<br/>
[US National Parks Service, Public domain, via Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Condylura.jpg)

You could also force a newline by putting a blank line between the image and the credit line, but usually we want the credit to be small and right under the image, and inserting an extra line will make a space between the image and the credit line.

(It's also possible to force a newline at the end of the line by putting two trailing spaces at the end of a line, but one of the principles of Markdown is that you should easily be able to look at the raw text and know what's going on. Two trailing spaces are basically invisible. So that's why putting an explicit break tag is probably better.)

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

Sometimes Markdown has markup for the page feature you want, but it doesn't look or work the way you want. 

**Hyperlinks**

For example, when we wanted to add a link, we used Markdown's link syntax like this:

```
You can read more about them by going to their [Wikipedia page](https://en.wikipedia.org/wiki/Star-nosed_mole).
```

which will be rendered like this:

You can read more about them by going to their [Wikipedia page](https://en.wikipedia.org/wiki/Star-nosed_mole).

However, it can be annoying if a link leads you away from the page you are reading. (Try clicking on the link to see what happens.) If you want the link to open in a new tab, you need to use HTML to create the link using an anchor (`<a>`) element with a `target` attribute, like this:

```
You can read more about them by going to their <a href="https://en.wikipedia.org/wiki/Star-nosed_mole" target="_blank">Wikipedia page</a>.
```

which will be rendered like this:

You can read more about them by going to their <a href="https://en.wikipedia.org/wiki/Star-nosed_mole" target="_blank">Wikipedia page</a>.

If you click on the link above, you'll see that the link now opens in a new tab.

**Images**

If we want to insert an image, we can use the Markdown markup for images, which looks like this:

```
![screenshot from Wikipedia](../images-pages/screenshot.png)
```

and renders like this:

![screenshot from Wikipedia](../images-pages/screenshot.png)

However, for images like screenshots, it can be confusing if the image isn't outlined. To add a black line around the image, we can use HTML markup:

```
<img src="../images-pages/screenshot.png" alt="screenshot from Wikipedia" style="border:1px solid black">
```

which renders like this

<img src="../images-pages/screenshot.png" alt="screenshot from Wikipedia" style="border:1px solid black">

and makes it more apparent where the screenshot begins and ends.


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

Here's how to make a table using HTML tags:

```
<table style="border: none; width: unset">
<tr style="border: none;"><th style="border: none;">First Header</th><th style="border: none;">Second Header</th></tr>
<tr style="border: none;"><td style="border: none;">Content cell 1</td><td style="border: none;">Content cell 2</td></tr>
<tr style="border: none;"><td style="border: none;">Content column 1</td><td style="border: none;">Content column 2</td></tr>
</table>
```

The table renders like this

<table style="border: none; width: unset">
<tr style="border: none;"><th style="border: none;">First Header</th><th style="border: none;">Second Header</th></tr>
<tr style="border: none;"><td style="border: none;">Content cell 1</td><td style="border: none;">Content cell 2</td></tr>
<tr style="border: none;"><td style="border: none;">Content column 1</td><td style="border: none;">Content column 2</td></tr>
</table>

In the style for the table element, I unset the width to override the width setting set by the theme CSS.

Although it is not a best practice for accessibility, borderless tables like the one above can be used to organize content on the page. Here's an example:

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

Notice that it doesn't matter whether I put the tags on the same line or different lines. As rendered, it looks like this:

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

Notice that when I put the images inside the table, I had to use HTML markup to display the image, not the Markdown markup for displaying images.

[return to: Creating a website with GitHub pages](../../../script/codegraf/043/)

----
Revised 2022-02-23
