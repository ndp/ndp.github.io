---
layout: post
title: "AlignColumn jQuery Plugin"
date: 2013-04-09
comments: false
url: /2013/04/align-column-jquery-plugin.html
permalink: /2013/04/align-column-jquery-plugin.html
tags:
 - css
 - design
 - ux
 - javascript
 - style
 - mini-project
 - html
 - jQuery
---

I recently released a new jQuery plugin [Align Column](https://github.com/ndp/align-column)that  aligns HTML table columns based on the (U.S.) decimal point – or whatever you want. Here's a brief story of why I wrote it.

  
My first job in Silicon Valley was to build the "ultimate" publishing platform during the early desktop publishing days. From this experience, I received in-depth mentoring on page layout, and I learned to enjoy the fine details (even though the company didn't enjoy success). After moving away from word processors, though, I didn't dabble much in typography. I recently picked up a copy of [The Elements of Typographic Style](http://www.amazon.com/gp/product/0881792063/ref=as_li_qf_sp_asin_tl?p%20ie=UTF8&camp=1789&creative=9325&creativeASIN=0881792063&linkCode=as2&tag=ndso-20) ![](http://www.assoc-amazon.com/e/ir?t=ndso-20&l=as2&o=1&a=0881792063) and really enjoyed it.
  

This reminded me what a stagnant hole HTML put us in. HTML defined a new layout engine that largely dictated what people expected from text and the documents they look at on their screen, and to some extent any computer-generated documents. But HTML has many limitations, and we've spent years narrowing down our font selection, reducing resolutions, compromising color selection and cringing at widows and orphans.
  

Finally we're coming out of that hole. The concept of responsive design is finally recognizing the web as its own medium, and we are no longer designing for letter-width, A4, or whatever the heck 960px emulates. Designers are finally giving up these print-based precepts of fixed-sized designs, and recognizing the web for what it is: a dynamic and fluid medium. In concert with this evolution, we're freeing the web and using capabilities we've had all along: interactions, animations, and sound. We are finally designing for the medium, both its weaknesses and strengths.
  

Part of this Renaissance is a host of new tools to give us more control over that medium-- we now have the ability to embed nearly any digital font. Yes, we had options to provide the user with any typeface all along, but the convenience of downloadable fonts makes it usable on a daily basis. So now that we are rendering nicer fonts, we need to upgrade our typography. That's one reason I was reading [The Elements of Typographic Style](http://www.amazon.com/gp/product/0881792063/ref=as_li_qf_sp_asin_tl?p%20ie=UTF8&camp=1789&creative=9325&creativeASIN=0881792063&linkCode=as2&tag=ndso-20).
  

The decimal alignment problem sparked my interest. It's simple: a column of numbers is easier to compare if they are aligned on decimal points instead of "right aligned". The usual workaround is to add extra zeroes and use a typeface with fixed-width numbers. This is a reasonable compromise, but does not work with significant digits of numbers must be expressed. In scientific tables, `10.0` is quite different from `10.000`.  I did a little research and found that there were some abandoned CSS3 properties to solve this, but really no good solution.
  

My  jQuery plugin [$.alignColumn()](https://raw.github.com/ndp/align-column) does the trick. Just tell it which columns contain decimal numbers and it can align them. For example, it changes:
  

 ![](https://raw.github.com/ndp/align-column/master/examples/decimals-right.png)
  

to the busier, but easier to parse:
  

 ![](https://raw.github.com/ndp/align-column/master/examples/decimals-after.png)

  

It's also easy to center based on characters besides a decimal separator:

  

 ![](https://raw.github.com/ndp/align-column/master/examples/other-characters-after.png)

  

Finally, just to check myself, I grabbed a scientific table from Wikipedia and tried to get the columns to align sanely. See for yourself how [gawd awful plain HTML](http://en.wikipedia.org/wiki/List_of_elements) is. You can see the "alignColumn" enhanced version, which was created with _no markup changes_. See the nice [table of chemical elements](http://ndpsoftware.com/align-column/examples/chemical_elements.html), and see how the scientific precision of values is preserved and can be compared.

  

 ![](https://raw.github.com/ndp/align-column/master/examples/chemicals.png)

  

Usage is pretty easy, and doesn't require you modify your original markup. Give [the plugin](https://raw.github.com/ndp/align-column) a spin.
