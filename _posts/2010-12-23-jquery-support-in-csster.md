---
layout: post
title: "jQuery support in Csster"
date: 2010-12-23
comments: false
url: /2010/12/jquery-support-in-csster.html
permalink: /2010/12/jquery-support-in-csster.html
tags:
 - browser
 - css
 - csster
 - design
 - javascript
 - style
 - sass
 - jQuery
---

I finally got around to adding a little jQuery plugin for my [Csster tool](http://github.com/ndp/csster), and released it as version 0.9.2.

> $('.selector').csster({ width: 100 });

This looks a lot like the "css" method:  

> $('.selector').css({ width: 100 });

This difference is that Csster creates a "rule" and inserts it into the head, whereas jQuery will attach styles directly to the nodes. Sometimes you want one, and sometimes another.  
  
It's convenient to use it in the midst of jQuery work, such as:  

> $('.sidebar').wrapAll('<div>').addClass('ready').csster({backgroundColor: '#ffeedd'});

It's also allows the "nesting" of regular Csster:  

> $('.hd').csster({ ul: { margin: 10, li: { margin: 0, padding: 5 }}});

Although it warrants its own post, I added a little note about how to implement clean browser-compatible patches. In the example, csster  supports the "opacity" property name in IE by writing a simple Csster plugin that run only within the IE environment and applies the patch. Much nicer than subtler raw CSS solutions... more to come.  
  
Check it out: [http://github.com/ndp/csster](http://github.com/ndp/csster)
