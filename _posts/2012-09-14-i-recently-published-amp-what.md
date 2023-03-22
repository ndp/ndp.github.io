---
layout: post
title: "&what?"
date: 2012-09-14
comments: false
url: /2012/09/i-recently-published-amp-what.html
permalink: /2012/09/i-recently-published-amp-what.html
tags:
 - css
 - experience
 - software development
 - mobile
 - ux
 - javascript
 - prototyping
 - mini-project
 - html
 - unicode
---

  
I recently published [amp-what.com](https://www.amp-what.com/). I created it to solve a problem I have:  trying to remember (or google) character entity numbers or names. For example, our last project used the entity » (»). Try googling this if you don't remember the name! Now, with this tool, I can just type ">>" and the character, symbol and number appear.  
  
It turned out to be surprisingly fun to play with. I discovered [chess pieces](http://amp-what.com/#q=chess), [planet symbols](http://amp-what.com/#q=planet), [all sorts of boxes](https://www.amp-what.com/unicode/search/box). There are a surprising number of icons to play with. What have you found that surprise you?  
  
I initially sourced the tool with the standard 100 or so entities from W3C. Then I supplemented this with 10,000 interesting Unicode characters, and a nice set of entity synonyms from Remy Sharp (whose site is solving the same problem). Seeing that people were sometimes getting no results, I pulled in an internet jargon file for non-conventional names, and supplemented myself, by manually coding them. I am interested in adding more, but want to keep it "offline friendly", which means not too large.  
  
I was intrigued by **mobile web apps**: I tried to make it "mobile friendly", and the initial version was "small"; small enough to fit on an iPhone screen. This ended up looking sad on larger screens, so that clearly is not the answer. I recently refreshed it with a _responsive design_ approach. Now it uses the screen space nicely on both small and large screens.  
  
I also wanted to **build an HTML5 _offline app_**. For those of you with an iDevice, you can save to the home screen and have the reference available whether you are online or not.  
  
But beyond being mobile "friendly," I believe that HTML5 offers a good alternative to building a native app. I wanted to push the UX and see if I could get it to feel _as responsive as a native app_-- I think it does a pretty good job at executing quick searches, but I'll leave it up to you to judge.  
  
**Since the initial prototype, I've layered in a few features:**  It wanted to be able to link to certain queries, so I used the hashtag to do that, so you can share your favorite queries.  
  
I allow changing the font (using the small (f) in the bottom right corner).  
  
I found myself wanting to use the Unicode characters in different contexts: not only web pages, but Javascript source and CSS files. I've added some ability to customize the display-- hex, decimal, Javascript, or URL encoded. Those controls are also at the bottom of the screen.  
  
[Check it out](https://www.amp-what.com/), bookmark it, and please send me feedback.  
