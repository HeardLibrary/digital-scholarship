---
permalink: /manage/control/github/pages-remotes/
title: Skins and modifying CSS
breadcrumb: Pages CSS
---

[return to: Creating a website with GitHub pages](../../../script/codegraf/043/)

# Changing the styling of a remote theme

One of the reasons for creating a GitHub Pages website is to be able to pick a theme that already has the styling you want and avoid coding CSS yourself. However, sometimes a theme may be almost exactly what you want but needs a slight tweek to the styling, such as changing the default font or colors for the theme.

For example, this website is built using the built-in theme [Leap Day](https://github.com/pages-themes/leap-day). However, if you look at [the theme preview], you will see that there are a number of changes that have been made to the theme -- most obviously the theme colors and font.  

Here is a simple homepage using the Leap Day theme that I'll use in the following examples:

<img src="../images-pages/bare_leap_day.png" alt="bare bones Leap Day homepage" style="border:1px solid black">

## Modifying the default stylesheet

The exact way to change the CSS depends on how complicated the theme is. The default styles are typically in a directory called `_sass`. There may be a number of files within that directory having `.scss` file extensions, so it can be a challenge to figure out which one to change. In the case of the Leap Day theme, there are relatively few in the [_sass directory](https://github.com/pages-themes/leap-day/tree/master/_sass) and the one that actually controlls things is [
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

then edit it using my code editor. You can use the "inspect" feature of your browser to figure out what part of the CSS controls the different sections of the page. Once you've identified the HTML element you need to change, click on the element name and look in the CSS description for that element to see what setting needs to be changed. In most browsers, you can check or uncheck a box to turn settings on and off. 

In this case, I see that the `header` element is the top bar with a level 1 (h1) header, and the `#banner` is the yellow bar below it. I can change their colors like this:

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

In some cases, the theme developers make it easy for you to customize the appearance of the theme by providing pre-set *themes*. A theme is a selectable style that can easily be switched by a simple configuration change. Here is an example from the [theme Hamilton](https://github.com/zivong/jekyll-theme-hamilton):

<img src="../images-pages/hamilton_skins.png" alt="skin examples from Hamilton theme" style="border:1px solid black">

I will switch to this theme by changing the theme designation in my `_config.yml` file to

```
remote_theme: zivong/jekyll-theme-hamilton
title: Test website
```

and adding a website title. The `Hamilton` theme is interesting because it changes the skin dynamically depending on the time of day. Here's how it renders in the morning with the skin `sunrise`:

<img src="../images-pages/default_skin.png" alt="Hamilton sunrise skin" style="border:1px solid black">

To set a specific skin, change the setting in `_config.yml`. For example, to use the skin `midnight`, add:

```
skin: midnight
```

Here's how it looks after the change:

<img src="../images-pages/midnight_skin.png" alt="Hamilton midnight skin" style="border:1px solid black">

According to the instructions on the GitHub site, you can change the skin by creating a copy of an existing skin under a different name and then changing colors as desired. I created a directory called `skins` in the path `/docs/_sass/hamilton/skins/`, downloaded the `midnight` skin, and changed its name to `pinky.scss`.

<img src="../images-pages/skins_path.png" alt="path to skins directory" style="border:1px solid black">

I went to the [W3Schools HTML Color Picker](https://www.w3schools.com/colors/colors_picker.asp) and clicked on Fuchsia, which has the code `#ff00ff`. I then edited the `$background-color` value in the `pinky.scss` file:

<img src="../images-pages/change_background_pink.png" alt="change background to pink" style="border:1px solid black">

In `_config.yml` I changed the skin setting to:

```
skin: pinky
```

and pushed the changed files to GitHub. Now the homepage looks like this:

<img src="../images-pages/pink_background.png" alt="homepage with pink background" style="border:1px solid black">

Probably needs a bit of work to be readable, but you get the idea.

Not every theme will make it this easy to customize its style. But by carefully examining the documentation on the theme's GitHub page, you should have a pretty good idea of how much customization is possible with the theme.

[return to: Creating a website with GitHub pages](../../../script/codegraf/043/)

----
Revised 2022-02-23
