---
layout: post
title: "Color Factory: Color scheme generators"
date: 2010-12-29
comments: false
url: /2010/12/color-factory-color-scheme-generators.html
permalink: /2010/12/color-factory-color-scheme-generators.html
tags:
 - javascript
 - color
 - visualization
---

While working on a spin-off from [bedsider](http://bedsider.org/), I created [Csster](https://github.com/ndp/csster). Alex @ C5 encouraged me (and coached me a bit) on getting through functions around color math, and as far as I know, the functions in Csster is the only Javascript implementations. I find the invaluable as I build out Javascript functionality, and I [am working on](https://github.com/ndp/jsutils/blob/master/color_helpers.js) separating them out from Csster itself.

Building my own visualizations, I've needed to bone-up on color theory. I thought I'd share what I've learned.

  

I've always been a interested in color-- mixing paints, collecting "color" items as a child, and design class in college. I've delved in deep in the past and have a good understanding from a theory of it. Most recently I caught up on the computational side of it, writing a Javascript library to help manage colors. To be honest, I still lack the practical experience necessary to have a great intuitive feel for colors, but I'm getting there.

  

**Schemes & Tools**

There are numerous software tools out on the web, and available for download, for creating colors schemes. Most are general free-for-alls-- paste in some hex codes please-- and offer no assistance, beyond live preview, tagging, named schemes or Google ads. The best of the bunch is probably the flashy [Kuler](http://kuler.adobe.com/).

  

The ones I like better (like [Color Scheme Designer](http://colorschemedesigner.com/)) bring to the forefront [categories stemming from color theory and a color wheel](http://en.wikipedia.org/wiki/Color_scheme), selecting a set of colors from a single tangent (monochrome), opposite sides (complementary), analogic (or analogous, for nearby). There are also triadic (3) and a host of variations and combinations of these. It's this type of color theory that designers study and provides the necessary grounding to understand a design and a "scheme" that supports it.

  

  
As I poke around building [more](http://uxspoke.com/) [visualizations](http://www.ndpsoftware.com/git-cheatsheet.html), I quickly found that I needed "color schemes"-- not so much color manipulation as coherent sets of colors. I started building my own tools, and then stopped, and stepped back to understand the theory behind color schemes. One of the easiest from Cynthia Brewer [here](http://www.personal.psu.edu/cab38/ColorSch/Schemes.html). Ms. Brewer explains a few different types of color schemes specific to data visualization: binary, qualitative, linear, and divergent.   

- **Sequential schemes** are suited to ordered data that progress from low to high. Lightness steps dominate the look of these schemes, with light colors for low data values to dark colors for high data values.
- **Diverging schemes** put equal emphasis on mid-range critical values and extremes at both ends of the data range. The critical class or break in the middle of the legend is emphasized with light colors and low and high extremes are emphasized with dark colors that have contrasting hues.  
- **Qualitative schemes** do not imply magnitude differences between legend classes, and hues are used to create the primary visual differences between classes. Qualitative schemes are best suited to representing nominal or categorical data. 
Using these schemes could bring sanity to lots of charting libraries out there-- and it's quite sad that they don't support such technology.  
  
I'm building a "color factory" to provide functions for these. Provide the functions one (or two) colors from your palette and get a cohesive "color scheme" that should work with it-- and even better-- be appropriate to the data. These are all found in what I call the [color factory](https://github.com/ndp/jsutils/blob/master/color_factory.js). It's nascent technology, and I'm interested in feedback.   
  
In the next post, I'll dig into the Javascript functions that facilitate this. (All this is part of a generic [Javascript sketchbook](https://github.com/ndp/jsutils).) 
